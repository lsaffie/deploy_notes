require "test_helper"

class LocalTest < Minitest::Test
  def returns_as_expected
    local =  DeployNotes::Local.new
    assert local.get != nil
  end
end
