//
//  clockInfo.h
//  ruibaoxueya
//
//  Created by zbf on 14-7-7.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface clockInfo : NSObject
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
