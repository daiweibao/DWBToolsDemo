//
//  NSNull+safe.h
//  NSNullDemo
//
//  Created by chaoxi on 2017/4/16.
//  Copyright © 2017年 chaoxi科技有限公司. All rights reserved.
//
//处理服务器返回的各种null，防止崩溃  利用消息转发解决服务器返回NSNull问题
#import <Foundation/Foundation.h>

@interface NSNull (safe)

@end


/*
 
 问题描述
 
 众所周知,服务器返回的数据时不时的就不靠谱一下
 
 {
 "名字":"漂亮妹子",
 "备胎们":,
 "年纪":18
 }

 明明木有备胎, 结果返回@[]也好啊, 偏偏返回一个null.
 这个时候呢, 我们native端就得在取倒数据的时候, 先判断类型是不是NSArray 还得判断非空
 
 NSArray *boys = data[@"备胎们"];
 if ([boys isKindOfClass:[NSArray class]] && boys.count > 0)
 {
 doSomething

 校验的代码写多了总是很影响心情, 服务器就不能加个空的就不返回或者返回@[]么, 就不能让我们安心的写个备胎1号 = boys[0]么?
 
 解
 
 让我们来看看奇技的解决办法吧.
 
 思路:重写NSNull的消息转发方法, 让他能处理这些异常的方法.
 
 消息转发的相关知识不了解的同学需要自行搜索下. 在写的时候,我们要考虑 @"",@0,@{},@[]这几种常用的类型空值, 再问到NSNull的一些不属于它的方法的时候, 如果那些空值可以响应的时候就丢给他们去处理去.
 
 // count理所当然的就等于0了
 int count = boys.count;
 
 奇技有了, 接着是yin巧.
 
 如果我们要二号备胎囧么办?
 
 id boy = boys[1];
 
 这可就直接越界了啊. 我们仔细的看下NSArray里的方法, 是不是发现一个规律, 基本上返回的是id类型的是取里面的元素的. 既然这样, 那么我们就干脆只要你问NSArray里要一个元素, 我就都返回’nil’给你.
 
 if (strcmp(anInvocation.methodSignature.methodReturnType, "@") == 0)
 {
 anInvocation.selector = @selector(__uxy_nil);
 [anInvocation invokeWithTarget:self];
 return;
 }
 
 - (id)__uxy_nil
 {
 return nil;
 }
 ---------------------
 作者：uxyheaven
 来源：CSDN
 原文：https://blog.csdn.net/uxyheaven/article/details/48299599
 版权声明：本文为博主原创文章，转载请附上博文链接！
 
 */
