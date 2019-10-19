# frozen_string_literal: true

require_relative "../test_helper"

require "mdv/document"

describe MDV::Document do
  let(:document) { MDV::Document.new("test/fixtures/test.md") }

  describe "#html" do
    it "renders the correct html" do
      _(document.html)
        .must_equal "<h1>Test</h1>\n\n<p>This is a test document.</p>\n"
    end
  end
end
