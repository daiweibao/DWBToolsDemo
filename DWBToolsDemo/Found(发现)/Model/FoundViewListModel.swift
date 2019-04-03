//
//  FoundViewListModel.swift
//  DWBToolsDemo
//
//  Created by 戴维保 on 2019/3/25.
//  Copyright © 2019 潮汐科技有限公司. All rights reserved.
//
import UIKit
import ObjectMapper
class FoundViewListModel: Mappable {
    //初始化
    required init?(map: Map) {
    }
    //外层数组
    var move_regions: [FoundViewListModel_move_regions]?

    // Mappable
    func mapping(map: Map) {
         move_regions     <- map["move_regions"]
    }
}


class FoundViewListModel_move_regions: Mappable {
    required init?(map: Map) {
        
    }
    
     var desc_en: String?
    
     var goods_list: [FoundViewListModel_goods_list]?// Users数组
    
    func mapping(map: Map) {
         goods_list     <- map["goods_list"]
    }

}

class FoundViewListModel_goods_list: Mappable {
    required init?(map: Map) {
        
    }
    //商品图片
    var goods_name: String?
    //商品封面
    var goods_thumb: String?
    //商品Id
     var goods_id: String?
    
    
    func mapping(map: Map) {
     
        goods_name  <- map["goods_name"]
        goods_thumb  <- map["goods_thumb"]
        goods_id  <- map["goods_id"]
    }
    
  
    
}

