module MainHelper
  def count_class(count)
    return "stable" if count >= 2
    (count == 0 ? "bad" : "warn")
  end
  
  def message_class(msg)
    return "warn" if msg =~ /City Status Is 1/
    return "bad" if msg =~ /City Status Is 0/
    return "stable"
  end
end
