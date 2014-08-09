//
//  Task.m
//  gMission
//
//  Created by Joshua Zhao on 14-7-23.
//  Copyright (c) 2014年 Joshua Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"
#import "gMission-Swift.h"


@implementation Task

- (id)initWithBrief:(NSString *)brief {
    self = [super init];
    
    NSDate * date = [NSDate date];
    NSTimeInterval sec = [date timeIntervalSinceNow];
    NSTimeInterval end = [date timeIntervalSinceNow] + 30 * 60;
    
    NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
    NSDate * endDate = [[NSDate alloc] initWithTimeIntervalSinceNow:end];
    
//    //设置时间输出格式：
//    NSDateFormatter * df = [[NSDateFormatter alloc] init ];
//    [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
//    NSString * na = [df stringFromDate:currentDate];
    
    if (self != nil){
        //do initial class setup
        
        self.type = TASK_TYPE_DEFAULT;
        self.brief = brief;
        self.status = @"open";
        self.credit = 10;
        self.required_answer_count = 3;
        self.begin_time = currentDate;
        self.end_time = endDate;
        self.created_on = currentDate;
        self.location_id = 1;
        self.requester_id = 2;
//        self.attachment_id = [NSNumber numberWithInt:91];
    }
    return self;
}

//
//- (NSDictionary*) getDictionary{
//    NSDictionary * dict = [NSDictionary alloc];
//    
//    return ;
//}


@end