source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'

target 'DWBToolsDemo' do
    
#AFN：4.0.1是终极封存版
#截至2023年1月17日，AFNetworking已弃用，将不再发布。此回购协议将作为存档永久保持在线状态。有几个选项可以继续使用AFNetworking：

#将AFNetworking复制到您的项目中并直接编译。这使您可以完全控制代码。
#分叉AFNetworking，并在您的依赖管理器中使用分叉。不会有官方的分叉，但任何人都可以随时分叉，甚至可以根据AFNetworking的许可证以不同的名称发布这些分叉。
#展望未来，Alamofire是现代Swift中网络的建议迁移路径。欢迎任何需要帮助进行迁移的人在StackOverflow上询问并标记alamofire和afnetworking，或在Alamofire的GitHub讨论中就任何迁移问题或缺失的功能展开讨论。
pod 'AFNetworking','~>4.0'

#图片解析（不支持gif）
#    从4.0版本开始，我们依赖FLAnimatedImage来处理我们的动画图像。
#    如果你使用cocoapods，将pod 'SDWebImage/GIF'添加到你的podfile中。
#    要使用它，只需确保使用FLAnimatedImageView而不是UIImageView。
#    注意:这里有一个向后兼容的特性，所以如果你还在尝试将GIF加载到UIImageView中，默认情况下它只会显示第一帧作为静态图像。但是，您可以使用内置的GIF编码器来启用完整的GIF支持。看到GIF编码器
#    重要:FLAnimatedImage只适用于iOS平台。对于macOS，使用NSImageView与animates设置为YES以显示整个动画图像，而不只是显示第1帧。对于所有其他平台(tvOS, watchOS)，我们将退回到上面描述的向后兼容性特性。

#在5.0中，我们引入了一种支持动画图像的全新机制。这包括动画图像加载、渲染、解码，还支持自定义（适用于高级用户）。SDAnimatedImageViewSDAnimatedImageView *imageView = [SDAnimatedImageView new];
#SDAnimatedImage *animatedImage = [SDAnimatedImage imageNamed:@"image.gif"];
#imageView.image = animatedImage;

#图片解析支持gif，4.0后不在支持git，请慎重选择
#SDWebImage：5.17.0  '~> 5.0'
pod 'SDWebImage', '~> 5.0'

#1.0.17
pod 'FLAnimatedImage', '~> 1.0'

#布局 1.1.0
pod 'Masonry','~>1.1'

#明杰刷新：3.7.5
pod 'MJRefresh','~>3.7'

#3.4.1
pod 'MJExtension','~>3.4'
#3.2
pod 'Reachability'


#pod 'JXCategoryView'


end
