//
//  DateInfo.m
//  ruibaoxueya
//
//  Created by zbf on 14-4-20.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "DateInfo.h"

@implementation DateInfo
@synthesize mTime;
@synthesize mDate;
@synthesize mDay;
@synthesize mHour;
@synthesize mMinite;
@synthesize mMonth;
@synthesize mSecond;
@synthesize mYear;
-(id)init
{
    self=[super init];
    if (self) {
        [self initNow];
    }
    return  self;
}

-(void)initNow
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit |NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:[NSDate date]];
    
    mDay = (int)[components day];
    
    mMonth= (int)[components month];
    
    mYear= (int)[components year];
    
    mHour=(int)[components hour];
    
    mMinite=(int)[components minute];
    mSecond=(int)[components second];
    
    mDate=mYear*10000+mMonth*100+mDay;
    mTime=mHour*10000+mMinite*100+mSecond;
}

-(void)initDateWithDate:(NSDate*)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit |NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:date];
    
    mDay = (int)[components day];
    
    mMonth= (int)[components month];
    
    mYear= (int)[components year];
    
    mHour=(int)[components hour];
    
    mMinite=(int)[components minute];
    mSecond=(int)[components second];
    
    mDate=mYear*10000+mMonth*100+mDay;
    mTime=mHour*10000+mMinite*100+mSecond;
}

-(void)initDate:(int)date withTime:(int)time
{
    mDate=date;
    mTime=time;
    mYear=date/10000;
    mMonth=date%10000/100;
    mDay=date%10000%100;
    
    mHour=time/10000;
    mMinite=time%10000/100;
    mSecond=time%10000%100;
    
}

-(void)initDateWithDay:(int)day
{
    day=day*24*60*60;
    // day=0-day;
    NSDate *date=[[NSDate alloc] initWithTimeInterval:day sinceDate:[NSDate date]];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit |NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:date];
    
    mDay = (int)[components day];
    
    mMonth= (int)[components month];
    
    mYear= (int)[components year];
    
    mHour=(int)[components hour];
    
    mMinite=(int)[components minute];
     mSecond=(int)[components second];
    mDate=mYear*10000+mMonth*100+mDay;
    mTime=mHour*10000+mMinite*100+mSecond;
    
}

-(void)initDateWithDay:(int)day withDate:(NSDate*)sdate
{
    day=day*24*60*60;
    // day=0-day;
    NSDate *date=[[NSDate alloc] initWithTimeInterval:day sinceDate:sdate];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit |NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:date];
    
    mDay = (int)[components day];
    
    mMonth= (int)[components month];
    
    mYear= (int)[components year];
    
    mHour=(int)[components hour];
    
    mMinite=(int)[components minute];
     mSecond=(int)[components second];
    
    mDate=mYear*10000+mMonth*100+mDay;
    mTime=mHour*10000+mMinite*100+mSecond;
    
    
    
}

-(NSString *)getDateString
{
    NSMutableString *sb=[[NSMutableString alloc]init];
    [sb appendFormat:@"%d",mYear];
    if (mMonth>9) {
        [sb appendFormat:@"-%d",mMonth];
    }else
    {
        [sb appendFormat:@"-0%d",mMonth];
    }
    
    if (mDay>9) {
        [sb appendFormat:@"-%d",mDay];
    }
    else
    {
        [sb appendFormat:@"-0%d",mDay];
    }
    
    return sb;
}


-(NSString *)getDateTimeString
{
    NSMutableString *sb=[[NSMutableString alloc]init];
    [sb appendFormat:@"%d",mYear];
    if (mMonth>9) {
        [sb appendFormat:@"-%d",mMonth];
    }else
    {
        [sb appendFormat:@"-0%d",mMonth];
    }
    
    if (mDay>9) {
        [sb appendFormat:@"-%d",mDay];
    }
    else
    {
        [sb appendFormat:@"-0%d",mDay];
    }
    
    if (mHour>9) {
        [sb appendFormat:@" %d",mHour];
    }
    else
    {
        [sb appendFormat:@" 0%d",mHour];
    }
    
    if (mMinite>9) {
        [sb appendFormat:@":%d",mMinite];
    }
    else
    {
        [sb appendFormat:@":0%d",mMinite];
    }
    if (mSecond>9) {
        [sb appendFormat:@":%d",mSecond];
    }
    else
    {
        [sb appendFormat:@":0%d",mSecond];
    }
    
    return sb;
}

+(NSDate *)dateFromDate:(int )date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    int y=date/10000;
    int m=date%10000/100;
    int day=date%10000%100;
    
    NSString *dateString=nil;
    if (m>9&&day>9) {
        dateString=[NSString stringWithFormat:@"%d-%d-%d 00:00:00",y,m,day];
    }else if(m>9)
    {
        dateString=[NSString stringWithFormat:@"%d-%d-0%d 00:00:00",y,m,day];
    }else if(day>9)
    {
        dateString=[NSString stringWithFormat:@"%d-0%d-%d 00:00:00",y,m,day];
    }
    else
    {
        dateString=[NSString stringWithFormat:@"%d-0%d-0%d 00:00:00",y,m,day];
    }
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}


+(NSDate *)dateFromString:(NSString *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

+(NSString *) compareCurrentTime:(NSDate*) compareDate
{
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}

@end
