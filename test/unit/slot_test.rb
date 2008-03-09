require File.dirname(__FILE__) + '/../test_helper'

class SlotTest < Test::Unit::TestCase
  fixtures :slots

  def test_should_create_slot
    assert_difference 'Slot.count' do
      slot = create_slot
      assert ! slot.new_record?, "#{slot.errors.full_messages.to_sentence}"
    end
  end
  
protected

  def create_slot(options = {})
    Slot.create(@@slot_default_values.merge(options))
  end
end
