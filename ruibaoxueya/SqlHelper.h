//
//  SqlHelper.h
//  JeffreyPrj
//
//  Created by taiheiot on 12-6-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  作者：曾邦福 功能：对本地扫描的qr码做存储管理

#import <Foundation/Foundation.h>
@class  QRHosInfo;
@interface SqlHelper : NSObject
{
    NSString * path;
  
}
@property(nonatomic,retain)NSString *path;
-(NSString*)GetTime;
-(BOOL)createDb;
-(BOOL)insert:(QRHosInfo*)info;
-(BOOL)update:(QRHosInfo*)info;
-(BOOL)deleteAll;
-(BOOL)deleteById:(int)mid;
-(NSMutableArray*)queryInfo;
-(QRHosInfo*)queryInfo:(int)mid;
-(QRHosInfo*)queryInfoByName:(NSString*)mName;

-(int)getMaxID;
@end
