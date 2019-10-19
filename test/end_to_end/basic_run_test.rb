# frozen_string_literal: true

require_relative "../test_helper"
require "gnome_app_driver"

# Test driver for the MDV application.
class MDVDriver < GnomeAppDriver
  def initialize
    super "mdv"
  end

  def boot(filename)
    super arguments: [filename]
  end
end

describe "The MDV application" do
  before do
    @driver = MDVDriver.new
    @driver.boot("README.md")
  end

  it "starts and can be quit with Ctrl-q" do
    @driver.press_ctrl_q

    status = @driver.cleanup
    _(status.exitstatus).must_equal 0
  end

  after do
    @driver.cleanup
  end
end
