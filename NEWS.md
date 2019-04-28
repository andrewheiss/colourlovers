# colourlovers 0.3.0

- New maintainer: @andrewheiss (#7)
- Updated `clquery()` to use the **httr** package
- Updated tests to use **httptest** package so they can reference cached offline API calls instead of making live calls to the API, which makes testing faster and makes CRAN happier


# colourlovers 0.2

### Significant user-visible changes

- Replaced import of RJSONIO with jsonlite.
- Added namespace imports of base packages.
- Converted README to a knitr executible.
- Added a test suite.

### Documentation

- Examples in documentation are now `tryCatch`-wrapped to hopefully avoid any unwanted errors, some of which emerged on OSX Mavericks but were not generally reproducible. (Thanks to Brian Ripley and Christophe Lalanne for assistance) (#2)

### Bug fixes

- Fixed pandoc conversion error in README.md (h/t Kurt Hornik)


# colourlovers 0.1

- Initial release.
