//
//  AlertHelper.h
//  haihuang
//
//  Created by zbf on 14-2-27.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertHelper : NSObject
{}

+(void)addLocalNotificationWithMessage:(NSString *)message
                              FireDate:(NSDate *) fireDate
                              AlarmKey:(NSString *)alarmKey;

+(void)deleteLocalNotification:(NSString *) alarmKey;

+(void)addLocalDayNotificationWithMessage:(NSString *)message
                                 FireDate:(NSDate *) fireDate
                                 AlarmKey:(NSString *)alarmKey;

+(void)addLocalWeekNotificationWithMessage:(NSString *)message
                                  FireDate:(NSDate *) fireDate
                                  AlarmKey:(NSString *)alarmKey;


+(void)addLocalMonthNotificationWithMessage:(NSString *)message
                                   FireDate:(NSDate *) fireDate
                                   AlarmKey:(NSString *)alarmKey;


+(void)addLocalYearNotificationWithMessage:(NSString *)message
                                  FireDate:(NSDate *) fireDate
                                  AlarmKey:(NSString *)alarmKey;
@end
