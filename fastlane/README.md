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
or alternatively using `brew install fastlane`

# Available Actions
## iOS
### ios deploy
```
fastlane ios deploy
```
Deploy MenigaSDK to cocoapods trunk
  Steps:
   * Bump version in podspec
   * Commit framework and podspec changes
   * Create version tag
   * Push commit and tag to remote
   * Push podspec to Trunk specs
  Options:  
  - version - new version number to release
  
### ios ci_deploy
```
fastlane ios ci_deploy
```
Deploy MenigaSDK to cocoapods trunk, 
  lane developed to run on release branch from CI server
  Steps:
   * Bump podspec version
   * Commit framework and podspec changes as MenigaBuildsson
   * Create version tag
   * Push commit and tag to remote
   * Push podspec to Trunk specs
   * Merge branch into master
  Options:  
  - gh_user - Username for github account 
  - gh_user_email - Commit email address 
  - gh_token - Access token for gh_user_name github account 
  
### ios tests
```
fastlane ios tests
```
Run tests:
    - Validate podspec
    - run-clang-format - to check Objective-c files formatting
    - synx - to check if xcodeproj has proper group structure
    - Mobile-ios-sdk unit tests
  
### ios format
```
fastlane ios format
```
Format Objective-C code
### ios run_synx
```
fastlane ios run_synx
```


----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
