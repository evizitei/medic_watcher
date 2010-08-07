require 'mechanize'

class IstatusWatcher
  
  def how_many_available?
    extract_available_medics_from(fetch_medic_page).size
  end
  
  def fetch_medic_page
    agent = Mechanize.new
    login(agent)
    add_medic_page_cookie(agent)
    agent.get("https://istatus.gocolumbiamo.com/AjaxTS2.php")
  end
  
  def extract_available_medics_from(page)
    nodes = page.parser.css("a.AVL")
    nodes.map{|node| node.attributes["href"].value}.select{|val| val =~ /TruckID=M(11|15|21|22|23)\d/}
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