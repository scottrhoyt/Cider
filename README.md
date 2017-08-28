# Cider
The Missing Apple Music SDK. Written in Swift.

[![Build Status](https://travis-ci.org/scottrhoyt/Cider.svg?branch=master)](https://travis-ci.org/scottrhoyt/Cider)
[![codecov.io](https://codecov.io/github/scottrhoyt/Cider/coverage.svg?branch=master)](https://codecov.io/github/scottrhoyt/Cider?branch=master)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods](https://img.shields.io/cocoapods/v/Cider.svg)](https://cocoapods.org/pods/Cider)
[![SPM compatible](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
![Platform iOS](https://img.shields.io/badge/Platform-iOS-blue.svg)
[![Language Swift 4.0](https://img.shields.io/badge/Language-Swift%204.0-orange.svg)](https://swift.org)

### Installation

#### Carthage

Add the following to your Cartfile:

```sh
github "scottrhoyt/Cider" ~> 0.10
```

#### CocoaPods

Add the following to your Podfile:

```sh
pod 'Cider', '~> 0.10'
```

#### SPM

Add to your `Package.swift` file like so:

```swift
import PackageDescription

let package = Package(
    name: "<YOUR_PROJECT_NAME>",
    dependencies: [
        .package(url: "https://github.com/scottrhoyt/Cider.git", from: "0.10.0")
    ]
)
```

### Usage

#### Developer Token

To use the Apple Music API, you will need to generate a developer token.
Instructions for how to do this can be found in the Apple Music API
[reference](https://developer.apple.com/library/content/documentation/NetworkingInternetWeb/Conceptual/AppleMusicWebServicesReference/SetUpWebServices.html#//apple_ref/doc/uid/TP40017625-CH2-SW1).

Once you have an Apple Music Key you can use a 3rd party library/tool to
generate your token. I created a Node.js library and CLI tool that you can find
[here](https://github.com/scottrhoyt/apple-music-jwt).

#### Create a Client

```swift
let developerToken = "<developer_token>"
let cider = CiderClient(storefront: .unitedStates, developerToken: developerToken)
```

#### Search the Catalog

```swift
cider.search(term: "Michael Jackson", types: [.albums, .songs]) { results, error in
  // Process the results or error
}
```

#### Lookup an Artist/Album/Song

```swift
let songId = "<song_id>"
cider.song(id: songId) { result, error in
  // Process the results or error
}
```

### API Reference

The full API reference can be found [here](https://scottrhoyt.github.io/Cider).

### License

MIT
