//
//  TienUITabBar.m
//  ProductInfoFlow
//
//  Created by Shen Yu on 16/4/8.
//  Copyright © 2016年 Shen Yu. All rights reserved.
//

#import "TienUITabBar.h"
//动画
#import "FLAnimatedImage.h"
#import "FLAnimatedImageView.h"

@interface TienUITabBar()
@property (nonatomic,strong) NSMutableArray *pImgArr;//图片名数组
@property (nonatomic,strong) NSMutableArray *pSelectedImgArr;//选中图片名

@property (nonatomic, strong) NSMutableArray * buttonArray;//存放每一个按钮的父视图
@property (nonatomic,weak) UIView *selectedView;//记录当前选中的item的view

//
//@property(nonatomic, assign) int selectTag;//记录当前选中的tabbar角标
//@property(nonatomic, assign) int originalTag;

//退出登录的
@property(nonatomic, strong) UIImageView *loginOutImg;
@end
@implementation TienUITabBar

+ (TienUITabBar *)sharedManager{
    static TienUITabBar * manager;//类
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TienUITabBar alloc] init];
    });
    return manager;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.pImgArr = [NSMutableArray array];
        self.pSelectedImgArr = [NSMutableArray array];
        self.buttonArray = [NSMutableArray array];
        //在这里注册通知
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectTabbar:) name:@"selectTabbar" object:nil];
    }
    return self;
}

/// tabbar按钮创建，每一个item
/// - Parameters:
///   - image: 非选中图片数组
///   - selectedImage: 选中图片数组
///   - index: 当前角标
///   - navTitle: tabbar的名字
///   - tabbarArray: tabbar控制器数字
- (void)addTabBarBtnWithImage:(NSString *)image selectedImage:(NSString *)selectedImage atIndex:(int)index withTitle:(NSString *)navTitle  withTabbarArray:(NSArray*)tabbarArray{
    
    [self.pImgArr addObject:image];//非选中图片数组
    [self.pSelectedImgArr addObject:selectedImage];//选中图片数组

    //tabbar的高度
    CGFloat Hight = 49 + MC_TabbarSafeBottomMargin;
    //计算每一个按钮的宽度
    CGFloat singleWidth = [[UIScreen mainScreen] bounds].size.width/tabbarArray.count;
    //每一个按钮的父视图
    UIButton *bgImgView = [UIButton buttonWithType:UIButtonTypeCustom];
    bgImgView.frame =CGRectMake(singleWidth * index, 0, singleWidth, Hight);
    bgImgView.tag = index;
    bgImgView.highlighted = NO;//关闭button的高亮
    bgImgView.userInteractionEnabled = YES;
    [bgImgView addTarget:self action:@selector(actionBgImgView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bgImgView];
    
    [self.buttonArray addObject:bgImgView];//按钮添加到数组
    
    //给item添加图标--动画
    FLAnimatedImageView *imgView = [[FLAnimatedImageView alloc]initWithFrame:CGRectMake((singleWidth - 25)/2.0, 4, 25, 25)];
    [imgView setImage:[UIImage imageNamed:image]];//设置非选中的图片
    [bgImgView addSubview:imgView];
    
    //按钮标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, singleWidth, 17)];
    titleLabel.font = [UIFont systemFontOfSize:11];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = UIColorFromRGB(0xB3B3B3);
    titleLabel.text = navTitle;//设置tababr标题
    [bgImgView addSubview:titleLabel];
    
    //App启动默认选中第一个按钮
    if (index == 0) {
        [self actionBgImgView:self.buttonArray.firstObject];
    }
}

//底部tabBar点击选中
- (void)actionBgImgView:(UIButton *)button{
    int tapTag = (int)button.tag;
    if (tapTag == 2) {
        NSLog(@"点击了我的");
//        if (!Context.isLoginFlag) {
//            //跳转到登录界面
//            [[CXPushLoginHelp sharedManager] gotoLoginVC];
//            return;
//        }
    }
    
    //设置选中的图片
    //1、先把之前已经选中的设置成未选中
    [self changeImgAndTitle:self.selectedView isSelected:NO];
    //2、在设置要选中
    [self changeImgAndTitle:button isSelected:YES];
    //3、记录当前选中的item的view，注意顺序
    self.selectedView = button;
    //4、点击tabbar，代理回调tabbar控制器，去切换控制器
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedBtnTo:)] ){
        [self.delegate tabBar:self didSelectedBtnTo:tapTag];
    }
    
}

//设置选中的tabbar图片-gif
- (void)changeImgAndTitle:(UIView*)bgImgView isSelected:(BOOL)isSelect{
    //找到上面的子视图：图标+标题
    for (id object in bgImgView.subviews) {
        if ([object isKindOfClass:[FLAnimatedImageView class]]) {
            //图标：动画视图
            FLAnimatedImageView *imgView = (FLAnimatedImageView*)object;
            if (isSelect) {//选中
                //设置动画视图
                NSURL *url1 = [[NSBundle mainBundle] URLForResource:_pSelectedImgArr[bgImgView.tag] withExtension:@"gif"];
                NSData *data1 = [NSData dataWithContentsOfURL:url1];
                FLAnimatedImage *animatedImage1 = [FLAnimatedImage animatedImageWithGIFData:data1];
//                animatedImage1.loopCount = 1;//旧版本：循环次数，此方法暂时无法使用
                //新版本
                WeakSelf(imgView);
                [imgView setLoopCompletionBlock:^(NSUInteger loopCountRemaining) {
                    //动画播放完毕，停止播放动画
                    [weakimgView stopAnimating];
                }];
                imgView.animatedImage = animatedImage1;
                
            }else{
                //未选中图片
                [imgView setImage:[UIImage imageNamed:_pImgArr[bgImgView.tag]]];
            }
        }else if([object isKindOfClass:[UILabel class]]){
            //标题
            UILabel *titleLabel = (UILabel*)object;
            if (isSelect) {
                //选中的文字颜色
                titleLabel.textColor = UIColorFromRGB(0xE60113);
            }else{
                //未选中文字颜色
                titleLabel.textColor = UIColorFromRGB(0xB3B3B3);
            }
        }
    }
}

///选中一个指定tabbar，如登录成功后后选中首页等
- (void)selectMyTabbarItemWithIndex:(NSInteger )index{
    //去选中指定tabbar
    [self actionBgImgView:self.buttonArray[index]];
}

#pragma mark ----------收到通知相关S----------
- (void)selectTabbar:(NSNotification *)notification{
    NSDictionary *dic = notification.userInfo;
    NSInteger index = [[dic objectForKey:@"index"] integerValue];
    
    [self selectMyTabbarItemWithIndex:index];
}
#pragma mark ----------收到通知相关E----------

@end
