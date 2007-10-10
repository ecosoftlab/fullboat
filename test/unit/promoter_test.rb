require File.dirname(__FILE__) + '/../test_helper'

class PromoterTest < Test::Unit::TestCase
  fixtures :promoters

  # Replace this with your real tests.
  def test_name_validation
    blank_promoter = Promoter.new(:name => "")
    assert !blank_promoter.save
    long_promoter = Promoter.new(:name => "aldskfjasdfasjdfaslkdjfhsdflkjahsdflkjsdhflkjsdhf")
    assert long_promoter.save
    good_promoter = Promoter.new(:name => "Terrorbird")
    assert good_promoter.save
    duplicate_promoter = Promoter.new(:name => "Terrorbird")
    assert !duplicate_promoter.save
  end

  def test_email_validation
    #regexp does not cover all cases but works okay
    normal_email = Promoter.new(:name => "Fanatic", :email => "justin@fanaticpromotion.com")
    assert normal_email.save
    bad_email = Promoter.new(:name => "blah2 promos", :email => "blah blah@blah.com")
    assert !bad_email.save
    bad_email2 = Promoter.new(:name => "blah2 promos", :email => "blahblahblah.com")
    assert !bad_email2.save
    bad_email3 = Promoter.new(:name => "blah3 promos", :email => "blah&^%&@!blah@blah.com")
    assert !bad_email3.save
    bad_email4 = Promoter.new(:name => "blah4 promos", :email => "blahblah@blahcom")
    assert !bad_email4.save
  end


end
