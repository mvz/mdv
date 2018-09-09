# frozen_string_literal: true

require 'webkit2-gtk'
require 'mdv/document'

module MDV
  # Markdown viewer window class
  class MarkdownViewer
    def initialize(file)
      @document = Document.new(file)
      setup_gui
      reload
      connect_signals
      @win.show_all
    end

    private

    def connect_signals
      connect_key_press_event_signal
      connect_destroy_signal
      connect_web_view_signals
    end

    def connect_destroy_signal
      @win.signal_connect('destroy') { Gtk.main_quit }
    end

    def connect_key_press_event_signal
      @win.signal_connect 'key-press-event' do |_wdg, evt, _ud|
        handle_key(evt) if evt.state.control_mask?
        false
      end
    end

    def connect_web_view_signals
      web_view.signal_connect('context-menu') { true }
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
      @scrolled_window ||= Gtk::ScrolledWindow.new(nil, nil).tap do |it|
        it.add web_view
      end
    end

    def web_view
      @web_view ||= WebKit2Gtk::WebView.new
    end

    def reload
      web_view.load_html @document.html, @document.base_uri
    end
  end
end
