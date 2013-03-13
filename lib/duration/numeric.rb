require 'duration/time_units'

class Numeric
  def duration
    Duration.new self
  end

  def dyears
    self == 1 ? Year.new : Years.new(self)
  end
  def dyear
    self.dyears
  end

  def dmonths
    self == 1 ? Month.new : Months.new(self)
  end
  def dmonth
    self.dmonths
  end

  def dweeks
    self == 1 ? Week.new : Weeks.new(self)
  end
  def dweek
    self.dweeks
  end

  def ddays
    self == 1 ? Day.new : Days.new(self)
  end
  def dday
    self.ddays
  end

  def dhours
    self == 1 ? Hour.new : Hours.new(self)
  end
  def dhour
    self.dhours
  end

  def dminutes
    self == 1 ? Minute.new : Minutes.new(self)
  end
  def dminute
    self.dminutes
  end

  def dseconds
    self == 1 ? Second.new : Seconds.new(self)
  end
  def dsecond
    self.dseconds
  end

  def is_multiple_of?(num)
    self % num == 0
  end
end
