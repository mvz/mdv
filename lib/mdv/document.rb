# frozen_string_literal: true

require "commonmarker"

module MDV
  # Markdown document class
  class Document
    def initialize(file)
      @file = file
    end

    def base_uri
      @base_uri ||= "file://#{fullpath}"
    end

    def html
      content = File.read(fullpath)
      Commonmarker.to_html(content,
        options: {render: {hardbreaks: false},
                  extension: {tagfilter: true,
                              autolink: true,
                              table: true,
                              strikethrough: true,
                              header_ids: nil}},
        plugins: {})
    end

    private

    def fullpath
      @fullpath ||= File.expand_path(@file, Dir.pwd)
    end
  end
end
