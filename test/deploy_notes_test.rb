require "test_helper"

class DeployNotesTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::DeployNotes::VERSION
  end

end
