//
//  FoundViewListModel.swift
//  DWBToolsDemo
//
//  Created by 戴维保 on 2019/3/25.
//  Copyright © 2019 潮汐科技有限公司. All rights reserved.
//

import UIKit

class FoundViewListModel: NSObject {

    //Int类型等基本数据类型要初始化，否则崩溃
    //商品名字
    var goods_name: String?
    ///商品封面
    var goods_thumb: String?
    
    
    
    //是否关注(这种类型要初始化)
    var isFocus = false
    
}
