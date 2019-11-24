# MultipeerHelper

MultipeerConnectivity can be a big pill for developers to swallow. This package aims to simplify the creation of a multi-peer experience, while still delivering the full power of Apple's API.

## Installation

This is a Swift Package, and can be installed via Xcode with the URL of this repository:

`git@github.com:maxxfrazer/MultipeerHelper.git`

[For more information on how to add a Swift Package using Xcode, see Apple's official documentation.](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app)


## Usage

To use this package, all you have to do is import `MultipeerHelper` and initialise the object:

```swift
self.multipeerHelp = MultipeerHelper(
  serviceName: "helper-test"
)
```

### Initializer Parameters

#### serviceName
This is the type of service to advertise or search for. Due to how MultipeerConnectivity uses it, it should have the following restrictions
 - Must be 1–15 characters long
 - Can contain only ASCII lowercase letters, numbers, and hyphens
 - Must contain at least one ASCII letter
 - Must not begin or end with a hyphen
 - Must not contain hyphens adjacent to other hyphens.
