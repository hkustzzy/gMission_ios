//
//  LocationRectangle.h
//  gMission
//
//  Created by Joshua Zhao on 14-7-28.
//  Copyright (c) 2014年 Joshua Zhao. All rights reserved.
//


//
//var id:Int?
//var location_id:Int?
//var left_top_longitude:Double?
//var left_top_latitude:Double?
//var right_bottom_longitude:Double?
//var right_bottom_latitude:Double?

#import <JSONModel/JSONModel.h>
@interface LocationRectangle: JSONModel

@property (assign, nonatomic) int id;
@property (assign, nonatomic) int location_id;
@property (assign, nonatomic) double left_top_longitude;
@property (assign, nonatomic) double left_top_latitude;
@property (assign, nonatomic) double right_bottom_longitude;
@property (assign, nonatomic) double right_bottom_latitude;

@end