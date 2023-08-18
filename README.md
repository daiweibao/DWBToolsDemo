# DWBToolsDemo

工具类，后面包含gith的token使用方法

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


6、《NewPagedFlowView》卡片式3D轮播图，下载地址：https://github.com/PageGuo/NewPagedFlowView


7、《SDCycleScrollView》普通轮播图，下载地址：https://github.com/gsdios/SDCycleScrollView，控件轮播《LBCycleScrollView》：https://github.com/i-LB/LBCycleScrollView


8、《iRate》去App Store评分。下载地址：https://github.com/nicklockwood/iRate


9、《Masonry》布局，瞎子地址：https://github.com/SnapKit/Masonry


10、《MJRefresh》明杰刷新，下载地址：https://github.com/CoderMJLee/MJRefresh


11、《MJExtension》明杰Model，下载地址：https://github.com/CoderMJLee/MJExtension


12、《AFNetworking》网络请求，下载地址：https://github.com/AFNetworking/AFNetworking


13、《SDWebImage》图片加载。下载地址：https://github.com/rs/SDWebImage


14、《LZImageBrowser》仿微信图片浏览器，下载地址：https://github.com/liangzhen6/LZImageBrowser

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



=================分割线==================
补充：github推代码报错-需要token，处理：

1、报错内容：remote: Support for password authentication was removed on August 13, 2021.
翻译：远程:在2021年8月13日删除了对密码验证的支持。

2、（1）去github上创建token：点击头像-->Settings-->Developer settings—>然后选择Personal access tokens—>Generate new token
（2）填一个note（描述信息），设置一个token过期时间，如果是推送代码勾选repo ，最后 点击“Generate token”，就会生成一个token，记录一下我们这个token，一会再次push代码的时候要用到。
生成的git令牌token，例如：ghp_XXXXXXXXXXXXXXXJ

(3)在Sourcetree工具中使用：
git仓库地址拼接成：https://ghp_XXXXXXXXXXXXXXXJ@github.com/github用户名/github仓库名.git  然后重新克隆仓库（新建—从URL克隆）或者打开仓库—设置—修改远程仓库地址
