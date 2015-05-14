require 'gir_ffi-gtk3'
GirFFI.setup :WebKit, '3.0'
module MDV
  class MarkdownViewer
    attr_reader :file

    def initialize file
      @file = file
      setup_gui
      reload
      connect_signals
      @win.show_all
    end

    def connect_signals
      @win.signal_connect 'key-press-event' do |wdg, evt, ud|
        if evt.state == :control_mask
          case evt.keyval
          when "q".ord
            @win.destroy
          when "r".ord
            self.reload
          end
        end
        false
      end

      @win.signal_connect("destroy") { Gtk.main_quit }
    end

    def setup_gui
      @win = Gtk::Window.new :toplevel
      @win.set_default_geometry 700, 500

      @scr = Gtk::ScrolledWindow.new nil, nil
      @wv = WebKit::WebView.new
      @win.add @scr
      @scr.add @wv
    end

    def fullpath
      @fullpath ||= File.expand_path(file, Dir.pwd)
    end

    def base_uri
      @base_uri ||= "file://#{fullpath}"
    end

    def html
      GitHub::Markup.render(fullpath)
    end

    def reload
      @wv.load_string html, nil, nil, base_uri
    end
  end
end
