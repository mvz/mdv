# MDV

Simple Markdown Viewer for GNOME 3.

## Usage

    mdv README.md

Press Ctrl-R to reload, Ctrl-Q to quit, Ctrl-C to copy selected text. Clicked
links open in default browser.

## Install

    gem install mdv

## Dependencies

MDV depends on the `gir_ffi-gtk` gem. Additionally, you need to install the
Webkit2Gtk library and its gobject-introspection information. On Debian and
Ubuntu, the following should work:

    sudo apt-get install gir1.2-webkit2-4.0

On Ubuntu, you may also have to install two additional packages:

    sudo apt-get install libwebkit2gtk-4.0-dev libjavascriptcoregtk-4.0-dev

## Contributing

Contributions are welcome! Please feel free to create issues or pull requests
on GitHub.

## License

Copyright &copy; 2012&ndash;2019 [Matijs van Zuijlen](http://www.matijs.net).
See LICENSE for details.
