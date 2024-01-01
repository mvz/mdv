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
      commonmarker_opts = [:GITHUB_PRE_LANG]
      commonmarker_exts = [:tagfilter, :autolink, :table, :strikethrough]
      CommonMarker.render_html(content, commonmarker_opts, commonmarker_exts)
    end

    private

    def fullpath
      @fullpath ||= File.expand_path(@file, Dir.pwd)
    end
  end
end
