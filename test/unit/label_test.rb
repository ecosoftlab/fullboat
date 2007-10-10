require File.dirname(__FILE__) + '/../test_helper'

class LabelTest < Test::Unit::TestCase
  fixtures :labels

  # Replace this with your real tests.
  def test_name_validation
    blank_label = Label.new(:name => "")
    assert !blank_label.save
    long_label = Label.new(:name => "aldskfjasdfasjdfaslkdjfhsdflkjahsdflkjsdhflkjsdhf")
    assert long_label.save
    good_label = Label.new(:name => "Ghostly")
    assert good_label.save
    duplicate_label = Label.new(:name => "Ghostly")
    assert !duplicate_label.save
  end

  def test_email_validation
    #regexp does not cover all cases but works okay
    normal_email = Label.new(:name => "Warp Records", :email => "priya@warprecords.com")
    assert normal_email.save
    bad_email = Label.new(:name => "blah2 records", :email => "blah blah@blah.com")
    assert !bad_email.save
    bad_email2 = Label.new(:name => "blah2 records", :email => "blahblahblah.com")
    assert !bad_email2.save
    bad_email3 = Label.new(:name => "blah3 records", :email => "blah&^%&@!blah@blah.com")
    assert !bad_email3.save
    bad_email4 = Label.new(:name => "blah4 records", :email => "blahblah@blahcom")
    assert !bad_email4.save
  end

end
