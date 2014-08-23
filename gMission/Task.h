//
//  Task.h
//  gMission
//
//  Created by Joshua Zhao on 14-7-23.
//  Copyright (c) 2014年 Joshua Zhao. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "Location.h"



@interface Task: JSONModel

@property (strong, nonatomic) NSString* type;
@property (assign, nonatomic) int id;
@property (strong, nonatomic) NSString* brief;
@property (strong, nonatomic) NSString* status;
@property (assign, nonatomic) int credit;
@property (assign, nonatomic) int required_answer_count;
@property (assign, nonatomic) int location_id;
@property (assign, nonatomic) int requester_id;
@property (strong, nonatomic) NSDate<Optional>* begin_time;
@property (strong, nonatomic) NSDate<Optional>* end_time;
@property (strong, nonatomic) NSDate<Optional>* created_on;
@property (assign, nonatomic) Location<Optional>* location;
@property (assign, nonatomic) NSString<Optional>* location_name;
@property (assign, nonatomic) NSNumber<Optional>* attachment_id;

- (id)initWithBrief:(NSString*)brief;


@end

//let TASK_TYPE_DEFAULT = "mix"
//let TASK_TYPE_TEXT = "text"
//let TASK_TYPE_PHOTO = "image"
//let TASK_TYPE_PHOTO = "video"
//var id:Int
//var type: String
//var brief: String
//var attachment_id: Int?
//var status:String
//var credit:Int
//var required_answer_count:Int
//var begin_time: NSDate
//var end_time:NSDate
//var created_on:NSDate?
//var location_id:Int
//var requester_id:Int
//var location:Location?
