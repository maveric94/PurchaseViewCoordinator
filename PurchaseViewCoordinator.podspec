Pod::Spec.new do |s|
  s.name = "PurchaseViewCoordinator"
  s.version = "1.0.0"
  s.summary = "Simple basis for screens with purchases using SwiftUI."
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage = "https://github.com/maveric94/PurchaseViewCoordinator"
  s.author = { "Anton Protko" => "maveric942@gmail.com" }
  s.source = { :git => "https://github.com/maveric94/PurchaseViewCoordinator.git", :tag => s.version.to_s }  
  s.requires_arc = true
  s.ios.deployment_target = '13.0'
  s.source_files = 'Sources/PurchaseViewCoordinator/*.swift'
  s.swift_version = '5.0'
end
