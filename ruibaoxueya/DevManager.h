//
//  DevManager.h
//  ruibaoxueya
//
//  Created by zbf on 14-6-19.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  QRHosInfo;
@interface DevManager : NSObject
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
