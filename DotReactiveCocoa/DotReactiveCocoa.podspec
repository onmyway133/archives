Pod::Spec.new do |spec|
  spec.name         = 'DotReactiveCocoa'
  spec.version      = '1.0'
  spec.license      =  { :type => 'MIT', :file => 'LICENSE.md' }
  spec.homepage     = 'https://github.com/onmyway133/DotReactiveCocoa'
  spec.authors      = { 'Khoa Pham' => 'onmyway133@gmail.com' }
  spec.summary      = 'ReactiveCocoa with dot syntax'
  spec.source       = { :git => 'https://github.com/onmyway133/DotReactiveCocoa.git', :tag => '1.0' }
  spec.source_files = 'DotReactiveCocoa/*.{h,m}'
  spec.requires_arc = true
  spec.framework    = 'UIKit'
  spec.ios.deployment_target = '6.0'
  spec.dependency       'ReactiveCocoa', '~> 2.0'
  s.osx.deployment_target = '10.8'
  spec.social_media_url   = "https://twitter.com/onmyway133"
end