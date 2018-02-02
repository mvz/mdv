# frozen_string_literal: true

require 'github/markup'

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
      GitHub::Markup.render(fullpath)
    end

    private

    def fullpath
      @fullpath ||= File.expand_path(@file, Dir.pwd)
    end
  end
end
