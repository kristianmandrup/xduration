# -*- encoding:  utf-8 -*-
require 'helper'
require 'duration/macros'

describe 'Numeric duration macros' do
  it "duration" do
    d = (60 + 30).duration
    assert_equal 30, d.seconds
    assert_equal 90, d.total
  end

  it "dseconds" do
    d = 3.dseconds
    assert_equal 3, d.seconds
    assert_equal 3, d.total
  end

  it "dminutes" do
    d = 3.dminutes
    assert_equal 3, d.minutes
    assert_equal 3 * 60, d.total
  end

  it "dhours" do
    d = 3.dhours
    assert_equal 3, d.hours
    assert_equal 3 * 3600, d.total
  end

  it "ddays" do
    d = 3.ddays
    assert_equal 3, d.days
    assert_equal 3 * 24 * 3600, d.total
  end

  it "dweeks" do
    d = 3.dweeks
    assert_equal 3, d.weeks
    assert_equal 3 * 7 * 24 * 3600, d.total
  end

  it "dmonths" do
    d = 3.dmonths
    assert_equal 3, d.months
    assert_equal 3 * 30 * 24 * 3600, d.total
  end

  it "dyears" do
    d = 3.dyears
    assert_equal 3, d.years
    assert_equal 3 * 365.25 * 24 * 3600, d.total
  end
end


describe Seconds do
  it "should be a duration" do
    d = Seconds.new(3)
    assert_equal 3, d.seconds
    assert_equal 3, d.total
  end
end

describe Second do
  it "should be a duration" do
    d = Second.new
    assert_equal 1, d.seconds
    assert_equal 1, d.total
  end
end

describe Minutes do
  it "should be a duration" do
    d = Minutes.new(3)
    puts d.inspect
    assert_equal 3, d.minutes
    assert_equal (3 * 60), d.total
  end
end

describe Minute do
  it "should be a duration" do
    d = Minute.new
    assert_equal 1, d.minutes
    assert_equal (1 * 60), d.total
  end
end

describe Hours do
  it "should be a duration" do
    d = Hours.new(3)
    assert_equal 3, d.hours
    assert_equal (3 * 60 * 60), d.total
  end
end

describe Hour do
  it "should be a duration" do
    d = Hour.new
    assert_equal 1, d.hours
    assert_equal (1 * 60 * 60), d.total
  end
end

describe Days do
  it "should be a duration" do
    d = Days.new(3)
    assert_equal 3, d.days
    assert_equal (3 * 24 * 60 * 60), d.total
  end
end

describe Day do
  it "should be a duration" do
    d = Day.new
    assert_equal 1, d.days
    assert_equal (1 * 24 * 60 * 60), d.total
  end
end

describe Weeks do
  it "should be a duration" do
    d = Weeks.new(2)
    assert_equal 2, d.weeks
    assert_equal (14 * 24 * 60 * 60), d.total
  end
end

describe Week do
  it "should be a duration" do
    d = Week.new
    assert_equal 1, d.weeks
    assert_equal (7 * 24 * 60 * 60), d.total
  end
end

describe Months do
  it "should be a duration" do
    d = Months.new(2)
    assert_equal 2, d.months
    assert_equal (2 * 30 * 24 * 60 * 60), d.total
  end
end

describe Month do
  it "should be a duration" do
    d = Month.new
    assert_equal 1, d.months
    assert_equal (30 * 24 * 60 * 60), d.total
  end
end


describe Years do
  it "should be a duration" do
    d = Years.new(2)
    assert_equal 2, d.years
    assert_equal (2 * 365.25 * 24 * 60 * 60), d.total
  end
end

describe Year do
  it "should be a duration" do
    d = Year.new
    assert_equal 1, d.years
    assert_equal (365.25 * 24 * 60 * 60), d.total
  end
end