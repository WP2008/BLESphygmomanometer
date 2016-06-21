//
//  AlertHelper.m
//  haihuang
//
//  Created by zbf on 14-2-27.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "AlertHelper.h"

@implementation AlertHelper
//添加本地通知的方法
/*
 message:显示的内容
 firedate:闹钟的时间
 alarmKey:闹钟的ID
 */
+(void)addLocalNotificationWithMessage:(NSString *)message
                              FireDate:(NSDate *) fireDate
                              AlarmKey:(NSString *)alarmKey
{
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil) {
        
        notification.fireDate=fireDate;
        
        notification.timeZone=[NSTimeZone defaultTimeZone];
        notification.soundName= UILocalNotificationDefaultSoundName;
        //notification.repeatInterval=NSDayCalendarUnit;
        notification.alertBody=message;
        notification.hasAction = NO;
        notification.alertAction=@"ok";
        notification.userInfo=[[NSDictionary alloc] initWithObjectsAndKeys:alarmKey,@"AlarmKey", nil];
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
    //[notification release];
}

+(void)addLocalDayNotificationWithMessage:(NSString *)message
                              FireDate:(NSDate *) fireDate
                              AlarmKey:(NSString *)alarmKey
{
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil) {
        
        notification.fireDate=fireDate;
        
        notification.timeZone=[NSTimeZone defaultTimeZone];
        notification.soundName= UILocalNotificationDefaultSoundName;
        notification.repeatInterval=NSDayCalendarUnit;
        notification.alertBody=message;
        notification.hasAction = NO;
        notification.alertAction=@"ok";
        notification.userInfo=[[NSDictionary alloc] initWithObjectsAndKeys:alarmKey,@"AlarmKey", nil];
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
    //[notification release];
}

+(void)addLocalWeekNotificationWithMessage:(NSString *)message
                              FireDate:(NSDate *) fireDate
                              AlarmKey:(NSString *)alarmKey
{
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil) {
        
        notification.fireDate=fireDate;
        
        notification.timeZone=[NSTimeZone defaultTimeZone];
        notification.soundName= UILocalNotificationDefaultSoundName;
        //notification.repeatInterval=NSDayCalendarUnit;
        notification.repeatInterval=NSWeekCalendarUnit;
        //notification.repeatCalendar=nscale
        notification.alertBody=message;
        notification.hasAction = NO;
        notification.alertAction=@"ok";
        notification.userInfo=[[NSDictionary alloc] initWithObjectsAndKeys:alarmKey,@"AlarmKey", nil];
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
    //[notification release];
}

+(void)addLocalMonthNotificationWithMessage:(NSString *)message
                                  FireDate:(NSDate *) fireDate
                                  AlarmKey:(NSString *)alarmKey
{
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil) {
        
        notification.fireDate=fireDate;
        
        notification.timeZone=[NSTimeZone defaultTimeZone];
        notification.soundName= UILocalNotificationDefaultSoundName;
        //notification.repeatInterval=NSDayCalendarUnit;
        notification.repeatInterval=NSMonthCalendarUnit;
        //notification.repeatCalendar=nscale
        notification.alertBody=message;
        notification.hasAction = NO;
        notification.alertAction=@"ok";
        notification.userInfo=[[NSDictionary alloc] initWithObjectsAndKeys:alarmKey,@"AlarmKey", nil];
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
    //[notification release];
}

+(void)addLocalYearNotificationWithMessage:(NSString *)message
                                   FireDate:(NSDate *) fireDate
                                   AlarmKey:(NSString *)alarmKey
{
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil) {
        
        notification.fireDate=fireDate;
        
        notification.timeZone=[NSTimeZone defaultTimeZone];
        notification.soundName= UILocalNotificationDefaultSoundName;
        //notification.repeatInterval=NSDayCalendarUnit;
        notification.repeatInterval=NSYearCalendarUnit;
        //notification.repeatCalendar=nscale
        notification.alertBody=message;
        notification.hasAction = NO;
        notification.alertAction=@"ok";
        notification.userInfo=[[NSDictionary alloc] initWithObjectsAndKeys:alarmKey,@"AlarmKey", nil];
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
    //[notification release];
}

/*
 删除本地通知
 */
+(void)deleteLocalNotification:(NSString *) alarmKey
{
    NSArray * allLocalNotification=[[UIApplication sharedApplication] scheduledLocalNotifications];
    
    for (UILocalNotification * localNotification in allLocalNotification) {
        NSString * alarmValue=[localNotification.userInfo objectForKey:@"AlarmKey"];
        if ([alarmKey isEqualToString:alarmValue]) {
            [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
        }
    }
}

@end
