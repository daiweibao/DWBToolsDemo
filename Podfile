source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'


# swift这里比OC要多导入(但是导入后会有大量警告，不导入这个就要在桥接文件里导入三方库头文件,处理大量警告见笔记)
#swift 项目中通过pod导入swift项目，必须要使用use_frameworks！，在需要使用的到地方 import AFNetworking
#swift 项目中通过pod导入OC项目
#1） 使用use_frameworks，在桥接文件里加上#import "AFNetworking/AFNetworking.h"
#2）不使用frameworks，桥接文件加上 #import "AFNetworking.h"
#最重要的就是在Podfile里面加上use_frameworks!   因为swift使用的是框架而不是静态库

use_frameworks!

target 'DWBToolsDemo' do
    
#AFN
pod 'AFNetworking'
#布局
pod 'Masonry'

#明杰刷新
pod 'MJRefresh'


#图片解析（不支持gif）
#    从4.0版本开始，我们依赖FLAnimatedImage来处理我们的动画图像。
#    如果你使用cocoapods，将pod 'SDWebImage/GIF'添加到你的podfile中。
#    要使用它，只需确保使用FLAnimatedImageView而不是UIImageView。
#    注意:这里有一个向后兼容的特性，所以如果你还在尝试将GIF加载到UIImageView中，默认情况下它只会显示第一帧作为静态图像。但是，您可以使用内置的GIF编码器来启用完整的GIF支持。看到GIF编码器
#    重要:FLAnimatedImage只适用于iOS平台。对于macOS，使用NSImageView与animates设置为YES以显示整个动画图像，而不只是显示第1帧。对于所有其他平台(tvOS, watchOS)，我们将退回到上面描述的向后兼容性特性。
pod 'SDWebImage'
pod 'SDWebImage/GIF'
#图片解析支持gif，4.0后不在支持git，请慎重选择
#    pod 'SDWebImage', '~>3.8'


#友盟--2018年10月19日
#基础库
pod 'UMCCommon'
pod 'UMCSecurityPlugins'
#日志库（调试）
pod 'UMCCommonLog'
#分享 SDK
# 集成微信(完整版14.4M)
pod 'UMCShare/Social/WeChat'
# 集成QQ/QZone/TIM(完整版7.6M)
pod 'UMCShare/Social/QQ'
# 集成新浪微博(完整版25.3M)
pod 'UMCShare/Social/Sina'


pod 'YYModel'
# 明杰Model
pod 'MJExtension'


#pod 'JXCategoryView'

#===================swift模块导入的三方库=================================

#自动布局,iOS11之前，不能升级到4.0
pod 'SnapKit'

#网络请求，暂时用AFN
#pod 'Alamofire'

#转JSON,暂时不用
#pod 'SwiftyJSON'

#把json对象映射为model对象。
pod 'ObjectMapper', '~> 3.4'



end
