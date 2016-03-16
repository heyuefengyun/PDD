//
//  HomeViewController.swift
//  PDD
//
//  Created by 周磊 on 16/3/15.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,RequestDataDelegate,HomeRollDataDelegate {

    var tableView:UITableView?
    var dataArray = [HomeTotalData]()
    var homeRollArray = [HomeRollModel]()
    var homeHeaderView = HomeHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = BgColor
        
        tableView = UITableView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight))
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.backgroundColor = BgColor
        tableView?.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView!.registerClass(HomeMainTableViewCell.self, forCellReuseIdentifier:"HomeMainTableViewCell")
        tableView!.registerClass(HomeFirstTableViewCell.self, forCellReuseIdentifier:"HomeFirstTableViewCell")
        
        homeHeaderView = HomeHeaderView(frame: CGRectMake(0, 0, ScreenWidth, 300))
        tableView!.tableHeaderView = homeHeaderView;
        view.addSubview(tableView!)
        
        
        let homeRequest = RequestData()
        homeRequest.delegate = self
        self.showHUD()
        homeRequest.requestData()
        
        
        let homeRoll = HomeRollData()
        homeRoll.delegate = self
        homeRoll.requestData()
        
        
        
    }
// MARK: - RequestDataDelegate
    func request(goods_listArray:NSArray){

        self.hideHUD()
        dataArray = goods_listArray as! [HomeTotalData];
        tableView?.reloadData()
    }
    
// MARK: - HomeRollDataDelegate
    func requestResult(homeRollDataArray:NSArray) {
        
        homeRollArray = homeRollDataArray as! [HomeRollModel]
        homeHeaderView.reloadData(homeRollArray)
    }
    
// MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var home = HomeTotalData()
        home = dataArray[indexPath.row]

        switch home.cellType {
        case .group:
            
            let  cell = tableView.dequeueReusableCellWithIdentifier("HomeFirstTableViewCell", forIndexPath: indexPath) as! HomeFirstTableViewCell
            cell.backgroundColor = BgColor
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.releaseData(home)
            return cell
            
        case .common:
            
            let  cell = tableView.dequeueReusableCellWithIdentifier("HomeMainTableViewCell", forIndexPath: indexPath) as! HomeMainTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.backgroundColor = BgColor
            cell.releaseData(home)

            return cell
            
            
        default:
            
            let cellid = "cell"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellid)
            if cell == nil {
                
                cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: cellid)
                cell!.selectionStyle = UITableViewCellSelectionStyle.None

            }
            
            cell?.textLabel?.text = home.home_recommend.desc

            return cell!
            
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
       
        var home = HomeTotalData()
        home = dataArray[indexPath.row]
        
        switch home.cellType {
        case .group:
            
            return 80
            
        case .common:
    
            let  height=home.good_list.goods_name!.stringHeightWith(15,width:(ScreenWidth-20))
            
            return (180 + 85 + height)
            
        default:
            
            return 250
            
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("\(indexPath.row)")

    }
    

    
}
