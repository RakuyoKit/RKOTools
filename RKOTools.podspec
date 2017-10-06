#
#  Be sure to run `pod spec lint RKOTools.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "RKOTools"
  s.version      = "1.4.3"
  s.summary      = "One of your own tool libraries"
  s.description  = <<-DESC
  					One of your own tool libraries
                   DESC

  s.homepage     = "https://github.com/rakuyoMo/RKOTools"

  s.license      = "MIT"

  s.author             = { "Rakuyo" => "rakuyo.mo@gmail.com" }

  s.ios.deployment_target = "8.0"

  s.source       = { :git => "https://github.com/rakuyoMo/RKOTools.git", :tag => "#{s.version}" }

  s.requires_arc = true


    s.subspec 'RKOCell' do |cell|

      cell.source_files  = "RKOTools/RKOCell/*.{h,m}"
    end

  	s.subspec 'UIView+StoryBoard' do |storyboard|

  		storyboard.source_files  = "RKOTools/UIView+StoryBoard/*.{h,m}"
  	end

  	s.subspec 'CloseKeyBoard' do |closeKeyBoard|

  		closeKeyBoard.source_files  = "RKOTools/CloseKeyBoard/*.{h,m}"
  	end

  	s.subspec 'CollecionLog' do |collec􏰂ionLog|

  		collec􏰂ionLog.source_files  = "RKOTools/CollecionLog/*.{h,m}"
  	end

  	s.subspec 'NetWorkTool' do |netWorkTool|

  		netWorkTool.source_files  = "RKOTools/NetWorkTool/*.{h,m}"
  		netWorkTool.dependency "AFNetworking", '~> 3.0'
  	end

  	s.subspec 'TopViewController' do |topViewController|

  		topViewController.source_files  = "RKOTools/TopViewController/*.{h,m}"
  	end

    s.subspec 'ImageWithColor' do |imageWithColor|

      imageWithColor.source_files  = "RKOTools/ImageWithColor/*.{h,m}"
    end

    s.subspec 'DebugDescription' do |debugDescription|

      debugDescription.source_files  = "RKOTools/DebugDescription/*.{h,m}"
    end

end
