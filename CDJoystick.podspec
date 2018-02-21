Pod::Spec.new do |s|
    s.name              = "CDJoystick"
    s.version           = "1.1.0"
    s.swift_version     = "4.0"
    s.summary           = "Joystick for UIKit"
    s.homepage          = "https://github.com/Coledunsby/CDJoystick"
    s.authors           = { "Cole Dunsby" => "coledunsby@gmail.com" }
    s.license           = { :type => "MIT", :file => 'LICENSE' }
    s.platform          = :ios, "9.0"
    s.requires_arc      = true
    s.source            = { :git => "https://github.com/Coledunsby/CDJoystick.git", :tag => "v/#{s.version}" }
    s.source_files      = "CDJoystick.swift"
    s.module_name       = s.name
end
