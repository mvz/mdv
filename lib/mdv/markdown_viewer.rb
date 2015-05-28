require 'gir_ffi-gtk3'
GirFFI.setup :WebKit, '3.0'

module MDV
  # Markdown viewer window class
  class MarkdownViewer
    attr_reader :file

    def initialize(file)
      @file = file
      setup_gui
      reload
      connect_signals
      @win.show_all
    end

    private

    def connect_signals
      connect_key_press_event_signal
      connect_destroy_signal
    end

    def connect_destroy_signal
      @win.signal_connect('destroy') { Gtk.main_quit }
    end

    def connect_key_press_event_signal
      @win.signal_connect 'key-press-event' do |_wdg, evt, _ud|
        handle_key(evt) if evt.state == :control_mask
        false
      end
    end

    def handle_key(evt)
      case evt.keyval
      when 'q'.ord
        @win.destroy
      when 'r'.ord
        reload
      end
    end

    def setup_gui
      @win = Gtk::Window.new :toplevel
      @win.set_default_geometry 700, 500

      @win.add scrolled_window
    end

    def scrolled_window
      @scr ||= Gtk::ScrolledWindow.new(nil, nil).tap do |it|
        it.add web_view
      end
    end

    def web_view
      @wv ||= WebKit::WebView.new
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
      web_view.load_string html, nil, nil, base_uri
    end
  end
end
