Pod::Spec.new do |s|

    s.name              = 'MenigaSDK'
    s.module_name       = 'MenigaSDK'
    s.version           = '1.1.15'
    s.summary           = 'An objective c library to consume the Meniga REST API.'
    s.description       = <<-DESC
The Meniga mobile sdk for Objective-C provides a convenient way to interact with the Meniga REST API. Perform api requests through deserialized json objects for easy interaction with the api. Works with swift through the use of a bridging header (see SDK documentation).
                       DESC

    s.homepage          = 'https://github.com/meniga/mobile-sdk-ios'
    s.documentation_url = 'https://github.com/meniga/mobile-sdk-ios/wiki'
    s.license           = { :type => 'MIT', :file => 'LICENSE' }
    s.authors           = { 'Meniga' => 'meniga@meniga.is' }
    s.source            = { :git => "https://github.com/meniga/mobile-sdk-ios.git", :tag => s.version }
    s.social_media_url  = 'https://twitter.com/meniga'

    s.ios.deployment_target = '8.0'

    s.source_files      = 'Meniga/Meniga-ios-sdk/**/*'

    s.requires_arc      = true

end
