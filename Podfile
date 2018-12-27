platform :ios, '11.0'
target 'LittleLights' do
  inhibit_all_warnings!
  pod 'ReactiveCocoa', '~> 2.0'
  pod 'Masonry'
  pod 'AFNetworking'
  pod 'SDWebImage'
  pod 'BlocksKit'
end
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
        end
    end
end
