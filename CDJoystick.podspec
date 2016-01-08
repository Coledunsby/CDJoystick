Pod::Spec.new do |s|
    s.name              = "CDJoystick"
    s.version           = "0.1.0"
    s.summary           = "Joystick for UIKit"
    s.homepage          = "https://github.com/Coledunsby/CDJoystick"
    # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
    s.license           = 'MIT'
    s.author            = { "Cole Dunsby" => "coledunsby@gmail.com" }
    s.source            = { :git => "https://github.com/Coledunsby/CDJoystick.git", :tag => s.version.to_s }
    s.platform          = :ios, '8.0'
    s.requires_arc      = true
    s.source_files      = 'Pod/Classes/**/*'
end
