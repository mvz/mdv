# frozen_string_literal: true

require "gir_ffi-gtk3"
require "mdv/document"

begin
  GirFFI.setup :WebKit2, "4.0"
rescue RuntimeError
  GirFFI.setup :WebKit2, "4.1"
end

module MDV
  # Markdown viewer window class
  class MarkdownViewer
    def initialize(win, file)
      @win = win
      @document = Document.new(file)
      setup_gui
      connect_actions
      reload
      connect_signals
    end

    private

    def connect_signals
      connect_web_view_signals
    end

    def connect_web_view_signals
      web_view.signal_connect("context-menu") { true }
      web_view.signal_connect("decide-policy") do |_wv, decision, decision_type|
        handle_decide_policy(decision, decision_type)
      end
    end

    def handle_decide_policy(decision, decision_type)
      case decision_type
      when :navigation_action
        action = decision.navigation_action
        if action.is_user_gesture
          Gtk.show_uri_on_window(@win, action.request.uri, 0)
          true
        end
      when :new_window_action
        true
      end
    end

    def setup_gui
      @win.add scrolled_window
      @win.set_default_size 700, 500
    end

    def connect_actions
      reload_action = Gio::SimpleAction.new("reload", nil)
      reload_action.signal_connect("activate") { reload }
      @win.add_action reload_action
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
