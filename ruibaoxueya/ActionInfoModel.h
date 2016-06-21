//
//  ActionInfoModel.h
//  haihuang
//
//  Created by zbf on 14-2-23.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActionInfoModel : NSObject
{
    NSString *mId;
    NSString *mTitle;
    NSString *mRemark;
    NSString *mDes;
    NSString *mIconUrl;
    int mClass;
    NSString *mType;
    NSString *mDate;
    NSString *mStartDate;
    NSString *mEndDate;
    NSString *mInfo;
}
@property(retain,nonatomic)NSString *mId;
@property(retain,nonatomic)NSString *mTitle;
@property(retain,nonatomic)NSString *mRemark;
@property(retain,nonatomic)NSString *mInfo;
@property(retain,nonatomic)NSString *mDes;
@property(retain,nonatomic)NSString *mIconUrl;
@property(assign,nonatomic)int mClass;
@property(retain,nonatomic)NSString *mType;
@property(retain,nonatomic)NSString *mDate;
@property(retain,nonatomic)NSString *mStartDate;
@property(retain,nonatomic)NSString *mEndDate;
@end
