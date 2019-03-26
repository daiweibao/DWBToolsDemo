//
//  FoundViewCell.swift
//  DWBToolsDemo
//
//  Created by 戴维保 on 2019/3/25.
//  Copyright © 2019 潮汐科技有限公司. All rights reserved.
//

import UIKit

class FoundViewCell: UITableViewCell {
    
    //懒加载名字：lazy
    private lazy var nameLabel:UILabel = UILabel()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        //设置背景色
//        contentView.backgroundColor = UIColor.groupTableViewBackground
        //创建UI
        createUI()
        
    }
    //必须
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //数据
    var model : FoundViewListModel? {
        
        didSet {
            
            nameLabel.text = model?.goods_name
            
        }
        
        
    }
    
   private func createUI(){
    nameLabel.frame = CGRect(x: 15, y: 0, width: 200, height: 44)
    nameLabel.font = UIFont.systemFont(ofSize: 14)
    nameLabel.textColor = UIColor.red
    nameLabel.text = "测试数据"
    self.contentView.addSubview(nameLabel)
    
    }
    
}
