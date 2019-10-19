# frozen_string_literal: true

require "gir_ffi-gtk3"
require "mdv/document"

GirFFI.setup :WebKit2, "4.0"

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
      @win.signal_connect("destroy") { Gtk.main_quit }
    end

    def connect_key_press_event_signal
      @win.signal_connect "key-press-event" do |_wdg, evt, _ud|
        handle_key(evt) if evt.state[:control_mask]
        false
      end
    end

    def connect_web_view_signals
      web_view.signal_connect("context-menu") { true }
      web_view.signal_connect("decide-policy") do |_wv, decision, decision_type|
        handle_decide_policy(decision, decision_type)
      end
    end

    def handle_key(evt)
      case evt.keyval
      when "q".ord
        @win.destroy
      when "r".ord
        reload
      end
    end

    def handle_decide_policy(decision, decision_type)
      case decision_type
      when :navigation_action
        action = decision.navigation_action
        if action.user_gesture?
          Gtk.show_uri_on_window(@win, action.request.uri, 0)
          true
        end
      when :new_window_action
        true
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
      @web_view ||= WebKit2::WebView.new
    end

    def reload
      web_view.load_html @document.html, @document.base_uri
    end
  end
end
