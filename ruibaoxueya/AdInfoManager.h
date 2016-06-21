//
//  AdInfoManager.h
//  JeffreyPrj
//
//  Created by taiheiot on 12-7-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  AdInfo;
@interface AdInfoManager : NSObject
{
    NSString *path;
}
@property(retain,nonatomic)NSString *path;
-(BOOL)createDb;
-(BOOL)insert:(AdInfo*)info;
-(BOOL)update:(AdInfo*)info;
-(BOOL)deleteAll;
-(BOOL)deleteById:(int)mid;
-(NSMutableArray*)queryInfo;
-(AdInfo*)queryInfo:(int)mid;
-(NSMutableArray*)queryInfoByWhere:(NSString *)strWhere;
-(int)getMaxID;
-(NSMutableArray*)queryHighStatInfoByWhere:(NSString *)strWhere;
-(NSMutableArray*)queryMinStatInfoByWhere:(NSString *)strWhere;
-(NSMutableArray*)queryPulseStatInfoByWhere:(NSString *)strWhere;
-(NSMutableArray*)queryPjStatInfoByWhere:(NSString *)strWhere;
-(NSMutableArray*)queryMcStatInfoByWhere:(NSString *)strWhere;
@end
