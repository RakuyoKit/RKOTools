#
#  Be sure to run `pod spec lint RKOTools.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "RKOTools"
  s.version      = "1.11.0"
  s.summary      = "One of your own tool libraries"
  s.description  = <<-DESC
  					Own a tool library.
                   DESC

  s.homepage     = "https://github.com/rakuyoMo/RKOTools"

  s.license      = "MIT"

  s.author       = { "Rakuyo" => "rakuyo.mo@gmail.com" }

  s.ios.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/rakuyoMo/RKOTools.git", :tag => "#{s.version}" }

  s.requires_arc = true


    s.subspec 'RKOBaseCell' do |cell|

      cell.source_files  = "RKOTools/RKOBaseCell/*.{h,m}"
    end

  	s.subspec 'StoryBoardCategory' do |storyboard|

  		storyboard.source_files  = "RKOTools/StoryBoardCategory/*.{h,m}"
  	end

  	s.subspec 'CloseKeyBoard' do |closeKeyBoard|

  		closeKeyBoard.source_files  = "RKOTools/CloseKeyBoard/*.{h,m}"
  	end

  	s.subspec 'CollecionLog' do |collec􏰂ionLog|

  		collec􏰂ionLog.source_files  = "RKOTools/CollecionLog/*.{h,m}"
  	end

  	s.subspec 'NetWorkTool' do |netWorkTool|

  		netWorkTool.source_files  = "RKOTools/NetWorkTool/*.{h,m}"
  		netWorkTool.dependency "AFNetworking"
  	end

  	s.subspec 'TopViewController' do |topViewController|

  		topViewController.source_files  = "RKOTools/TopViewController/*.{h,m}"
  	end

    s.subspec 'ImageWithColor' do |imageWithColor|

      imageWithColor.source_files  = "RKOTools/ImageWithColor/*.{h,m}"
    end

    s.subspec 'UIViewTools' do |uiViewTools|

      uiViewTools.source_files  = "RKOTools/UIViewTools/*.{h,m}"
    end

    s.subspec 'Rotate' do |rotate|

      rotate.source_files  = "RKOTools/Rotate/*.{h,m}"
    end

    s.subspec 'RKOBaseModel' do |model|

      model.source_files  = "RKOTools/RKOBaseModel/*.{h,m}"
      model.dependency "YYModel"
    end

    s.subspec 'HexString' do |hexString|

      hexString.source_files  = "RKOTools/HexString/*.{h,m}"
    end


end
