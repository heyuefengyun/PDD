//
//  SearchViewController.swift
//  PDD
//
//  Created by 周磊 on 16/3/15.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,searchRequestDataDelegate {

    var tableView:UITableView?
    var request:SearchRequest?
    var dataArray = [SearchModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight), style: UITableViewStyle.Plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.backgroundColor = BgColor
        tableView?.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView?.registerClass(SearchTableViewCell.self, forCellReuseIdentifier: "SearchTableViewCell")
        self.view.addSubview(tableView!)
        
        request = SearchRequest()
        request!.searchRequest()
        request!.delegate = self
        self.showHUD()
    }
    
    
    func searchRequest(searchDataArray:[SearchModel]) {
        self.hideHUD()
        dataArray = searchDataArray
        
        let headerView = SearchHeaderView(frame:CGRectMake(0,0,ScreenWidth,40))
        headerView.backgroundColor = BgColor
        tableView?.tableHeaderView = headerView
        
        tableView?.reloadData()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let searchModel = dataArray[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchTableViewCell", forIndexPath: indexPath) as! SearchTableViewCell
        cell.backgroundColor = BgColor
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.reloaddata(searchModel, childrendatasouce: searchModel.children!)
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let searchModel = dataArray[indexPath.row]

        let divide:Float = Float((searchModel.children?.count)!)/4
        let result = Int(ceilf(divide))
        
        return CGFloat((result*30) + 60)
    }
    
}
