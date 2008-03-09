require File.dirname(__FILE__) + '/../test_helper'

class PromoTest < Test::Unit::TestCase
  fixtures :promos

  def test_should_create_promo
    assert_difference 'Promo.count' do
      promo = create_promo
      assert ! promo.new_record?, "#{promo.errors.full_messages.to_sentence}"
    end
  end
  
protected

  def create_promo(options = {})
    Promo.create(@@promo_default_values.merge(options))
  end
end
