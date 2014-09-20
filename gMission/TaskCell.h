//
//  MyTasksCell.h
//  gMission
//
//  Created by Joshua Zhao on 14-8-25.
//  Copyright (c) 2014年 Joshua Zhao. All rights reserved.
//

#ifndef gMission_MyTasksCell_h
#define gMission_MyTasksCell_h



@interface TaskCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UIImageView *Headerphoto;

@property (weak, nonatomic) NSDictionary* data;

@end



#endif
