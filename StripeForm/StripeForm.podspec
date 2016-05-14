Pod::Spec.new do |s|
  s.name             = "StripeForm"
  s.version          = "0.1.0"
  s.summary          = "Practise making Stripe Checkout form"

  s.homepage         = "https://github.com/onmyway133/StripeForm"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Khoa Pham" => "onmyway133@gmail.com" }
  s.source           = { :git => "https://github.com/onmyway133/StripeForm.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/onmyway133'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'StripeForm' => ['Pod/Assets/*.png', 'Pod/Classes/*.xib']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'SnapKit', '~> 0.18'
end
