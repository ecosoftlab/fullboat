require File.dirname(__FILE__) + '/../test_helper'

class PSATest < Test::Unit::TestCase
  fixtures :psas

  def test_should_create_psa
    assert_difference 'PSA.count' do
      psa = create_psa
      assert ! psa.new_record?, "#{psa.errors.full_messages.to_sentence}"
    end
  end
  
protected

  def create_psa(options = {})
    PSA.create(@@psa_default_values.merge(options))
  end
end
