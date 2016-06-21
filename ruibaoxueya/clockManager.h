//
//  clockManager.h
//  ruibaoxueya
//
//  Created by zbf on 14-7-7.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  clockInfo;
@interface clockManager : NSObject
{
    NSString * path;
    
}
@property(nonatomic,retain)NSString *path;
-(NSString*)GetTime;
-(BOOL)createDb;
-(BOOL)insert:(clockInfo*)info;
-(BOOL)update:(clockInfo*)info;
-(BOOL)deleteAll;
-(BOOL)deleteById:(int)mid;
-(NSMutableArray*)queryInfo;
-(clockInfo*)queryInfo:(int)mid;
-(clockInfo*)queryInfoByName:(NSString*)mName;

-(int)getMaxID;
@end
