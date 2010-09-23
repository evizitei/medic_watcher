require 'mechanize'

class IstatusWatcher
  STATUSI = ["AVL","DSP","ENR","TRN","ARV","AV1","INC","OFF","ONS","ORP","ENH","ONH","AOS","OOD","OOS","AAS"]
  
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