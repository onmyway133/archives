Pod::Spec.new do |s|
  s.name             = "Cine"
  s.version          = "0.1.0"
  s.summary          = "AVPlayer wrapper in Swift"

  s.homepage         = "https://github.com/onmyway133/Cine"
  s.license          = 'MIT'
  s.author           = { "Khoa Pham" => "onmyway133@gmail.com" }
  s.source           = { :git => "https://github.com/onmyway133/Cine.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/onmyway133'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'

  s.frameworks = 'UIKit', 'AVFoundation', 'CoreMedia'
  s.dependency 'KVOController', '~> 1.0'
end
