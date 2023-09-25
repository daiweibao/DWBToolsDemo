//
//  CXTabBarItemView.m
//  ProductInfoFlow
//
//  Created by Shen Yu on 16/4/8.
//  Copyright © 2016年 Shen Yu. All rights reserved.
//

#import "CXTabBarItemView.h"
//动画
#import "FLAnimatedImage.h"
#import "FLAnimatedImageView.h"

@interface CXTabBarItemView()
@property (nonatomic,strong) NSMutableArray *pImgArr;//图片名数组
@property (nonatomic,strong) NSMutableArray *pSelectedImgArr;//选中图片名

@property (nonatomic, strong) NSMutableArray * buttonArray;//存放每一个按钮的父视图
@property (nonatomic,weak) UIButton *selectedView;//记录当前选中的item的view

@property (nonatomic, strong) UIButton *buttonTu;//突出的tabbar按钮

@end

@implementation CXTabBarItemView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.pImgArr = [NSMutableArray array];
        self.pSelectedImgArr = [NSMutableArray array];
        self.buttonArray = [NSMutableArray array];
        //创建UI、背景图片等
        [self createUI];
        //在这里注册通知
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectTabbar:) name:@"selectTabbar" object:nil];
    }
    return self;
}

//重写hitTest方法，去监听发布按钮的点击，目的是为了让凸出的buttonTu按钮部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    //【⚠️⚠️⚠️注意：hitTest方法只能在添加到self.view的.m里实现才生效，如果hitTest方法所在view没有addSubview添加到self.view上，那么hitTest将无效。】
    
    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
    //在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
    //是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (self.isHidden == NO) {
        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.buttonTu];
        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [self.buttonTu pointInside:newP withEvent:event]) {
            return self.buttonTu;
        }else{//如果点不在发布按钮身上，直接让系统处理就可以了
            return [super hitTest:point withEvent:event];
        }
    }else {//tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
}

//创建tababr的UI，比如背景色，黑线等
- (void)createUI{
    //tabbar背景图
    CGFloat imagebgH = GetImageHeight(SCREEN_WIDTH, 1500, 206);
    
    //底部白色背景
    UIView *viewSafeBottom = [[UIView alloc]init];
    viewSafeBottom.frame = CGRectMake(0, imagebgH-2, SCREEN_WIDTH, MC_TabbarHeight);
    viewSafeBottom.backgroundColor = [UIColor whiteColor];
    [self addSubview:viewSafeBottom];
    //背景图片，添加到myTabBarView上显示不出来，只能添加到self.bottomView上
    UIImageView *imageTabbarView = [[UIImageView alloc]init];
    imageTabbarView.frame = CGRectMake(0, 0, SCREEN_WIDTH, imagebgH);
    imageTabbarView.image = [UIImage imageNamed:@"tabbar_bg"];
    [self addSubview:imageTabbarView];
    
    //创建tababr按钮UI
    [self createTabbarUI];
    
    //tabbar底部黑线
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 1)];
//    lineView.backgroundColor = UIColorFromRGB(0xEBEBEB);
//    [self addSubview:lineView];
}

//创建tababr按钮UI
- (void)createTabbarUI{
    //tabbar默认图片
    NSArray *images = @[@"tab_headlines_normal",@"tab_mall_normal",@"tab_personal_normal"];
    //tabbar选中图片
    NSArray *selectImages = @[@"tabbarTest",@"tabbarTest",@"tabbarTest"];
    //tabbar标题
    NSArray *titles = @[@"首页", @"商城",@"我的"];
    
    for (int i = 0 ; i < titles.count; i++) {
        //设置每一个item
        [self.pImgArr addObject:images[i]];//非选中图片数组
        [self.pSelectedImgArr addObject:selectImages[i]];//选中图片数组

        //计算每一个按钮的宽度
        CGFloat singleWidth = [[UIScreen mainScreen] bounds].size.width/titles.count;
        //每一个按钮的父视图
        UIButton *bgImgView = [UIButton buttonWithType:UIButtonTypeCustom];
        bgImgView.frame =CGRectMake(singleWidth * i, 0, singleWidth, MC_TabbarHeight);
        bgImgView.tag = i;
        bgImgView.userInteractionEnabled = YES;//关闭button的高亮
        [bgImgView addTarget:self action:@selector(actionBgImgView:) forControlEvents:UIControlEventTouchUpInside];
        bgImgView.backgroundColor = [UIColor clearColor];
        [self addSubview:bgImgView];
        [self.buttonArray addObject:bgImgView];//按钮添加到数组
        
        if(i==1){
            //中间突出按钮
            self.buttonTu = [UIButton buttonWithType:UIButtonTypeCustom];
            self.buttonTu.frame = CGRectMake((bgImgView.width-50)/2, -25, 50, 50);
            [self.buttonTu setBackgroundImage:[UIImage imageNamed:@"tab_activity"] forState:UIControlStateNormal];
            self.buttonTu.adjustsImageWhenHighlighted = NO;//关闭高亮
            [self.buttonTu addTarget:self action:@selector(actionButtonTu) forControlEvents:UIControlEventTouchDown];
            [bgImgView addSubview:self.buttonTu];
            
        }else{
            //给item添加图标--动画
            FLAnimatedImageView *imgView = [[FLAnimatedImageView alloc]initWithFrame:CGRectMake((singleWidth - 25)/2.0, 5, 25, 25)];
            [imgView setImage:[UIImage imageNamed:images[i]]];//设置非选中的图片
            [bgImgView addSubview:imgView];
            
        }
        //按钮标题
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 34, singleWidth, 15)];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = UIColorFromRGB(0x333333);
        titleLabel.text = titles[i];//设置tababr标题
        [bgImgView addSubview:titleLabel];
        
        
        //App启动默认选中第一个按钮
        if (i == 0) {
            [self actionBgImgView:self.buttonArray.firstObject];
        }
    }
}


//点击突出按钮
- (void)actionButtonTu{
    [self actionBgImgView:self.buttonArray[1]];
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
                
                //设置非动画图
//                [imgView setImage:[UIImage imageNamed:_pSelectedImgArr[bgImgView.tag]]];
                
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
