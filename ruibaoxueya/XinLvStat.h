//
//  XinLvStat.h
//  ruibaoxueya
//
//  Created by zbf on 14-4-21.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XinLvStat : NSObject{
    
    NSMutableArray *mDays;
    NSMutableArray *mValues;
    int mhourCount;
    int ncount;
    int mwidth;
    int mheight;
    int mw;
    int mh;
    int nheight;
    int nwidth;
    int mmin;
    int mmax;
    int syear;
    int smonth;
    int smday;
    int  mstime;
    
}
@property(nonatomic,retain)NSMutableArray *mData;
@property(nonatomic,assign)int mType;
@property(nonatomic,assign)int mStartDate;
@property(nonatomic,assign)int mEndDate;
@property(nonatomic,assign)int mMin;
-(void)initType:(int )type;
-(void)initSDate:(int)sDate   withstime:(int) stime;
-(UIImage *)getImg;
@end
