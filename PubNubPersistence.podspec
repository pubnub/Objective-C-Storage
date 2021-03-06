#
# Be sure to run `pod lib lint PubNubPersistence.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PubNubPersistence'
  s.version          = '0.3.0'
  s.summary          = 'A thin persistence layer for PubNub in an Objective-C environment.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This is is a persistence layer for PubNub in an Objective-C environemnt for storing and accessing PubNub messages asynchronously.
                       DESC

  s.homepage         = 'https://github.com/pubnub/Objective-C-Storage'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jordan Zucker' => 'jordan.zucker@gmail.com' }
  s.source           = { :git => 'https://github.com/pubnub/Objective-C-Storage.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/PubNub'

  s.ios.deployment_target = '8.0'

  s.source_files = 'PubNubPersistence/Classes/**/*'
  
  # s.resource_bundles = {
  #   'PubNubPersistence' => ['PubNubPersistence/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'PubNub'
  s.dependency 'Realm', '~> 1.0.2'
end
