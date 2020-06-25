# DWBToolsDemo
工具类

各种Category欢迎大家star。

下载地址：https://github.com/daiweibao/DWBToolsDemo

简书地址：https://www.jianshu.com/u/f105213e70ff

YYCategories这也是个牛逼的工具类：https://github.com/ibireme/YYCategories


下面试iOS开发我常用三方库


1、《XHLaunchAd》开屏广告、启动广告解决方案-支持静态/动态图片广告/mp4视频广告。支持pod，下载地址：https://github.com/CoderZhuXH/XHLaunchAd 


2、《KTVHTTPCache》KTVHTTPCache是一个智能媒体缓存视频框架。它可以缓存HTTP请求，非常适合媒体资源。支持pod下载地址：https://github.com/ChangbaDevs/KTVHTTPCache


3、《ZFPlayer》紫枫视频播放器支持定制任何播放器SDK和控制。支持pod，下载地址：https://github.com/renzifeng/ZFPlayer


4、《AvoidCrash》crash拦截友好化提示，项目不崩溃。支持pod，下载地址：https://github.com/chenfanfang/AvoidCrash


5、《TZImagePickerController》一个支持多选、选原图和视频的图片选择器，同时有预览、裁剪功能，支持pod，下载地址：https://github.com/banchichen/TZImagePickerController

最新发现照片选择器：HXPhotoPicker  地址：https://github.com/SilenceLove/HXPhotoPicker  

5.1、《BMDragCellCollectionView》lCollectionView拖动排序，类似照片选择发布拖动图片，支持pod，下载地址：https://github.com/idhong/BMDragCellCollectionView



6、《NewPagedFlowView》卡片式3D轮播图，下载地址：https://github.com/PageGuo/NewPagedFlowView


7、《SDCycleScrollView》普通轮播图，下载地址：https://github.com/gsdios/SDCycleScrollView，控件轮播《LBCycleScrollView》：https://github.com/i-LB/LBCycleScrollView


8、《iRate》去App Store评分。下载地址：https://github.com/nicklockwood/iRate


9、《Masonry》布局，瞎子地址：https://github.com/SnapKit/Masonry


10、《MJRefresh》明杰刷新，下载地址：https://github.com/CoderMJLee/MJRefresh


11、《MJExtension》明杰Model，下载地址：https://github.com/CoderMJLee/MJExtension


12、《AFNetworking》网络请求，下载地址：https://github.com/AFNetworking/AFNetworking


13、《SDWebImage》图片加载。下载地址：https://github.com/rs/SDWebImage


14、《LZImageBrowser》仿微信图片浏览器，下载地址：https://github.com/liangzhen6/LZImageBrowser  新的图片浏览器地址（2020年2月18日）《YBImageBrowser》：https://github.com/indulgeIn/YBImageBrowser

#pragma mark ==========YBImageBrowser查看图片 S============
//点击查看图片
- (void)actionbigImageView:(UIImageView *)imageView {
    NSInteger index = imageView.tag-1000;
    //设置网络图片
    NSMutableArray *mArray = @[].mutableCopy;
    for (int i = 0; i < self.model.picArr.count; i++) {
        YBIBImageData *dataImage = [[YBIBImageData alloc]init];
        dataImage.imageURL = [NSURL URLWithString:self.model.picArr[i].picUrl];
        dataImage.projectiveView = self.imageViewArray[i];//图片父视图，转场动画用
        [mArray addObject:dataImage];
    }
    //浏览图片
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = mArray;//YBIBImageData图片数组
    browser.currentPage = index;//当前点击图片角标
    [browser show];//展示
}
#pragma mark ==========查看图片 E============


15、《MBProgressHUD》下载地址：https://github.com/jdg/MBProgressHUD

16、《SVProgressHUD》HUD指示器，下载地址：https://github.com/SVProgressHUD/SVProgressHUD

17、《JDStatusBarNotification》状态栏提醒，下载地址:https://github.com/calimarkus/JDStatusBarNotification

18、《XFAVFoundation》这是一个模仿iOS微信拍照，摄像，保存照片或视频到自己本地自定义app相册里面的demo，具有快速简易接入项目的接口。并通过 AVAssetWriter 实现高分辨率录制视频，生成低体积的视频文件。下载地址：https://github.com/LINGLemon/XFAVFoundation

19、《FDFullscreenPopGesture》是百度团队开发和维护的，使用方法十分简单。(注意：问题比较多，会影响到一些三方库，小心使用，还是用系统边缘侧滑返回吧)下载地址：https://github.com/forkingdog/FDFullscreenPopGesture

20、《YZDisplayViewController》快速集成App中顶部标题滚动条。类似今日头条。

21、《YYText》富文本处理，下载地址：https://github.com/ibireme/YYText

22、《BGFMDB》数据库，很好用。地址：https://github.com/huangzhibiao/BGFMDB

23、《FBShimmering》类似今日头条加载中动画闪动，很好用。地址：https://github.com/hsjcom/SoldierShimmering

24、《JXCategoryView》(腾讯新闻、今日头条、QQ音乐、网易云音乐、京东、爱奇艺、腾讯视频、淘宝、天猫、简书、微博等所有主流APP分类切换滚动视图) 地址：https://github.com/pujiaxin33/JXCategoryView

24.2 《GKPageScrollView》类似JXCategoryView，多层嵌套使用，有头部：https://github.com/QuintGao/GKPageScrollView

25、《GKNavigationBarViewController》（iOS自定义导航栏 - 导航栏联动效果，全屏滑动返回，左滑Push）https://github.com/QuintGao/GKNavigationBarViewController


25、《PPBadgeView》（tabbar上显示消息数量角标，或者小红点）https://github.com/jkpang/PPBadgeView

26、《BMDragCellCollectionView》（UICollectionViewCell拖拽重排）https://github.com/idhong/BMDragCellCollectionView


27、《BRPickerView》（日期选择器、时间选择器（DatePickerView）、地址选择器（AddressPickerView）、自定义字符串选择器（StringPickerView））https://github.com/91renb/BRPickerView


28、《JKCategories》一个有用的Objective-C类别（Category）集合，扩展iOS框架，如Foundation、UIKit、CoreData、QuartzCore、CoreLocation、MapKit等。https://github.com/shaojiankui/JKCategories


29、《GroupShadowTableView》让group tableview每个section拥有阴影和圆角。https://github.com/YyItRoad/GroupShadowTableView

30、《lottie-ios》播放UI给的动画，UI吧动画转成json文件。https://github.com/airbnb/lottie-ios

31、《ReactiveObjC》强大的iOS开发监听库。https://github.com/ReactiveCocoa/ReactiveObjC

