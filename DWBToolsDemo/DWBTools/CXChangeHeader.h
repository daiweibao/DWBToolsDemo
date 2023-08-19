//
//  CXChangeHeader.h
//  DWBToolsDemo
//
//  Created by 季文斌 on 2023/8/19.
//  Copyright © 2023 潮汐科技有限公司. All rights reserved.
//
// 上线需要修改的header，一定要导入头文件
#ifndef CXChangeHeader_h
#define CXChangeHeader_h
/*
#ifdef只关心宏是否被定义，不关心宏逻辑的真假
 解释：#ifdef CXDEBUG表示 CXDEBUG 否被定义，如果定义了就走这里。上线手动注掉
*/

//DEBUG 设置方式：选择Product->Scheme->Edit Scheme ，App发布的时候,Build Configuration 这些全部都要改成release模式。
//iOS 系统debug模式和release模式
#ifdef DEBUG
//在系统的debug环境下定义自定义环境
#warning ---上线修改---
#define CXDEBUG //上线手动注掉这个定义，表示走生产环境，防止打包的时候忘记选Release环境

#else
//生产环境不定义
#endif


//------------生产环境服务器地址-----------




//------------测试环境服务器地址-----------


#endif /* CXChangeHeader_h */
