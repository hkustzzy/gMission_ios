//
//  CallOutAnnotationView.h
//  ZNBC
//
//  Created by 杨晓龙 on 13-4-11.
//  Copyright (c) 2013年 yangxiaolong. All rights reserved.
//

#import "BMKAnnotationView.h"
#import "Bubble.h"
//#import "gMission-Swift.h"
//
//@class LocationBubble;
//@interface LocationBubble : NSObject
//- (LocationBubble *) returnSwiftObject;
///* ... */
//@end



@interface CallOutAnnotationView : BMKAnnotationView


@property(nonatomic,retain) UIView *contentView;

//添加一个UIView
@property(nonatomic,retain) Bubble *busInfoView;//在创建calloutView Annotation时，把contentView add的 subview赋值给businfoView


@end
