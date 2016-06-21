//
//  QRHosInfo.h
//  JeffreyPrj
//
//  Created by taiheiot on 12-6-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QRHosInfo : NSObject
{
 
}
@property(nonatomic,assign) int mID;
@property(nonatomic,assign) int mUserSex;
@property(nonatomic,retain) NSString *mUserCode;
@property(nonatomic,retain) NSString *mUserName;
@property(nonatomic,retain) NSString * mUserPwd;
@property(nonatomic,assign) int mUserAge;
@property(nonatomic,assign) int mUserKg;
@property(nonatomic,assign) int mUserHigh;
@property(nonatomic,assign) int mSate;
@property(nonatomic,assign) int mDelSate;
@end
