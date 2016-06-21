//
//  DateInfo.h
//  ruibaoxueya
//
//  Created by zbf on 14-4-20.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateInfo : NSObject
{
}
@property(assign)int mYear;
@property(assign)int mMonth;
@property(assign)int mDay;
@property(assign)int mHour;
@property(assign)int mMinite;
@property(assign)int mSecond;
@property(assign)int mDate;
@property(assign)int mTime;
-(void)initNow;
-(void)initDate:(int)date withTime:(int)time;
-(void)initDateWithDay:(int)day;
-(void)initDateWithDay:(int)day withDate:(NSDate*)sdate;
-(void)initDateWithDate:(NSDate*)date;
-(NSString *)getDateString;
-(NSString *)getDateTimeString;
+(NSDate *)dateFromDate:(int )date;
+(NSDate *)dateFromString:(NSString *)dateString;
+(NSString *)compareCurrentTime:(NSDate*) compareDate;
@end
