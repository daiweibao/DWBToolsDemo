//
//  FoundViewCell.swift
//  DWBToolsDemo
//
//  Created by chaoxi on 2019/3/25.
//  Copyright © 2019 chaoxi科技有限公司. All rights reserved.
//

import UIKit

class FoundViewCell: UITableViewCell {
    
    //懒加载名字：lazy
    //商品标题
    private lazy var nameLabel:UILabel = UILabel()
    //商品封面
    private lazy var imageCover:UIImageView = UIImageView()
    
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
    var model : FoundViewListModel_goods_list? {
        
        didSet {
            //商品封面
            imageCover.sd_setImage(with: URL(string:model?.goods_thumb ?? "" ), placeholderImage: UIImage(named: ""))
            
            //商品名字
            nameLabel.text = model?.goods_name
            
        }
        
        
    }
    
   private func createUI(){
    //商品封面
//    imageCover.frame = CGRect(x: 15, y: 15, width: 100, height: 100)
    imageCover.contentMode = .scaleAspectFill
    self.contentView.addSubview(imageCover)
    imageCover.snp.makeConstraints { (make) in
        make.top.equalTo(15.0)
        make.left.equalTo(15.0)
        make.width.equalTo(100.0)
        make.height.equalTo(100.0)
    }
    
    //商品标题
//    nameLabel.frame = CGRect(x: imageCover.rightX+10, y: 15, width: SCREEN_WIDTH-imageCover.rightX-10-15, height: 100)
    nameLabel.font = UIFont.systemFont(ofSize: 14)
    nameLabel.textColor = COLOR_Main
    nameLabel.numberOfLines = 0
    nameLabel.text = "测试数据"
    self.contentView.addSubview(nameLabel)
    nameLabel.snp.makeConstraints { (make) in
        make.top.equalTo(15)
        make.left.equalTo(imageCover.snp_right).offset(10)
        make.right.equalTo(-15)
    }
    
    
    
    }
    
}
