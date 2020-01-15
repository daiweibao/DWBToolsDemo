//
//  CXNavigationController.m
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2018/3/19.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//

#import "CXNavigationController.h"

@interface CXNavigationController () <UIGestureRecognizerDelegate>

//自定义一个侧滑手势阻止部分界面不开启侧滑返回
@property(nonatomic,weak)UIPanGestureRecognizer *popRecognizerMy;

@end

@implementation CXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //（方法一）开启系统边缘侧滑返回
    self.interactivePopGestureRecognizer.delegate = (id)self;
    
}
//系统侧滑返回拦截，必须拦截不然会造成问题，导致跟控制器tabbar有时候会消失
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    //跟控制器不做侧滑返回
    if (self.childViewControllers.count==1) {
        return NO;
    }else{
        //在这里拦截不开启侧滑返回的界面，如登陆界面
        UIViewController * coller = (UIViewController *)NSClassFromString(@"LoginViewController");
        if ([self.topViewController isKindOfClass:[coller class]]) {
            return NO;
        }else{
            return YES;
        }
    }
}

/*

//只需要在当前使用的控制器中重写这两个方法就可以了，第一次push进来的时候两个方法都会调用，parent的值不为空。当开始使用系统侧滑的时候，会先调用willMove，而parent的值为空；当滑动结束后返回了上个页面，则会调用didMove，parent的值也为空，如果滑动结束没有返回上个页面，也就是轻轻划了一下还在当前页面，那么则不会调用didMove方法。
//所以如果想要在侧滑返回后在上个页面做一些操作的话，可以在didMove方法中根据parent的值来判断。
//这两个方法是系统写的类别UIContainerViewControllerCallbacks中的方法。
- (void)willMoveToParentViewController:(UIViewController*)parent{
    [super willMoveToParentViewController:parent];
    NSLog(@"%s,%@",__FUNCTION__,parent);
}
- (void)didMoveToParentViewController:(UIViewController*)parent{
    [super didMoveToParentViewController:parent];
    NSLog(@"%s,%@",__FUNCTION__,parent);
    if(!parent){
        NSLog(@"页面pop成功了");
    }
}

 */


/**
 * 可以在这个方法中拦截所有push进来的控制器,处理push后控制器底部有49高度位置点击效果无效  MDDateVC.hidesBottomBarWhenPushed = YES;
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        //隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        //影藏tabbar
        viewController.tabBarController.tabBar.hidden = YES;
    }

    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
    
    //处理了push之h后隐藏底部UITabBar的情况，并解决了iphonex上push时，UITabBar上移的问题
    CGRect rect = self.tabBarController.tabBar.frame;
    rect.origin.y = [UIScreen mainScreen].bounds.size.height - rect.size.height;
    self.tabBarController.tabBar.frame = rect;

}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //导航栏颜色--去修改CXRootViewController里面的颜色
    self.navigationBar.barTintColor = [UIColor whiteColor];
    
    //关闭导航栏半透明
    self.navigationBar.translucent = NO;
    
    
    /*
    //设置导航栏背景色，用图片，不然下面黑线无法消除
    UIImage *lineimageNav = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 0.5)];
    [self.navigationBar setBackgroundImage:lineimageNav forBarMetrics:UIBarMetricsDefault];
    //去掉黑线
    [self.navigationBar setShadowImage:[UIImage new]];
    //根据颜色生成一张灰色的背景图片   替换导航栏的下边的分割线
    UIImage *lineimage = [UIImage imageWithColor:[UIColor colorWithHexString:@"#D8D8D8"] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 0.5)];
    [self.navigationBar setShadowImage:lineimage];
    */

    
    /*
    //设置指定控制器导航栏颜色
    //导航栏颜色默认颜色--将要出现（当前控制前导航栏颜色）
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
     //导航栏下面那条线的颜色
     [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor redColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 1)]];
    
    //导航栏颜色默认颜色--将要消失（默认颜色）
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
     //导航栏下面那条线的颜色
     [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor groupTableViewBackgroundColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 1)]];
    */
    
    //设置阴影
//    [self setUpNavShadow];
    
}

/*
//设置导航阴影【代码暂时不用】
-(void)setUpNavShadow{
    //1.设置阴影颜色
    
    self.navigationBar.layer.shadowColor = [UIColor blackColor].CGColor;
    
    //2.设置阴影偏移范围
    
    self.navigationBar.layer.shadowOffset = CGSizeMake(0, 2);
    
    //3.设置阴影颜色的透明度
    
    self.navigationBar.layer.shadowOpacity = 0.1;
    
    //4.设置阴影半径
    
    self.navigationBar.layer.shadowRadius = 1;
    
    //5.设置阴影路径
    
    self.navigationBar.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.navigationBar.bounds].CGPath;
}

*/



/*
 //修改导航栏push动画
 push：
 
 CATransition *transition = [CATransition animation];
 transition.duration = 0.4f;
 transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
 transition.type = kCATransitionMoveIn;
 transition.subtype = kCATransitionFromTop;
 transition.delegate = self;
 [self.navigationController.view.layer addAnimation:transition forKey:nil];
 [self.navigationController pushViewController:controller animated:NO];
 
 pop：
 
 CATransition *transition = [CATransition animation];
 transition.duration = 0.3f;
 transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
 transition.type = kCATransitionReveal;
 transition.subtype = kCATransitionFromBottom;
 transition.delegate = self;
 [self.navigationController.view.layer addAnimation:transition forKey:nil];
 [self.navigationController popViewControllerAnimated:NO];
 
 注意：animated一定要设置为：NO
 
 */


#pragma mark ====================== 处理屏幕旋转--UINavigationController+Tabbar控制器里也在用===================
// 是否支持自动转屏
- (BOOL)shouldAutorotate
{
    return [self.visibleViewController shouldAutorotate];
}
// 支持哪些屏幕方向 topViewController(push)
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.topViewController supportedInterfaceOrientations];
}

// 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）visibleViewController(模态)
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.visibleViewController preferredInterfaceOrientationForPresentation];
}



//#pragma 在需要支持旋转的控制器里加入如下三个方法====YES代表支持旋转
////视图控制器实现的方法
//-(BOOL)shouldAutorotate{       //iOS6.0之后,要想让状态条可以旋转,必须设置视图不能自动旋转
//    return YES;
//}
//// 支持哪些屏幕方向
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskPortrait;
//}
//
//// 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    return UIInterfaceOrientationPortrait;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
