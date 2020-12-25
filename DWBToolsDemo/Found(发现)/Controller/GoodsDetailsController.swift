//
//  GoodsDetailsController.swift
//  DWBToolsDemo
//
//  Created by chaoxi on 2019/4/3.
//  Copyright © 2019 chaoxi科技有限公司. All rights reserved.
//
//商品详情
import UIKit

class GoodsDetailsController: CXRootViewController {
    //商品Id
    var goodsId :String = String()
    //商品标题
    var goodsTitle :String = String()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.titleNavLabel.text = "商品详情"
        
        print("商品Id是：\(goodsId)\n商品名字是:\(goodsTitle)")
        
    }
    
    //视图将要消失的时候执行
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        
    }
    
    // Swift里面舍弃了OC的dealloc方法，经过笔者多方查阅资料下面方法可以替代dealloc方法
    deinit {
        
        print("走了dealloc")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
