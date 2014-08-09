//
//  BusPointCell.m
//  ZNBC
//
//  Created by 杨晓龙 on 13-4-11.
//  Copyright (c) 2013年 yangxiaolong. All rights reserved.
//

#import "Bubble.h"

@implementation Bubble

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"initWithFrame");
        self.layer.borderColor = [UIColor blueColor].CGColor;
        [[self naviButton] setBackgroundColor:[UIColor blueColor]];
        [[self naviButton] layer];
        self.naviButton.layer.cornerRadius = 10;
    }
    
    return self;
}


//- (void)dealloc {
//    [_aliasLabel release];
//    [_speedLabel release];
//    [_degreeLabel release];
//    [_nameLabel release];
//    [super dealloc];
//}
@end
