source 'https://github.com/CocoaPods/Specs.git'
platform :osx, '10.12'
workspace 'YouTMusicWorkspace.xcworkspace'
use_frameworks!

def common_pods
  
  pod 'Alamofire'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'SwiftyBeaver', '1.4.0'
  pod 'SwiftLint'
  pod 'Unbox'
  pod 'OAuthSwift'
  
end

target 'YouTMusicCore' do
  project 'YouTMusicCore/YouTMusicCore.xcodeproj'
  use_frameworks!
  common_pods
end

target 'YouTMusic' do
  project 'YouTMusic/YouTMusic.xcodeproj'
  use_frameworks!
  common_pods
end

# ignore all warnings from all pods
inhibit_all_warnings!
