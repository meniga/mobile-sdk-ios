![Tests](https://github.com/meniga/mobile-sdk-ios/workflows/Tests/badge.svg)
[![codecov](https://codecov.io/gh/meniga/mobile-sdk-ios/branch/master/graph/badge.svg?token=rkF6XQrAJa)](https://codecov.io/gh/meniga/mobile-sdk-ios)

![Meniga](https://github.com/meniga/mobile-sdk-ios/raw/master/logo.png)

Meniga helps banks use data to accelerate innovation and meaningful engagement by providing RESTful APIs on top of Meniga software products to improve and personalize the online banking experience for both individuals and corporate customers.

## Getting started
Developers for institutions implementing the Meniga REST API can usi this sdk to communicate easily with the sdk and perform api operations. Please follow the setup guide in the documentation for further detail. Individuals making personalized implementations can point the sdk to their bank or financial institution's API URL to use their own data. You must however obtain some authentication information and pass it along to the sdk. See the documentation for further detail.

## Installation

You can easily integrate the Meniga SDK using [Cocoapods](http://cocoapods.org). If you do not have Cocoapods installed on your machine simply run

```bash
$ gem install cocoapods
```

to get started. Next simply add

```
pod 'MenigaSDK'
```

to your podfile and then run

```
$ pod install
```

in your project directory where the podfile is located.

## Requirements
This SDK supports at minimum iOS version 8.0.

## Swift
If you are writing swift code you should be able to use this SDK with the use of a bridging header. Please see the documentation for further detail.

## License
The Meniga SDK for Objective-C is published under the MIT license.
