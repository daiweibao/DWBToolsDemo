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
    
    var goods_name: String?
    
    var username: String?
    var age: Int?
    var weight: Double!
    var bestFriend: FoundViewListModel?        // User对象
    var friends: [FoundViewListModel]?         // Users数组
    var birthday: Date?
    var array: [AnyObject]?
    var dictionary: [String : AnyObject] = [:]
    
    init(){
    }
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        username    <- map["username"]
        age         <- map["age"]
        weight      <- map["weight"]
        bestFriend  <- map["best_friend"]
        friends     <- map["friends"]
        birthday    <- (map["birthday"], DateTransform())
        array       <- map["arr"]
        dictionary  <- map["dict"]
        goods_name  <- map["goods_name"]
    }

    
}
