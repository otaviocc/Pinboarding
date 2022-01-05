# Pinboarding

Pinboarding is a [Pinboard](https://pinboard.in) client for macOS. It's a work in progress, but already includes the following features:

* automatic sync (and forced sync)
* filter bookmarks by tag or visibility
* add a new bookmark
* open bookmark on browser
* share a bookmark

A [Pinboard](https://pinboard.in) account is required to use the app.

![](Images/dark.jpg)

![](Images/light.jpg)

# Building

To build a release for your local machine

    xcodebuild \
      -scheme Pinboarding \
      -configuration Release \
      CODE_SIGN_IDENTITY="-" \
      build
