Pod::Spec.new do |spec|
  spec.name         = 'FTGCircularTuner'
  spec.version      = '1.0'
  spec.license      =  { :type => 'MIT', :file => 'LICENSE.md' }
  spec.homepage     = 'https://github.com/onmyway133/FTGCircularTuner'
  spec.authors      = { 'Khoa Pham' => 'onmyway133@gmail.com' }
  spec.summary      = 'A simple tuner'
  spec.source       = { :git => 'https://github.com/onmyway133/FTGCircularTuner.git', :tag => '1.0' }
  spec.source_files = 'FTGCircularTuner/*.{h,m}'
  spec.requires_arc = true
  spec.framework    = 'UIKit'
  spec.ios.deployment_target = '6.0'
  spec.social_media_url   = "https://twitter.com/onmyway133"
end