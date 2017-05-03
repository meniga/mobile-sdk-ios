![Meniga](https://github.com/meniga/mobile-sdk-ios/raw/master/logo.png)

Meniga helps banks use data to accelerate innovation and meaningful engagement by providing RESTful APIs on top of Meniga software products to improve and personalize the online banking experience for both individuals and corporate customers.

## Getting started
Developers for institutions implementing the Meniga REST API can usi this sdk to communicate easily with the sdk and perform api operations. Please follow the setup guide in the documentation for further detail. Individuals making personalized implementations can point the sdk to their bank or financial institution's API URL to use their own data. You must however obtain some authentication information and pass it along to the sdk. See the documentation for further detail.

## Installation

### Installation with Cocoapods
You can easily integrate the Meniga SDK using [Cocoapods](http://cocoapods.org). If you do not have Cocoapods installed on your machine simply run

```bash
$ gem install cocoapods
```

to get started. Next simply add

```
pod 'Meniga'
```

to your podfile and then run

```
$ pod install
```

in your project directory where the podfile is located.

### Building from source
To build the Meniga SDK from source you can clone or download the github repository. Then open the Meniga-ios-sdk xcode project and build the framework target. This should create a framework file in the compiled folder in the project directory. You should in fact already have this file when you download the source code so no need to build it again unless you have made changes to the source code.

## Requirements
This SDK supports at minimum iOS version 7.0 and was programmed using Xcode version 8.1

## Swift
If you are writing swift code you should be able to use this SDK with the use of a bridging header. Please see the documentation for further detail.

## License
The Meniga SDK for Objective-C is published under the MIT license.
