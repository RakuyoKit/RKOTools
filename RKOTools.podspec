#
#  Be sure to run `pod spec lint RKOTools.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "RKOTools"
  s.version      = "1.1.0"
  s.summary      = "One of your own tool libraries"
  s.description  = <<-DESC
  					One of your own tool libraries
                   DESC

  s.homepage     = "https://github.com/rakuyoMo/RKOTools"

  s.license      = "MIT"

  s.author             = { "Rakuyo" => "rakuyo.mo@gmail.com" }

  s.ios.deployment_target = "7.0"

  s.source       = { :git => "https://github.com/rakuyoMo/RKOTools.git", :tag => "#{s.version}" }

  s.requires_arc = true


  s.subspec 'RKOControl' do |control|

  	control.subspec 'RKOCell' do |cell|

  		cell.source_files  = "RKOTools/RKOControl/RKOCell/*.{h,m}"
  	end

  	control.subspec 'RKONetworkAlert' do |networkAlert|

  		networkAlert.source_files  = "RKOTools/RKOControl/RKONetworkAlert/*.{h,m}"
  	end

  end


  s.subspec 'RKOHelper' do |helper|

  	helper.subspec 'CALayer+Additions' do |additions|

  		additions.source_files  = "RKOTools/RKOTools/CALayer+Additions/*.{h,m}"
  	end

  	helper.subspec 'CloseKeyBoard' do |closeKeyBoard|

  		closeKeyBoard.source_files  = "RKOTools/RKOTools/CloseKeyBoard/*.{h,m}"
  	end

  	helper.subspec 'CollecionLog' do |collec􏰂ionLog|

  		collec􏰂ionLog.source_files  = "RKOTools/RKOTools/CollecionLog/*.{h,m}"
  	end

  	helper.subspec 'FastFrame' do |fastFrame|

  		fastFrame.source_files  = "RKOTools/RKOTools/FastFrame/*.{h,m}"
  	end

  	helper.subspec 'NetWorkTool' do |netWorkTool|

  		netWorkTool.source_files  = "RKOTools/RKOTools/NetWorkTool/*.{h,m}"
  		netWorkTool.dependency "AFNetworking", '~> 3.0'
  	end

  	helper.subspec 'TopViewController' do |topViewController|

  		topViewController.source_files  = "RKOTools/RKOTools/TopViewController/*.{h,m}"
  	end

  end

end
