//
//  Category.h
//  gMission
//
//  Created by Joshua Zhao on 14-7-28.
//  Copyright (c) 2014年 Joshua Zhao. All rights reserved.
//

//var id:Int?
//var name:String?
//var urlname:String?

#import <JSONModel/JSONModel.h>
@interface LocationCategory: JSONModel

@property (assign, nonatomic) int id;
@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) NSString<Optional>* urlname;

@end