require 'mechanize'

class IstatusWatcher
  STATUSI = ["AVL","DSP","ENR","TRN","ARV","AV1","INC","OFF","ONS","ORP","ENH","ONH","AOS","OOD","OOS","AAS"]
  
  def fetch_call_info(incident_number)
    agent = Mechanize.new
    login(agent)
    page = agent.get("https://istatus.gocolumbiamo.com/DisplayCall.php?Incid=#{incident_number}")
    notes = page.parser.xpath("/html/body/table/tr[3]/table/tr/td/table/tr").map{|node| {:time=>node.children[0].text,:text=>node.children[1].text.gsub("\n","")}}
    if notes.size == 0
      page = agent.get("https://istatus.gocolumbiamo.com/DisplayFireCall.php?Incid=#{incident_number}")
      notes = page.parser.xpath("/html/body/table/tr[3]/table/tr/td/table/tr").map{|node| {:time=>node.children[0].text,:text=>node.children[1].text.gsub("\n","")}}
    end
    call_info = {:id=>incident_number}
    call_info[:address] = page.links_with(:href=>/SearchDStatsSubmit\.php\?Address/).first.text
    call_info[:nature] = page.parser.xpath("/html/body/table/tr[1]/td[1]/table/tr[3]/td").text.strip.split("-").last
    call_info[:apparatus] = page.parser.xpath("/html/body/table/tr[1]/td[2]/table/tr/td[1]").map{|c| c.text.gsub("\n","").strip}
    call_info[:raw_notes] = notes.map{|n| "#{n[:time]} #{n[:text]}"}.join("|")
    spliced_notes = {}
    notes.select{|n| n[:text] =~ /[\(\[]\d+-\d+[\)\]]$/}.each do |note|
      note_text = note[:text]
      note_text_arr = note_text.split(/\s/)
      token = note_text_arr.delete_at(note_text_arr.size - 1)
      final_text = note_text_arr.join(" ")
      if spliced_notes[token].nil?
        spliced_notes[token] = [{:time=>note[:time],:text=>final_text}]
      else
        spliced_notes[token] << {:time=>note[:time],:text=>final_text}
      end
    end
    call_info[:notes] = {:pro_qa=>notes.select{|n| n[:text] =~ /^ProQA/},
                         :incidentals=>notes.select{|n| n[:text] =~ /^\s*\*/},
                         :operators=>spliced_notes}
    return call_info
  end
  
  def how_many_available?
    match_medic_link_nodes(/TruckID=M(11|15|21|22|23)\d/).size
  end
  
  def medic_available?(medic_number)
    match_medic_link_nodes(/TruckID=M#{medic_number}/).size >= 1
  end
  
  def medic_status?(medic_number)
    STATUSI.each do |status|
      if match_medic_link_nodes(/TruckID=M#{medic_number}/,status).size >= 1
        return status
      end
    end
    return "OOS"
  end
  
  def match_medic_link_nodes(regex,status = "AVL")
    page = fetch_medic_page
    nodes = page.parser.css("a.#{status}")
    nodes.map{|node| node.attributes["href"].value}.select{|val| val =~ regex}
  end
  
  def fetch_medic_page
    if @medic_page.nil?
      agent = Mechanize.new
      login(agent)
      add_medic_page_cookie(agent)
      @medic_page = agent.get("https://istatus.gocolumbiamo.com/AjaxTS2.php")
    end
    return @medic_page 
  end
  
  def login(agent)
    form = agent.get('http://istatus.gocolumbiamo.com/').form("UserForm")
    form.UserName = "bf.swish"
    form.Password = "1414"
    agent.submit(form, form.buttons.first)
  end
  
  def add_medic_page_cookie(agent)
    cookie = Mechanize::Cookie.new("TScreen","4")
    cookie.secure = false
    cookie.domain = "istatus.gocolumbiamo.com"
    agent.cookie_jar.jar["istatus.gocolumbiamo.com"]["/"]["TScreen"] = cookie
  end
end