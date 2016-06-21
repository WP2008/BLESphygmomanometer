//
//  SysConfig.m
//  haihuang
//
//  Created by zbf on 14-2-22.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "SysConfig.h"

@implementation SysConfig
-(NSString *)getLoginJson:(NSString *)userName withPwd:(NSString *)userPwd
{
    NSString *json=[NSString stringWithFormat:@"{%@,%@}",userName,userPwd];
    return json;
}

-(NSString *)getQueryActiveJson:(NSString*)mid
{
    NSString *json=[NSString stringWithFormat:@"{%@}",mid];
    return json;
}

-(NSString *)getQueryActiveListJson:(NSString *)psgeNum withTitle:(NSString *)title
{
    NSString *json=[NSString stringWithFormat:@"{%@,%@}",psgeNum,title];
    return json;
}

@end
