Pod::Spec.new do |s|
  s.name             = "SQLiteStack"
  s.version          = "0.1.0"
  s.summary          = "A simple SQLite Stack"

  s.homepage         = "https://github.com/onmyway133/SQLiteStack"
  s.license          = 'MIT'
  s.author           = { "Khoa Pham" => "onmyway133@gmail.com" }
  s.source           = { :git => "https://github.com/onmyway133/SQLiteStack.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/onmyway133'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'SQLiteStack' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'FMDB', '~> 2.5'
  s.dependency 'FTGPropertyMaestro', '~> 1.0'
  s.dependency 'ObjectiveSugar', '~> 1.1'
end
