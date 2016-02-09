require 'test_helper'

class CalendarTest < ActiveSupport::TestCase

  def at
    Date.new 2016, 2, 9
  end

  def calendar
    Calendar.new(at)
  end

  test 'build_week' do
    assert calendar.build_week.class == Array
  end

  test 'the first value is the first day of the week' do
    assert calendar.build_week.first == at.at_beginning_of_week
  end
end
