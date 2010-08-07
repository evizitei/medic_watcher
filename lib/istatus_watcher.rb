require 'mechanize'

class IstatusWatcher
  
  def how_many_available?
    agent = Mechanize.new
    page = agent.get('http://istatus.gocolumbiamo.com/')
    form = page.form("UserForm")
    form.UserName = "bf.swish"
    form.Password = "1414"
    page = agent.submit(form, form.buttons.first)
    cookie = Mechanize::Cookie.new("TScreen","4")
    cookie.secure = false
    cookie.domain = "istatus.gocolumbiamo.com"
    agent.cookie_jar.jar["istatus.gocolumbiamo.com"]["/"]["TScreen"] = cookie
    page = agent.get("https://istatus.gocolumbiamo.com/AjaxTS2.php")
    doc = page.parser
    nodes = doc.css("a.AVL")
    nodes.map{|node| node.attributes["href"].value}.select{|val| val =~ /TruckID=M\d{3}/}.size
  end
end