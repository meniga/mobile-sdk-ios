fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios deploy
```
fastlane ios deploy
```
Deploy MenigaSDK to cocoapods trunk
  Steps:
   * Create compiled framework
   * Bump version in podspec
   * Commit framework and podspec changes
   * Create version tag
   * Push commit and tag to remote
   * Push podspec to Trunk specs
  Options:  
  - version - new version number to release
  
### ios build_framework
```
fastlane ios build_framework
```
Build framework under path Meniga/compiled

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
