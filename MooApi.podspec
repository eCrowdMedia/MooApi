Pod::Spec.new do |s|

  s.name         = "MooApi"
  s.version      = "0.0.1"

  s.summary      = "Readmoo JSON:API framework for iOS in Swift."
  s.homepage     = "https://github.com/eCrowdMedia/MooApi"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "Lanaya_HSIHE" => "yiyezhihen@gmail.com" }
  s.platform     = :ios, "9.0"

  s.source         = { :git => "https://github.com/eCrowdMedia/MooApi.git", :tag => "#{s.version}" }
  s.source_files   = "MooApi", "Sources/*.{h,swift}"

  s.requires_arc   = true
  s.compiler_flags = "-whole-module-optimization"

  s.dependency "Argo", "~> 4.1.2"
  s.dependency "Curry", "~> 4.0.1"
  s.dependency "Runes", "~> 3.0.0"
  s.dependency "Result", "~> 3.2.1"

  s.pod_target_xcconfig = { "SWIFT_VERSION" => "3.0" }

end
