//
//  StatInfo.h
//  ruibaoxueya
//
//  Created by zbf on 14-4-22.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatInfo : NSObject
{}
@property(assign,nonatomic)int mType;
@property(assign,nonatomic)int mCount;

@property(assign,nonatomic)int mType1Count;
@property(assign,nonatomic)int mType2Count;
@property(assign,nonatomic)int mType3Count;
@property(assign,nonatomic)int mType4Count;
@property(assign,nonatomic)int mType5Count;

@property(assign,nonatomic)int mType1percent;
@property(assign,nonatomic)int mType2percent;
@property(assign,nonatomic)int mType3percent;
@property(assign,nonatomic)int mType4percent;
@property(assign,nonatomic)int mType5percent;

@end
