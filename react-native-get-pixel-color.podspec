require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-get-pixel-color"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  react-native-get-pixel-color
                   DESC
  s.homepage     = "https://github.com/dudyn5ky1/react-native-get-pixel-color"
  # brief license entry:
  s.license      = "MIT"
  # optional - use expanded license entry instead:
  # s.license    = { :type => "MIT", :file => "LICENSE" }
  s.authors      = { "Maksym Dudynskyi" => "hello@dudynskyi.com" }
  s.platforms    = { :ios => "9.0" }
  s.source       = { :git => "https://github.com/dudyn5ky1/react-native-get-pixel-color.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,swift}"
  s.requires_arc = true

  s.dependency "React"
  # ...
  # s.dependency "..."
end
