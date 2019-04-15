//
//  FoundViewController.swift
//  DWBToolsDemo
//
//  Created by 戴维保 on 2019/3/25.
//  Copyright © 2019 潮汐科技有限公司. All rights reserved.
//

import UIKit

class FoundViewController: CXRootViewController, UITableViewDelegate, UITableViewDataSource{

    //tableview
    private var tableView: UITableView = UITableView(frame: CGRect(x: 0, y: MC_NavHeight(), width: SCREEN_WIDTH, height: SCREEN_HEIGHT-MC_NavHeight()-MC_TabbarHeight()), style: .plain)
    
    //分页加载的页码初始化
    private var currentPage  = 1
    
    //懒加载数据源-可变数组用Var，类型自动推导,数组字典都用[]
    private lazy var dataSouce = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.backButton.isHidden = true
        self.titleNavLabel.text = "发现";
        
        //创建tableview
        createTableView()
        
        //数据
        loadData()
        //刷新
        refresh()
    
        // Do any additional setup after loading the view.
    }
    
    //刷新
    func refresh(){
        //下拉刷新
        DWB_refreshHeader.dwb_RefreshHeaderAddview(tableView, refreshType: "") {
            self.currentPage = 0
            self.loadData()
        }
        
        //上拉加载
        DWB_refreshFooter.dwb_RefreshFooterAddview(tableView) {
            
            self.currentPage += 1
            self.loadData()
        }
        
    }
    
    
    //请求数据
    func loadData(){
        
//         let parametersDict = [String : String]()
        //数据请求参数:platform传一个空字典
        let platformDict = ["platform" : [String : NSObject]()]
//        //字典有参数
//        let parametersDict = ["platform" : [String : NSObject](),
//                              "page_size": 20,
//                              "page_no": currentPage,
//            ] as [String : Any]
        
        DWBAFNetworking.post(DWBPromotion, parameters:platformDict, controller: self, type: nil, success: { (responseObject) in
            let responseObject = responseObject as AnyObject//数据转换
            //判断请求成功
            if responseObject["status"] as! NSNumber == 1 {
                //请求成功
                //取出字典
                let dataDict = responseObject["data"] as! [String : AnyObject]
//                //取出数组
//                let move_regions :[[String:AnyObject]] = dataDict["move_regions"] as! [[String : AnyObject]]
//
//                let move_regionsFirst:[String:AnyObject] = move_regions[0] as [String:AnyObject]
//
//                let goods_list :[[String:AnyObject]] = move_regionsFirst["goods_list"] as! [[String : AnyObject]]
                
                if self.currentPage == 1 {
                    //刷新时移除所有数据
                    self.dataSouce.removeAll()
                }
                
                //转模型
                let model = FoundViewListModel(JSON: dataDict)
                //添加数据到数组
                let goods_list = model?.move_regions?.first?.goods_list
                //数组追加
                self.dataSouce = self.dataSouce + goods_list!
                
                //主线程
                  DispatchQueue.main.async {
                    
                    //结束刷新
                    self.tableView.endRefresh_DWB()
                    
                    //刷新表格
                    self.tableView.reloadData()

                }


            }else{

               MBProgressHUD.showError("数据请求失败")
            }

        }) { (error) in


        }
        
    }
    
    
    // MARK: -创建tableview
    func createTableView (){
        
        tableView.delegate=self//实现代理
        tableView.dataSource=self;//实现数据源
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        //去分割线
//        tableView.separatorStyle = .none
//        tableView.backgroundColor = UIColor.groupTableViewBackground
        //添加
        view.addSubview(tableView)
    
        //注册cell重用
        tableView.register(FoundViewCell.self , forCellReuseIdentifier: "FoundViewCell")
        
    }
    
    // MARK: -table代理
    
    //段数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSouce.count
    }
    
    //行高
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
    //头部高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    //底部高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    //cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoundViewCell", for: indexPath) as! FoundViewCell
        //cell
        cell.selectionStyle = .none
        
        //数据传给cell
        cell.model = dataSouce[indexPath.row] as? FoundViewListModel_goods_list
        
        return cell
    }
    
    //选中cell时触发这个代理
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        print("点击cell")
        let model = dataSouce[indexPath.row] as! FoundViewListModel_goods_list
        let VC = GoodsDetailsController()
        VC.goodsTitle  = model.goods_name ?? ""
        VC.goodsId = model.goods_id ?? ""
        self.navigationController?.pushViewController(VC, animated: true)
        
        
        
    }

    
    
    //视图将要出现的时候执行
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        //print("将要出现")
        //请求数据
       loadData()
        
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
