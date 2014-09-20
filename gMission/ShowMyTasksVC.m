//
//  ShowMyTasksVC.m
//  gMission
//
//  Created by Joshua Zhao on 14-8-24.
//  Copyright (c) 2014年 Joshua Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShowMyTasksVC.h"
#import "MJRefresh.h"
#import "TaskCell.h"
#import "gMission-Swift.h"


@interface ShowMyTasksVC () <APIControllerProtocol>

@end

@implementation ShowMyTasksVC

- (IBAction)showMenu
{
    [self.frostedViewController presentMenuViewController];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupRefresh];
}


- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    #warning 自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉可以刷新了";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    self.tableView.headerRefreshingText = @"正在加载";
    
//    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
//    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
//    self.tableView.footerRefreshingText = @"MJ哥正在帮你加载中,不客气";
}


#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 1.添加假数据
//    for (int i = 0; i<5; i++) {
//        [self.fakeData insertObject:MJRandomData atIndex:0];
//    }
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
    });
}

- (void) loadData
{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    cell.textLabel.text = @"test";
    
    TaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell" forIndexPath:indexPath];
    
    if (cell == nil) {
//        cell.data = 
        cell = [[TaskCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        
        
    }
//    cell.Headerphoto.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",indexPath.row%4+1]];
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



@end
