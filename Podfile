platform :ios, '12.0'
inhibit_all_warnings!

def is_pod_binary_cache_enabled
  ENV['IS_POD_BINARY_CACHE_ENABLED'] == 'true'
end

if is_pod_binary_cache_enabled
  plugin 'cocoapods-binary-cache'
  config_cocoapods_binary_cache(
    cache_repo: {
      "default" => {
        "remote" => "git@github.com:aaronLab/rx-boilerplate.git",
        "local" => "~/.cocoapods-binary-cache/ios-pod-libs"
      }
    },
    prebuild_config: "Debug",
    dev_pods_enabled: true,
    device_build_enabled: true
  )
  # set_unbuilt_dev_pods(['ConfigSDK']) // To test ABI breaking (crash, call wrong function) when there're code change in ConfigSDK and don't rebuild it's clients (ConfigService)
end

def binary_pod(name, *args)
  if is_pod_binary_cache_enabled
    pod name, args, :binary => true
  else
    pod name, args
  end
end

target 'Rx Boilerplate' do

  use_frameworks!

  # Pods for Rx Boilerplate

  # Firebase
  binary_pod 'Firebase/Core'
  binary_pod 'Firebase/Analytics'
  binary_pod 'Firebase/Messaging'
  binary_pod 'Firebase/Crashlytics'
  binary_pod 'Firebase/Firestore'
  binary_pod 'FirebaseFirestoreSwift'
  binary_pod 'Firebase/RemoteConfig'

  # Rx
  binary_pod 'RxSwift', '< 6.2.0'
  binary_pod 'RxCocoa', '< 6.2.0'
  binary_pod 'RxGesture', '< 4.1.0'
  binary_pod 'RxDataSources', '<5.1.0'

  binary_pod 'Alamofire', '< 5.5.0'
  binary_pod 'Kingfisher', '< 6.3.0'
  binary_pod 'IQKeyboardManagerSwift', '< 6.6.0'
  binary_pod 'SnapKit', '< 5.1.0'
  binary_pod 'lottie-ios', '< 3.3.0'
  binary_pod 'BottomPopup', '< 0.7.0'
  binary_pod 'Nantes', '< 0.2.2'
  binary_pod 'SwiftKeychainWrapper', '< 4.1.0'
  binary_pod 'Then', '< 2.8.0'
  binary_pod 'Toast-Swift', '< 5.1.0'
  binary_pod 'SwiftyTimer', '< 2.2.0'
  binary_pod 'VersaPlayer', '< 3.1.0'
  binary_pod 'ImageScrollView', '< 2.0.0'
  binary_pod 'GrowingTextView', '< 0.8.0'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end
