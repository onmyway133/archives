Pod::Spec.new do |spec|
  spec.name         = 'FTGShorthand'
  spec.version      = '1.0'
  spec.license      =  { :type => 'MIT', :file => 'LICENSE' }
  spec.homepage     = 'https://github.com/onmyway133/FTGShorthand'
  spec.authors      = { 'Khoa Pham' => 'onmyway133@gmail.com' }
  spec.summary      = 'Allows your category methods to be in shorthand form, like MagicalRecord MR_SHORTHAND .'
  spec.source       = { :git => 'https://github.com/onmyway133/FTGShorthand.git', :tag => '1.0' }
  spec.source_files = 'FTGShorthand/FTGShorthand.{h,m}'
  spec.requires_arc = true
  spec.ios.deployment_target = '6.0'
  spec.osx.deployment_target = '10.7'
  spec.social_media_url   = "https://twitter.com/onmyway133"
end