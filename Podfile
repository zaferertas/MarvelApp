# Uncomment the next line to define a global platform for your project
platform :ios, '13.5'

target 'MarvelApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
  pod 'Alamofire', '~> 5.2'
  pod 'Kingfisher', '~> 5.0'
  pod 'CryptoSwift', '~> 1.0'

  target 'MarvelAppTests' do
    inherit! :search_paths
    pod 'RxBlocking', '~> 5'
    pod 'RxTest', '~> 5'
  end

  target 'MarvelAppUITests' do
    inherit! :complete
  end

end


