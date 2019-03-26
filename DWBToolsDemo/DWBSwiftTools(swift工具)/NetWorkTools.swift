//
//  NetWorkTools.swift
//  ADNeterworingASnapKit
//
//  Created by 爱恨的潮汐 on 2017/1/17.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//
//导入Swift类型的三方库后这里必须加上AFNetworking，否则报错
//#swift 项目中通过pod导入swift项目，必须要使用use_frameworks！，在需要使用的到地方 import AFNetworking
import UIKit
import AFNetworking

enum HTTPMethod : Int{
    
    case  GET = 0
    case  POST = 1
}

class NetWorkTools: AFHTTPSessionManager {
    
    //单例
    static let shareInstance :NetWorkTools = {
       
        let tools = NetWorkTools()
        
//        tools.responseSerializer.acceptableContentTypes?.insert("application/json")
//        tools.responseSerializer.acceptableContentTypes?.insert("text/json")
//        tools.responseSerializer.acceptableContentTypes?.insert("text/javascript")
//        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
//        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
//        tools.responseSerializer.acceptableContentTypes?.insert("application/xml")
        
        
        var set:NSSet = NSSet.init(objects: "application/json","text/html","text/json","text/javascript","text/plain","application/xml")
        tools.responseSerializer.acceptableContentTypes = set as? Set<String>
        
//        @"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",@"application/xml"
        
        
        return tools
    }()

}


extension NetWorkTools {
    
    
    func request(requestType : HTTPMethod, url : String, parameters : [String : Any]?, succeed : @escaping(AnyObject?) -> (), failure : @escaping(Error?) -> ()) {
        
        // 成功闭包
        let successBlock = { (task: URLSessionDataTask, responseObj: Any?) in
//            succeed(responseObj as? [String : Any])
            //这种封装好，上面那种不好(guard let 守护神)
            guard let JSON = responseObj else {
                
//                print("数据返回为空")
                return
            }
            succeed(JSON as AnyObject?)


        }
        // 失败的闭包
        let failureBlock = { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        }
        // Get 请求
        if requestType == .GET {
            get(url, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }
        // Post 请求
        if requestType == .POST {
            post(url, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }
    }

    
    // MARK: - 封装 AFN 方法
    /// 上传文件必须是 POST 方法，GET 只能获取数据
    /// 封装 AFN 的上传文件方法
    ///
    /// - parameter URLString:  URLString
    /// - parameter parameters: 参数字典
    /// - parameter img:      UIImage对象
    /// - parameter completion: 完成回调
    func unload(urlString: String, parameters: AnyObject?, img : UIImage , uploadProgress: ((_ progress:Progress) -> Void)?, success: ((_ responseObject:AnyObject?) -> Void)?, failure: ((_ error: NSError) -> Void)?) -> Void {
        
        post(urlString, parameters: parameters, constructingBodyWith: { (formData) in
          
            // 创建 formData
            /**
             1. data: 要上传的二进制数据
             2. name: 服务器接收数据的字段名
             3. fileName: 保存在服务器的文件名，大多数服务器，现在可以乱写
             很多服务器，上传图片完成后，会生成缩略图，中图，大图...
             4. mimeType: 告诉服务器上传文件的类型，如果不想告诉，可以使用 application/octet-stream
             image/png image/jpg image/gif
             */
            
//            let imageData = UIImageJPEGRepresentation(img, 0.8)
//          
//            formData.appendPart(withFileData: imageData!, name: "upload", fileName: "head.img", mimeType: "image/jpeg")
            
        }, progress: { (progress) in
            uploadProgress!(progress)
//  上传进度条           print(progress.completedUnitCount/progress.totalUnitCount)
        }, success: { (task, objc) in
            if objc != nil {
                success!(objc as AnyObject?)
            }
        }, failure: { (task, error) in
            
            failure!(error as NSError)
            
        })
        
    }
    
}


/*
GET、POST请求数据用法Swift封装
fileprivate func getDataSourse(){
    
    NetWorkTools.shareInstance.request(requestType: .GET, url: "http://www.zimozibao.com:8080/zimoAppWS/cxf/rest/kecheng/getallKecheng?_type=json&index=\(page)&size=5", parameters: nil, succeed: {
        (objc) in
        print(objc!)
        
    }, failure: {
        (error) in
        
        print(error!)
    })
    
}
*/

/*
 //上传图片用法Swift封装
let dic = ["loginid":"861809565702204375","smark":"1"] as [String : String]

let img = UIImage(named: "suijilight")


NetWorkTools.shareInstance.unload(urlString: "http://www.zimozibao.com:8080/zimoAppWS/cxf/rest/userinfo/upload", parameters: dic as AnyObject?, img: img!, uploadProgress: {
    
    (progress) in //上传进度
    print(progress.completedUnitCount/progress.totalUnitCount)
    //            print(progress.totalUnitCount)
    
    
    
}, success:  {
    
    (objc) in
    print(objc!)
    
}, failure: {
    
    (error) in
    print(error)
})
*/


