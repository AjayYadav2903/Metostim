# Uncomment the next line to define a global platform for your project
# platform :ios, '12.1'

target 'Metostim' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
pod 'IQKeyboardManager'
pod 'SwiftyJSON'
pod 'Alamofire', '~> 4.7.2'
pod 'KRProgressHUD'
pod 'NVActivityIndicatorView/Extended'
pod "ImageSlideshow/Kingfisher"
pod 'Kingfisher'
pod "iOSDropDown"
  # Pods for Metostim

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
    # some older pods don't support some architectures, anything over iOS 11 resolves that
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end