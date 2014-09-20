//
//  MyTasks.swift
//  gMission
//
//  Created by Joshua Zhao on 14-8-28.
//  Copyright (c) 2014年 Joshua Zhao. All rights reserved.
//

import UIKit


class MyTasks: UIViewController, APIControllerProtocol{

    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!

    var tableView:UITableView?

    @IBAction func showMenu(){
        self.frostedViewController.presentMenuViewController();
    }
    
    lazy var api: RESTClient = RESTClient(delegate:self)

//    func setupRefresh(){
//        self.tableView.addHeaderWithTarget(self, action: headerRereshing())
////        self.tableView.addHeaderWithTarget(self, action:headerRereshing())
////        self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
//        self.tableView.headerBeginRefreshing()
//    
//    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
//        self.tableView.headerPullToRefreshText = "下拉可以刷新了";
//        self.tableView.headerReleaseToRefreshText = "松开马上刷新了";
//        self.tableView.headerRefreshingText = "正在加载";
//    }

    func headerRereshing(){

    }

    func loadData(){

    }

//    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
//    {
//        
//    }
    
    

    func didReceiveAPIResults(results: NSDictionary) {
        
    }

    
    
}