def Fixnum
  def am
    raise "AM, number must be 0-12" if self < 0 || self > 12
    Time.parse("#{self}:00:00")
  end

  def pm
    raise "PM, number must be 0-12" if self < 0 || self > 12
    Time.parse("#{self+12}:00:00")
  end
end