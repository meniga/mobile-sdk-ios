Pod::Spec.new do |s|
  s.name             = 'MenigaSDK'
  s.version          = '0.9.19'
  s.summary          = 'An objective c library to consume the Meniga REST API.'
  s.description      = <<-DESC
The Meniga mobile sdk for Objective-C provides a convenient way to interact with the Meniga REST API. Perform api requests through deserialized json objects for easy interaction with the api. Works with swift through the use of a bridging header (see SDK documentation).
                       DESC

  s.homepage         = 'https://www.meniga.com'
  s.license          = { :type => 'Copyright', :file => 'LICENSE' }
  s.author           = { 'Meniga' => 'meniga@meniga.is' }
  s.source           = { :http => "https://github.com/meniga/mobile-sdk-ios/MenigaSDK/compiled/MenigaSDK.framework.zip" }
  s.social_media_url = 'https://twitter.com/meniga'

  s.ios.deployment_target = '7.0'
  s.requires_arc = true

end
