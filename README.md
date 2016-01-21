# MDV

Simple Markdown Viewer for GNOME 3.

## Usage

    mdv README.md

Press Ctrl-R to reload, Ctrl-Q to quit.

## Install

    gem install mdv

## Dependencies

MDV needs some additional software installed in order to work.

### Debian

The following should work:

    sudo apt-get install libgirepository1.0-dev gobject-introspection
    sudo apt-get install libwebkitgtk-3.0-dev

### Other OS

To be determined. Please contribute back your experience in getting MDV running
on your favorite operation system.

## Contributing

Contributions are welcome! Please feel free to create issues or pull requests
on GitHub.

If you want to run the tests, you may need to install additional packages:

    sudo apt-get install gir1.2-atspi-2.0 libatk-adaptor

## License

Copyright &copy; 2012&ndash;2016 [Matijs van Zuijlen](http://www.matijs.net).
See LICENSE for details.
