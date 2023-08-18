
///一些文档使用指南
/**
 
 一、Sourcetree使用指南

 1、拉代码：拿到仓库地址后打开Sourcetree 选择：新建 -> 从URL克隆。

 2、删除本地最近未提交的变更：Sourcetree打开项目后 -> 文件状态 -> 鼠标右键选择重置。

 3、日常拉代码：【拉取】  日常提交代码：提交代码后选择【推送】

 4、解决Mac下SourceTree每次都让输入密码的问题：
 （1）在终端 cd进入项目目录，输入：git config --global credential.helper store
 （2）在source tree更新代码，提示输入密码，输入一次后以后就不需要输入了

 
 
=======================分割线====================
 
 二、github推代码报错-需要token，处理：

 1、报错内容：remote: Support for password authentication was removed on August 13, 2021.
 翻译：远程:在2021年8月13日删除了对密码验证的支持。

 2、去github上创建token：
 点击头像-->Settings-->Developer settings—>然后选择Personal access tokens—>Generate new token

 填一个note（描述信息），设置一个token过期时间，如果是推送代码勾选repo ，最后 点击“Generate token”，就会生成一个token，记录一下我们这个token，一会再次push代码的时候要用到

 生成的git令牌token，例如：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


 3、在Sourcetree工具中使用：
 git仓库地址拼接成：https://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@github.com/daiweibao/DWBToolsDemo.git  然后重新克隆仓库（新建—从URL克隆）或者打开仓库—设置—修改远程仓库地址
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 */

