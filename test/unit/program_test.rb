require File.dirname(__FILE__) + '/../test_helper'

class ProgramTest < Test::Unit::TestCase
  fixtures :programs
  
  def test_should_create_program
    assert_difference 'Program.count' do
      program = create_program
      assert ! program.new_record?, "#{program.errors.full_messages.to_sentence}"
    end
  end
  
protected

  def create_program(options = {})
    Program.create(@@program_default_values.merge(options))
  end
end
