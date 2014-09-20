//
//  TaskCell.m
//  gMission
//
//  Created by Joshua Zhao on 14-8-25.
//  Copyright (c) 2014年 Joshua Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskCell.h"

@interface TaskCell()


@end

@implementation TaskCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    [self contentLabel] = [self data];
    
//    [self locationLabel] =
    
}

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        
        self.contentLabel.text = @"content";
        self.locationLabel.text = @"location";
        
        self.timeLabel.text = @"time";
        self.statusLabel.text = @"status";
        
//        self.contentView
    }
    
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
