require File.dirname(__FILE__) + '/../test_helper'

class LabelTest < Test::Unit::TestCase
  fixtures :labels

  def test_should_create_label
    assert_difference 'Label.count' do
      label = create_label
      assert ! label.new_record?, "#{label.errors.full_messages.to_sentence}"
    end
  end
  
protected

  def create_label(options = {})
    Label.create(@@label_default_values.merge(options))
  end
end
