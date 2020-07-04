#
# Be sure to run `pod lib lint DKProject.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DKProject'
  s.version          = '0.2.0'
  s.summary          = '一个小框架'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                          一个小框架,包含基类、分类、自定义控件、工具类等等。
                       DESC

  s.homepage         = 'https://github.com/CoderDawnKing/DKProject'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'DawnKing' => '369248214@qq.com' }
  s.source           = { :git => 'https://github.com/CoderDawnKing/DKProject.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.requires_arc = true

  s.source_files = 'DKProject/Classes/**/*'
  s.subspec 'DKCategory' do |ss|
      ss.source_files = 'DKProject/Classes/DKCategory/**/*'
      ss.dependency 'DKProject/DKConfigure'
  end
  
  s.subspec 'DKBase' do |ss|
      ss.source_files = 'DKProject/Classes/DKBase/**/*'
      ss.public_header_files = 'Pod/Classes/**/*.h'
      ss.dependency 'DKProject/DKCategory'
      ss.dependency 'DKProject/DKConfigure'
      ss.dependency 'DKProject/DKNaviFixSpace'
      ss.dependency 'MJExtension'
      ss.dependency 'ReactiveObjC'
  end
  
  s.subspec 'DKConfigure' do |ss|
      ss.source_files = 'DKProject/Classes/DKConfigure/**/*'
      ss.public_header_files = 'Pod/Classes/**/*.h'
      ss.dependency 'HexColors', '4.0.0'
  end
  
  s.subspec 'DKNaviFixSpace' do |ss|
      ss.source_files = 'DKProject/Classes/DKNaviFixSpace/**/*'
      ss.public_header_files = 'Pod/Classes/**/*.h'
  end
  
  # s.resource_bundles = {
  #   'DKProject' => ['DKProject/Assets/*.png']
  # }

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation', 'Photos'
  s.xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
  s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
  # s.dependency 'AFNetworking', '~> 2.3'
end
