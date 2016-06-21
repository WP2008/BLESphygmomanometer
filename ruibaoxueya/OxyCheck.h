//
//  OxyCheck.h
//  ruibaoxueya
//
//  Created by zbf on 14-4-22.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdInfo.h"
@interface OxyCheck : NSObject
{}

-(int)check:(AdInfo *)model;
-(int)checkHigh:(AdInfo *)model;
-(int)checkMin:(AdInfo *)model;
-(int)checkHighEx:(AdInfo *)model;
-(int)checkMinEx:(AdInfo *)model;
-(int)checkPulse:(AdInfo *)model;
-(int)checkPj:(AdInfo *)model;
-(int)checkMc:(AdInfo *)model;
-(NSString*)getHighInfo:(int)type;
-(NSString*)getMinInfo:(int)type;
-(NSString*)getPulseInfo:(int)type;
-(NSString*)getPjInfo:(int)type;
-(NSString*)getMCInfo:(int)type;
@end
