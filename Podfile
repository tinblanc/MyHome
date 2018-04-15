# platform :ios, '9.0'

def pods
    # Core
    pod 'ObjectMapper', '~> 3.0'
    pod 'Reusable', '~> 4.0'
    pod 'Then', '~> 2.3'
    
    # Rx
    pod 'RxSwift', '~> 4.1'
    pod 'RxCocoa', '~> 4.1'
    pod 'RxSwiftExt', '~> 3.1'
    pod 'NSObject+Rx', '~> 4.2'
    pod 'RxDataSources', '~> 3.0'
    
    #
    pod 'MBProgressHUD', '~> 1.1'
    pod 'Localize-Swift', '~> 2.0'
    pod 'IQKeyboardManagerSwift'

end

target 'MyHome' do
  use_frameworks!
  pods

  # Pods for MyHome

  target 'MyHomeTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MyHomeUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
