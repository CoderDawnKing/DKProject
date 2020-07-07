#
# Be sure to run `pod lib lint DKProject.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DKProject'
  s.version          = '0.2.5'
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

  s.source_files = 'DKProject/Classes/**/*.{h,m}'
  
   s.resource_bundles = {
     'DKProject' => ['DKProject/Assets/*']
   }

  s.public_header_files = 'DKProject/Classes/**/*.{h}'
  s.frameworks = 'UIKit', 'Foundation', 'Photos'
  s.xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
  s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
  s.dependency 'HexColors', '4.0.0'
  s.dependency 'MJRefresh', '3.4.3'
  s.dependency 'MJExtension', '3.2.2'
  s.dependency 'Masonry', '1.1.0'
  s.dependency 'ReactiveObjC', '3.1.1'
  s.dependency 'SVProgressHUD', '2.2.5'
  s.dependency 'CYLTabBarController', '1.28.3'
  
  s.subspec "DKNaviFixSpace" do |ss|
      ss.name             = 'DKNaviFixSpace'
  end
  s.subspec "DKNetworkingTool" do |ss|
      ss.name             = 'DKNetworkingTool'
      s.dependency 'AFNetworking', '3.2.1'
  end
end
