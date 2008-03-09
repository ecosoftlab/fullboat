require File.dirname(__FILE__) + '/../test_helper'

class RoleTest < Test::Unit::TestCase
  fixtures :roles
  
  def test_should_create_role
    assert_difference 'Role.count' do
      role = create_role
      assert ! role.new_record?, "#{role.errors.full_messages.to_sentence}"
    end
  end
  
protected

  def create_role(options = {})
    Role.create(@@role_default_values.merge(options))
  end
end
