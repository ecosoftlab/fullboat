require File.dirname(__FILE__) + '/../test_helper'

class EventTest < Test::Unit::TestCase
  fixtures :events

  def test_should_create_event
    assert_difference 'Event.count' do
      event = create_event
      assert ! event.new_record?, "#{event.errors.full_messages.to_sentence}"
    end
  end
  
protected

  def create_event(options = {})
    Event.create(@@event_default_values.merge(options))
  end
end
