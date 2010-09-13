class MedicSweeper < ActionController::Caching::Sweeper
  observe MedicRecord # This sweeper is going to keep an eye on the Product model

  # If our sweeper detects that a Product was created call this
  def after_create(record)
    expire_page(:controller=>"main",:action=>"home")
  end

  # If our sweeper detects that a Product was updated call this
  def after_update(product)
    expire_page(:controller=>"main",:action=>"home")
  end

  # If our sweeper detects that a Product was deleted call this
  def after_destroy(product)
    expire_page(:controller=>"main",:action=>"home")
  end
end