# Change log

## 0.9.0 / 2024-05-17

* Support Ruby 3.1 through 3.3, dropping support for 3.0 ([#100] by [mvz])
* Update to commonmarker 1.0 ([#101] by [mvz])
* Support WebKit2 version 4.1 in addition to 4.0 ([#103] by [mvz])

[#100]: https://github.com/mvz/mdv/pull/100
[#101]: https://github.com/mvz/mdv/pull/101
[#103]: https://github.com/mvz/mdv/pull/103

## 0.8.1 / 2024-01-01

* Switch to commonmarker as the Markdown renderer ([#98] by [mvz])

[#98]: https://github.com/mvz/mdv/pull/98

## 0.8.0 / 2024-01-01

* Support Ruby 3.0 through 3.3, dropping support for 2.6 and 2.7
  ([#70], [#81] and [#96] by [mvz])
* Update GirFFI and GirFFI-Gtk dependencies to version 0.17.0
  ([#71] and [#97] by [mvz])

[mvz]: https://github.com/mvz

[#70]: https://github.com/mvz/mdv/pull/70
[#71]: https://github.com/mvz/mdv/pull/71
[#81]: https://github.com/mvz/mdv/pull/81
[#96]: https://github.com/mvz/mdv/pull/96
[#97]: https://github.com/mvz/mdv/pull/97

## 0.7.0 / 2022-02-11

* Drop support for Ruby 2.5
* Support Ruby 3.1
* Update dependencies to allow github-markup version 4.0

## 0.6.0 / 2021-01-17

* Drop support for Ruby 2.4
* Support Ruby 2.7 and 3.0
* Implement as a Gtk::Application

## 0.5.1 / 2019-11-03

* Fix navigation signal handler that would cause program to abort just after
  loading

## 0.5.0 / 2019-10-20

* Drop support for Ruby 2.3 and lower
* Port to GirFFI-Gtk

## 0.4.1 / 2018-12-09

* Update dependencies

## 0.4.0 / 2018-09-12

* Drop support for Ruby 2.2 and lower
* Update dependencies
* Hide context menus to prevent unwanted actions
* Open links in default browser instead of in mdv itself

## 0.3.1 / 2017-11-11

* Update dependencies

## 0.3.0 / 2017-04-25

* Port to Ruby-GNOME2

## 0.2.2 / 2017-04-24

* Update dependencies

## 0.2.1 / 2016-03-23

* Update dependencies

## 0.2.0 / 2016-02-05

* Port to WebKit2

## 0.1.7 / 2016-01-21

* Update dependency on GirFFI
* Update code to use GirFFI's new bitmasks
* Use updated `atspi_app_driver` to fix tests

## 0.1.6 / 2015-10-17

* Ensure library files are also released in the gem
* Include license info in gemspec

## 0.1.5 / 2015-09-20

* Ensure all relevant files are released in the gem
* Code restructuring
* Tested end-to-end using `atspi_app_driver`
* Updated dependencies

## 0.1.4 / 2014-05-27

* Use semantic versioning for dependencies
* Make sure a markdown implementation is present
* Update github-markup dependency to pull in posix-spawn

## 0.1.3 / 2014-01-24

* Update dependencies
* Add rake tasks

## 0.1.2 / 2013-06-15

* Update dependencies

## 0.1.1 / 2013-02-09

* Update dependencies

## 0.1.0 / 2012-08-24

* Initial release
