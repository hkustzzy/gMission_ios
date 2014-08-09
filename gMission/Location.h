//
//  Location.h
//  gMission
//
//  Created by Joshua Zhao on 14-7-24.
//  Copyright (c) 2014年 Joshua Zhao. All rights reserved.
//

//"bound_id": 1,
//"category_id": 1,
//"id": 1,
//"latitude": 22.5404555,
//"longitude": 113.9785305,
//"name": "\u4e16\u754c\u4e4b\u7a97",
//"region_id": null,
//"z": 0



#import <JSONModel/JSONModel.h>
#import "LocationCategory.h"
@interface Location: JSONModel

@property (assign, nonatomic) int id;
@property (assign, nonatomic) NSNumber<Optional>* bound_id;
@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) NSNumber<Optional>* region_id;
@property (assign, nonatomic) double longitude;
@property (assign, nonatomic) double latitude;
@property (assign, nonatomic) int z;
@property (assign, nonatomic) NSNumber<Optional>* category_id;
@property (assign, nonatomic) LocationCategory<Optional>* category;
@property (assign, nonatomic) NSString<Optional>* category_name;

@end