//
//  AdInfo.h
//  JeffreyPrj
//
//  Created by taiheiot on 12-7-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdInfo : NSObject
{
    
}
@property(assign,nonatomic)int mId;
@property(assign,nonatomic)int mDate;
@property(assign,nonatomic)int mTime;
@property(assign,nonatomic)int mState;

@property(assign,nonatomic)int mUserID;
@property(assign,nonatomic)int mType;
@property(assign,nonatomic)int mHighSpO2;
@property(assign,nonatomic)int mMinSpO2;
@property(assign,nonatomic)int mPulse;
@property(assign,nonatomic)int mCreateUserID;

@property(assign,nonatomic)int mYear;
@property(assign,nonatomic)int mMonth;
@property(assign,nonatomic)int mDay;
@property(assign,nonatomic)int mWk;
@property(assign,nonatomic)int mHour;
@property(assign,nonatomic)int mMinite;


@property(assign,nonatomic)int mSecond;
@property(assign,nonatomic)int mTimeCount;
@property(assign,nonatomic)int mMCPulse;
@property(assign,nonatomic)int mPJSpO2;
@property(assign,nonatomic)int mMCPulseType;
@property(assign,nonatomic)int mDelete;

@property(assign,nonatomic)int mHighSpO2Type;
@property(assign,nonatomic)int mMinSpO2Type;
@property(assign,nonatomic)int mPulseType;
@property(assign,nonatomic)int mPJSpO2Type;
@property(assign,nonatomic)int MTiWei;
@property(assign,nonatomic)int MTestType;


@property(retain,nonatomic)NSString *mRemark;
@property(retain,nonatomic)NSString *mInfo;
@property(retain,nonatomic)NSString *mDes;
@property(retain,nonatomic)NSString *mTiWeiName;
@property(retain,nonatomic)NSString *mTestName;

@property(assign,nonatomic)int mDayIndex;
@end
