# frozen_string_literal: true

require_relative "../test_helper"

require "mdv/document"

describe MDV::Document do
  let(:fixtures_dir) { File.expand_path("../fixtures/", __dir__) }
  let(:document) { MDV::Document.new(File.join(fixtures_dir, "test.md")) }
  let(:readme) { MDV::Document.new(File.expand_path("../../README.md", __dir__)) }

  describe "#html" do
    it "renders the correct html" do
      _(document.html)
        .must_equal "<h1>Test</h1>\n<p>This is a test document.</p>\n"
    end

    it "renders the correct html for this project's README" do
      expected = File.read File.join(fixtures_dir, "README.html")

      _(readme.html).must_equal expected
    end
  end
end
