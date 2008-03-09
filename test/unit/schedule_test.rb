require File.dirname(__FILE__) + '/../test_helper'

class ScheduleTest < Test::Unit::TestCase
  fixtures :schedules

  def test_should_create_schedule
    assert_difference 'Schedule.count' do
      schedule = create_schedule
      assert ! schedule.new_record?, "#{schedule.errors.full_messages.to_sentence}"
    end
  end
  
protected

  def create_schedule(options = {})
    Schedule.create(@@schedule_default_values.merge(options))
  end
end
