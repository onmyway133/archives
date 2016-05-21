Pod::Spec.new do |spec|
  spec.name         = 'FTGPropertyMaestro'
  spec.version      = '1.0'
  spec.license      =  { :type => 'MIT', :file => 'LICENSE.md' }
  spec.homepage     = 'https://github.com/onmyway133/FTGPropertyMaestro'
  spec.authors      = { 'Khoa Pham' => 'onmyway133@gmail.com' }
  spec.summary      = 'Synthesize properties for categories .'
  spec.source       = { :git => 'https://github.com/onmyway133/FTGPropertyMaestro.git', :tag => '1.0' }
  spec.source_files = 'FTGPropertyMaestro/*.{h,m}'
  spec.requires_arc = true
  spec.ios.deployment_target = '6.0'
  spec.osx.deployment_target = '10.7'
  spec.social_media_url   = "https://twitter.com/onmyway133"
end