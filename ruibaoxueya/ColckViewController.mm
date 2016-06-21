//
//  ColckViewController.m
//  haihuaguser
//
//  Created by zbf on 14-3-14.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "ColckViewController.h"
#import "AlertHelper.h"
#import "clockManager.h"
#import "clockInfo.h"
#import "DateInfo.h"
@interface ColckViewController ()

@end

@implementation ColckViewController
@synthesize btn1;
@synthesize btn2;
@synthesize btn3;
@synthesize btn4;
@synthesize btn5;
@synthesize btn6;
@synthesize btn7;
@synthesize btnTime;
@synthesize mType;
@synthesize mSwitch;
@synthesize mBtnOk;
@synthesize mTitle;
@synthesize mBg;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)initSate:(int)mid
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *key=[NSString stringWithFormat:@"clock%d_dday1",mid];
    NSString *dday=[prefs objectForKey:key];
    if (dday&&[self strIsEqual:dday equal:@"yes"]) {
        day1=YES;
    }
    else
    {
        day1=NO;
        [prefs setObject:@"no" forKey:key];
    }
    key=[NSString stringWithFormat:@"clock%d_dday2",mid];
    dday=[prefs objectForKey:key];
    if (dday&&[self strIsEqual:dday equal:@"yes"]) {
        day2=YES;
    }else
    {
        day2=NO;
        [prefs setObject:@"no" forKey:key];
    }
    key=[NSString stringWithFormat:@"clock%d_dday3",mid];
    dday=[prefs objectForKey:key];
    if (dday&&[self strIsEqual:dday equal:@"yes"]) {
        day3=YES;
    }else
    {
        day3=NO;
        [prefs setObject:@"no" forKey:key];
    }
    
    key=[NSString stringWithFormat:@"clock%d_dday4",mid];
    dday=[prefs objectForKey:key];
    if (dday&&[self strIsEqual:dday equal:@"yes"]) {
        day4=YES;
    }else
    {
        day4=NO;
        [prefs setObject:@"no" forKey:key];
    }
    
    key=[NSString stringWithFormat:@"clock%d_dday5",mid];
    dday=[prefs objectForKey:key];
    if (dday&&[self strIsEqual:dday equal:@"yes"]) {
        day5=YES;
    }else
    {
        day5=NO;
        [prefs setObject:@"no" forKey:key];
    }
    
    key=[NSString stringWithFormat:@"clock%d_dday6",mid];
    dday=[prefs objectForKey:key];
    if (dday&&[self strIsEqual:dday equal:@"yes"]) {
        day6=YES;
    }else
    {
        day6=NO;
        [prefs setObject:@"no" forKey:key];
    }
    
     key=[NSString stringWithFormat:@"clock%d_dday7",mid];
    dday=[prefs objectForKey:key];
    if (dday&&[self strIsEqual:dday equal:@"yes"]) {
        day7=YES;
    }else
    {
        day7=NO;
        [prefs setObject:@"no" forKey:key];
    }
     key=[NSString stringWithFormat:@"clock%d_hour",mid];
    dday=[prefs objectForKey:key];
    if (dday&&dday.length>0) {
        mmhour=[dday intValue];
    }
    else
    {
        dday=[NSString stringWithFormat:@"%d",mmhour];
        [prefs setObject:dday forKey:key];
    }
    
    key=[NSString stringWithFormat:@"clock%d_minite",mid];
    dday=[prefs objectForKey:key];
    if (dday&&dday.length>0) {
        mmminite=[dday intValue];
    }
    else
    {
        dday=[NSString stringWithFormat:@"%d",mmminite];
        [prefs setObject:dday forKey:key];
    }
    
    key=[NSString stringWithFormat:@"clock%d_state",mid];
    dday=[prefs objectForKey:key];
    if (dday&&[self strIsEqual:dday equal:@"yes"]) {
        mSwitch.selectedSegmentIndex=1;
    }else
    {
        mSwitch.selectedSegmentIndex=0;
        [prefs setObject:@"no" forKey:key];
    }
   
    
    NSString *date=nil;
    if (mmhour>9&&mmminite>9) {
        date=[NSString stringWithFormat:@"%d:%d",mmhour,mmminite];
    }
    else if(mmhour>9)
    {
        date=[NSString stringWithFormat:@"%d:0%d",mmhour,mmminite];
    }else if(mmminite>9)
    {
        date=[NSString stringWithFormat:@"0%d:%d",mmhour,mmminite];
    }else
    {
        date=[NSString stringWithFormat:@"0%d:0%d",mmhour,mmminite];
    }
    
     key=[NSString stringWithFormat:@"clock%d_clockStartTime",mType];
    [btnTime setTitle:date forState:UIControlStateNormal];
     [prefs setObject:date forKey:key];
    [prefs synchronize];
    if (day1) {
        [btn1 setBackgroundImage:[UIImage imageNamed:@"clock_checked"] forState:UIControlStateNormal];
    }else
    {
        [btn1 setBackgroundImage:[UIImage imageNamed:@"clock_checkno"] forState:UIControlStateNormal];
    }
    if (day2) {
        [btn2 setBackgroundImage:[UIImage imageNamed:@"clock_checked"] forState:UIControlStateNormal];
    }else
    {
        [btn2 setBackgroundImage:[UIImage imageNamed:@"clock_checkno"] forState:UIControlStateNormal];
    }
    if (day3) {
        [btn3 setBackgroundImage:[UIImage imageNamed:@"clock_checked"] forState:UIControlStateNormal];
    }else
    {
        [btn3 setBackgroundImage:[UIImage imageNamed:@"clock_checkno"] forState:UIControlStateNormal];
    }
    if (day4) {
        [btn4 setBackgroundImage:[UIImage imageNamed:@"clock_checked"] forState:UIControlStateNormal];
    }else
    {
        [btn4 setBackgroundImage:[UIImage imageNamed:@"clock_checkno"] forState:UIControlStateNormal];
    }
    if (day5) {
        [btn5 setBackgroundImage:[UIImage imageNamed:@"clock_checked"] forState:UIControlStateNormal];
    }else
    {
        [btn5 setBackgroundImage:[UIImage imageNamed:@"clock_checkno"] forState:UIControlStateNormal];
    }
    if (day6) {
        [btn6 setBackgroundImage:[UIImage imageNamed:@"clock_checked"] forState:UIControlStateNormal];
    }else
    {
        [btn6 setBackgroundImage:[UIImage imageNamed:@"clock_checkno"] forState:UIControlStateNormal];
    }
    if (day7) {
        [btn7 setBackgroundImage:[UIImage imageNamed:@"clock_checked"] forState:UIControlStateNormal];
    }else
    {
        [btn7 setBackgroundImage:[UIImage imageNamed:@"clock_checkno"] forState:UIControlStateNormal];
    }
   
    key=[NSString stringWithFormat:@"clock%d_remark",mid];
    dday=[prefs objectForKey:key];
    if (dday&&dday.length>0) {
        remarkIndex=[dday intValue];
    }
    else
    {
        dday=[NSString stringWithFormat:@"%d",remarkIndex];
        [prefs setObject:dday forKey:key];
    }
    if (remarkIndex==0) {
        mSwitch_check.selectedSegmentIndex=1;
        mSwitch_health.selectedSegmentIndex=0;
        mSwitch_sleep.selectedSegmentIndex=0;
    }else if (remarkIndex==1) {
        mSwitch_check.selectedSegmentIndex=0;
        mSwitch_health.selectedSegmentIndex=0;
        mSwitch_sleep.selectedSegmentIndex=1;
    }
    else  if (remarkIndex==2)    {
        mSwitch_check.selectedSegmentIndex=0;
        mSwitch_health.selectedSegmentIndex=1;
        mSwitch_sleep.selectedSegmentIndex=0;
    }else
    {
        mSwitch_check.selectedSegmentIndex=0;
        mSwitch_health.selectedSegmentIndex=0;
        mSwitch_sleep.selectedSegmentIndex=0;
    }

}

-(IBAction)btn_check:(id)sender
{
    if (mSwitch_check.selectedSegmentIndex==1) {
        remarkIndex=0;
        mSwitch_health.selectedSegmentIndex=0;
        mSwitch_sleep.selectedSegmentIndex=0;
    }
}

-(IBAction)btn_sleep:(id)sender
{
    if (mSwitch_sleep.selectedSegmentIndex==1) {
        remarkIndex=1;
        mSwitch_health.selectedSegmentIndex=0;
        mSwitch_check.selectedSegmentIndex=0;
    }
}

-(IBAction)btn_health:(id)sender
{
    if (mSwitch_health.selectedSegmentIndex==1) {
        remarkIndex=2;
        mSwitch_sleep.selectedSegmentIndex=0;
        mSwitch_check.selectedSegmentIndex=0;
    }
}

-(IBAction)btn1:(id)sender
{
    day1=!day1;
    if (day1) {
        [btn1 setBackgroundImage:[UIImage imageNamed:@"clock_checked"] forState:UIControlStateNormal];
    }else
    {
        [btn1 setBackgroundImage:[UIImage imageNamed:@"clock_checkno"] forState:UIControlStateNormal];
    }
}

-(IBAction)btn2:(id)sender
{
    day2=!day2;
    if (day2) {
        [btn2 setBackgroundImage:[UIImage imageNamed:@"clock_checked"] forState:UIControlStateNormal];
    }else
    {
        [btn2 setBackgroundImage:[UIImage imageNamed:@"clock_checkno"] forState:UIControlStateNormal];
    }
}

-(IBAction)btn3:(id)sender
{
    day3=!day3;
    if (day3) {
        [btn3 setBackgroundImage:[UIImage imageNamed:@"clock_checked"] forState:UIControlStateNormal];
    }else
    {
        [btn3 setBackgroundImage:[UIImage imageNamed:@"clock_checkno"] forState:UIControlStateNormal];
    }
}

-(IBAction)btn4:(id)sender
{
    day4=!day4;
    if (day4) {
        [btn4 setBackgroundImage:[UIImage imageNamed:@"clock_checked"] forState:UIControlStateNormal];
    }else
    {
        [btn4 setBackgroundImage:[UIImage imageNamed:@"clock_checkno"] forState:UIControlStateNormal];
    }
    
}

-(IBAction)btn5:(id)sender
{
    day5=!day5;
    if (day5) {
        [btn5 setBackgroundImage:[UIImage imageNamed:@"clock_checked"] forState:UIControlStateNormal];
    }else
    {
        [btn5 setBackgroundImage:[UIImage imageNamed:@"clock_checkno"] forState:UIControlStateNormal];
    }
}

-(IBAction)btn6:(id)sender
{
    day6=!day6;
    if (day6) {
        [btn6 setBackgroundImage:[UIImage imageNamed:@"clock_checked"] forState:UIControlStateNormal];
    }else
    {
        [btn6 setBackgroundImage:[UIImage imageNamed:@"clock_checkno"] forState:UIControlStateNormal];
    }
}

-(IBAction)btn7:(id)sender
{
    day7=!day7;
    if (day7) {
        [btn7 setBackgroundImage:[UIImage imageNamed:@"clock_checked"] forState:UIControlStateNormal];
    }else
    {
        [btn7 setBackgroundImage:[UIImage imageNamed:@"clock_checkno"] forState:UIControlStateNormal];
    }
}

-(IBAction)btnTime:(id)sender
{
    TimeSelectViewController *tview=[[TimeSelectViewController alloc]initWithNibName:@"TimeSelectViewController" bundle:Nil];
    tview.delegate=self;
    tview.mHour=mmhour;
    tview.mMite=mmminite;
    [self openWindow:tview];
}

-(void)selectHour:(int)hour selectMinite:(int)minite
{
    mmhour=hour;
    mmminite=minite;
    NSString *date=Nil;
    if (hour>9&&minite>9) {
        date=[NSString stringWithFormat:@"%d:%d",hour,minite];
    }
    else if(hour>9)
    {
        date=[NSString stringWithFormat:@"%d:0%d",hour,minite];
    }else if(minite>9)
    {
        date=[NSString stringWithFormat:@"0%d:%d",hour,minite];
    }else
    {
        date=[NSString stringWithFormat:@"0%d:0%d",hour,minite];
    }
        
    
    [btnTime setTitle:date forState:UIControlStateNormal];
    NSString* key=[NSString stringWithFormat:@"clock%d_clockStartTime",mType];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
   
    [prefs setObject:date forKey:key];
    [prefs synchronize];
}



-(void)refreshBtn
{
    if (day1) {
        [btn1 setBackgroundImage:[UIImage imageNamed:@"clock_checked"] forState:UIControlStateNormal];
    }else
    {
        [btn1 setBackgroundImage:[UIImage imageNamed:@"clock_checkno"] forState:UIControlStateNormal];
    }
    if (day2) {
        [btn2 setBackgroundImage:[UIImage imageNamed:@"clock_checked"] forState:UIControlStateNormal];
    }else
    {
        [btn2 setBackgroundImage:[UIImage imageNamed:@"clock_checkno"] forState:UIControlStateNormal];
    }
    if (day3) {
        [btn3 setBackgroundImage:[UIImage imageNamed:@"clock_checked"] forState:UIControlStateNormal];
    }else
    {
        [btn3 setBackgroundImage:[UIImage imageNamed:@"clock_checkno"] forState:UIControlStateNormal];
    }
    if (day4) {
        [btn4 setBackgroundImage:[UIImage imageNamed:@"clock_checked"] forState:UIControlStateNormal];
    }else
    {
        [btn4 setBackgroundImage:[UIImage imageNamed:@"clock_checkno"] forState:UIControlStateNormal];
    }
    if (day5) {
        [btn5 setBackgroundImage:[UIImage imageNamed:@"clock_checked"] forState:UIControlStateNormal];
    }else
    {
        [btn5 setBackgroundImage:[UIImage imageNamed:@"clock_checkno"] forState:UIControlStateNormal];
    }
    if (day6) {
        [btn6 setBackgroundImage:[UIImage imageNamed:@"clock_checked"] forState:UIControlStateNormal];
    }else
    {
        [btn6 setBackgroundImage:[UIImage imageNamed:@"clock_checkno"] forState:UIControlStateNormal];
    }
    if (day7) {
        [btn7 setBackgroundImage:[UIImage imageNamed:@"clock_checked"] forState:UIControlStateNormal];
    }else
    {
        [btn7 setBackgroundImage:[UIImage imageNamed:@"clock_checkno"] forState:UIControlStateNormal];
    }
}

-(void)saveSate:(int)mid
{
    mWeekString=[[NSMutableString alloc]init];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *key=[NSString stringWithFormat:@"clock%d_dday1",mid];
    if (day1) {
        [prefs setObject:@"yes" forKey:key];
          if ([self isEnglish]) {
               [mWeekString  appendFormat:@"Mon"];
          }
        else
        {
            [mWeekString  appendFormat:@"周一"];
        }
    }
    else
    {
       
        [prefs setObject:@"no" forKey:key];
    }
    key=[NSString stringWithFormat:@"clock%d_dday2",mid];
    if (day2) {
        [prefs setObject:@"yes" forKey:key];
         if ([self isEnglish]) {
             if (mWeekString.length<2) {
                 [mWeekString  appendFormat:@"Tue"];
             }
             else
             {
                 [mWeekString  appendFormat:@",Tue"];
             }
         }
        else
        {
            if (mWeekString.length<2) {
                [mWeekString  appendFormat:@"周二"];
            }
            else
            {
                [mWeekString  appendFormat:@",周二"];
            }
        }
    }
    else
    {
        
        [prefs setObject:@"no" forKey:key];
    }
    key=[NSString stringWithFormat:@"clock%d_dday3",mid];
    if (day3) {
        [prefs setObject:@"yes" forKey:key];
         if ([self isEnglish]) {
             if (mWeekString.length<2) {
                 [mWeekString  appendFormat:@"Wed"];
             }
             else
             {
                 [mWeekString  appendFormat:@",Wed"];
             }         }
        else
        {
            
            if (mWeekString.length<2) {
                [mWeekString  appendFormat:@"周三"];
            }
            else
            {
                [mWeekString  appendFormat:@",周三"];
            }
        }
    }
    else
    {
        
        [prefs setObject:@"no" forKey:key];
    }
    key=[NSString stringWithFormat:@"clock%d_dday4",mid];
    if (day4) {
        [prefs setObject:@"yes" forKey:key];
        if ([self isEnglish]) {
            if (mWeekString.length<2) {
                [mWeekString  appendFormat:@"Thu"];
            }
            else
            {
                [mWeekString  appendFormat:@",Thu"];
            }
        }
        else
        {
            if (mWeekString.length<2) {
                [mWeekString  appendFormat:@"周四"];
            }
            else
            {
                [mWeekString  appendFormat:@",周四"];
            }
        }
    }
    else
    {
        
        [prefs setObject:@"no" forKey:key];
    }
    key=[NSString stringWithFormat:@"clock%d_dday5",mid];
    if (day5) {
        [prefs setObject:@"yes" forKey:key];
        if ([self isEnglish]) {

            if (mWeekString.length<2) {
                [mWeekString  appendFormat:@"Fri"];
            }
            else
            {
                [mWeekString  appendFormat:@",Fri"];
            }
        }
        else
        {
            if (mWeekString.length<2) {
                [mWeekString  appendFormat:@"周五"];
            }
            else
            {
                [mWeekString  appendFormat:@",周五"];
            }
        }

    }
    else
    {
        
        [prefs setObject:@"no" forKey:key];
    }
    key=[NSString stringWithFormat:@"clock%d_dday6",mid];
    if (day6) {
        [prefs setObject:@"yes" forKey:key];
         if ([self isEnglish]) {
             if (mWeekString.length<2) {
                 [mWeekString  appendFormat:@"Sat"];
             }
             else
             {
                 [mWeekString  appendFormat:@",Sat"];
             }
         }
        else
        {
            if (mWeekString.length<2) {
                [mWeekString  appendFormat:@"周六"];
            }
            else
            {
                [mWeekString  appendFormat:@",周六"];
            }
        }

    }
    else
    {
        
        [prefs setObject:@"no" forKey:key];
    }
    key=[NSString stringWithFormat:@"clock%d_dday7",mid];
    if (day7) {
        [prefs setObject:@"yes" forKey:key];
        if ([self isEnglish]) {
            if (mWeekString.length<2) {
                [mWeekString  appendFormat:@"Sun"];
            }
            else
            {
                [mWeekString  appendFormat:@",Sun"];
            }
        }
        else
        {
            
            if (mWeekString.length<2) {
                [mWeekString  appendFormat:@"周日"];
            }
            else
            {
                [mWeekString  appendFormat:@",周日"];
            }
        }
    }
    else
    {
        
        [prefs setObject:@"no" forKey:key];
    }
    key=[NSString stringWithFormat:@"clock%d_state",mid];
    if (mSwitch.selectedSegmentIndex==1) {
         [prefs setObject:@"yes" forKey:key];
    }else
    {
        [prefs setObject:@"no" forKey:key];
    }
    key=[NSString stringWithFormat:@"clock%d_hour",mid];
    [prefs setObject:[NSString stringWithFormat:@"%d",mmhour] forKey:key];
     key=[NSString stringWithFormat:@"clock%d_minite",mid];
    [prefs setObject:[NSString stringWithFormat:@"%d",mmminite] forKey:key];
    
    key=[NSString stringWithFormat:@"clock%d_remark",mid];
    [prefs setObject:[NSString stringWithFormat:@"%d",remarkIndex] forKey:key];
    
    [prefs synchronize];
}

-(void)deleteClock:(int )day
{
    [AlertHelper deleteLocalNotification:[NSString stringWithFormat:@"clock_%d_alert_day_%d",mType,day]];
}

-(void)openClock:(int)day withDate:(NSDate*)mdate
{
    [self deleteClock:day];
    
    if ([self isEnglish]) {
        
        if(remarkIndex==0)
        {
            [AlertHelper addLocalWeekNotificationWithMessage: @"TBP measuren" FireDate:mdate AlarmKey:[NSString stringWithFormat:@"clock_%d_alert_day_%d",mType,day]];
        }
        else if (remarkIndex==1)
        {
             [AlertHelper addLocalWeekNotificationWithMessage: @"Going to bed" FireDate:mdate AlarmKey:[NSString stringWithFormat:@"clock_%d_alert_day_%d",mType,day]];
        }
        else if (remarkIndex==2)
        {
             [AlertHelper addLocalWeekNotificationWithMessage: @"Exercise" FireDate:mdate AlarmKey:[NSString stringWithFormat:@"clock_%d_alert_day_%d",mType,day]];
        }
        else
        {
             [AlertHelper addLocalWeekNotificationWithMessage: @"Time Alarm" FireDate:mdate AlarmKey:[NSString stringWithFormat:@"clock_%d_alert_day_%d",mType,day]];
        }
    }
    else
    {
        
        
        if(remarkIndex==0)
        {
            [AlertHelper addLocalWeekNotificationWithMessage: @"测量血压" FireDate:mdate AlarmKey:[NSString stringWithFormat:@"clock_%d_alert_day_%d",mType,day]];
        }
        else if (remarkIndex==1)
        {
            [AlertHelper addLocalWeekNotificationWithMessage: @"睡觉" FireDate:mdate AlarmKey:[NSString stringWithFormat:@"clock_%d_alert_day_%d",mType,day]];
        }
        else if (remarkIndex==2)
        {
            [AlertHelper addLocalWeekNotificationWithMessage: @"健身" FireDate:mdate AlarmKey:[NSString stringWithFormat:@"clock_%d_alert_day_%d",mType,day]];
        }
        else
        {
            [AlertHelper addLocalWeekNotificationWithMessage: @"测量提醒" FireDate:mdate AlarmKey:[NSString stringWithFormat:@"clock_%d_alert_day_%d",mType,day]];
        }

    }
    
    
}

-(void)setClockEx
{
    
    NSDate *mdate=[NSDate date];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit |NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:[NSDate date]];
    
    /*NSInteger nowday = [components day];
     
     NSInteger nowmonth= [components month];
     
     NSInteger nowyear= [components year];*/
    
    int nowhour=(int)[components hour];
    
    int nowMinite=(int)[components minute];
    nowhour=nowhour*60+nowMinite;
    nowMinite=mmhour*60+mmminite;
    int ddays=nowMinite-nowhour;
    if (ddays<0) {
        ddays=1440+ddays;
        
    }
    ddays=ddays*60;
    
    mdate=[[NSDate alloc] initWithTimeInterval:ddays sinceDate:mdate];
    if ([self isEnglish]) {
        [AlertHelper addLocalNotificationWithMessage: @"Time Alarm" FireDate:mdate AlarmKey:[NSString stringWithFormat:@"clock_%d_alert_days",mType]];
    }
    else
    {
        [AlertHelper addLocalNotificationWithMessage: @"测量提醒" FireDate:mdate AlarmKey:[NSString stringWithFormat:@"clock_%d_alert_days",mType]];
    }

}

-(void)setClock
{
    [AlertHelper deleteLocalNotification:[NSString stringWithFormat:@"clock_%d_alert_days",mType]];
    NSDate *mdate=[NSDate date];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit |NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:[NSDate date]];
    
    /*NSInteger nowday = [components day];
    
    NSInteger nowmonth= [components month];
    
    NSInteger nowyear= [components year];*/
    
    int nowhour=(int)[components hour];
    
    int nowMinite=(int)[components minute];
    
    int nowWek=(int)[components weekday];
    nowWek=nowWek-2;
    if (nowWek<0) {
        nowWek+=7;
    }
    nowhour=nowhour*60+nowMinite;
    nowMinite=mmhour*60+mmminite;
   
    
    
    
    if (day1) {
        int ddays=0-nowWek;
        ddays=ddays*1440+nowMinite-nowhour;
        if (ddays<0) {
            ddays=ddays+7*1440;
        }
        ddays=ddays*60;
        
        mdate=[[NSDate alloc] initWithTimeInterval:ddays sinceDate:mdate];
        [self openClock:1 withDate:mdate];
    }else
    {
        [self deleteClock:1];
    }
    mdate=[NSDate date];
    if (day2) {
        int ddays=1-nowWek;
        ddays=ddays*1440+nowMinite-nowhour;
        if (ddays<0) {
            ddays=ddays+7*1440;
        }
        ddays=ddays*60;
        mdate=[[NSDate alloc] initWithTimeInterval:ddays sinceDate:mdate];
        [self openClock:2 withDate:mdate];
    }else
    {
        [self deleteClock:2];
    }
    mdate=[NSDate date];
    if (day3) {
        int ddays=2-nowWek;
        ddays=ddays*1440+nowMinite-nowhour;
        if (ddays<0) {
            ddays=ddays+7*1440;
        }
        ddays=ddays*60;
        mdate=[[NSDate alloc] initWithTimeInterval:ddays sinceDate:mdate];
        [self openClock:3 withDate:mdate];
    }else
    {
        [self deleteClock:3];
    }
    mdate=[NSDate date];
    if (day4) {
        int ddays=3-nowWek;
        ddays=ddays*1440+nowMinite-nowhour;
        if (ddays<0) {
            ddays=ddays+7*1440;
        }
        ddays=ddays*60;
        mdate=[[NSDate alloc] initWithTimeInterval:ddays sinceDate:mdate];
        [self openClock:4 withDate:mdate];
    }else
    {
        [self deleteClock:4];
    }
    mdate=[NSDate date];
    if (day5) {
        int ddays=4-nowWek;
        ddays=ddays*1440+nowMinite-nowhour;
        if (ddays<0) {
            ddays=ddays+7*1440;
        }
        ddays=ddays*60;
        mdate=[[NSDate alloc] initWithTimeInterval:ddays sinceDate:mdate];
        [self openClock:5 withDate:mdate];
    }else
    {
        [self deleteClock:5];
    }
    mdate=[NSDate date];
    if (day6) {
        int ddays=5-nowWek;
        ddays=ddays*1440+nowMinite-nowhour;
        if (ddays<0) {
            ddays=ddays+7*1440;
        }
        ddays=ddays*60;
        mdate=[[NSDate alloc] initWithTimeInterval:ddays sinceDate:mdate];
        [self openClock:6 withDate:mdate];
    }else
    {
        [self deleteClock:6];
    }
    mdate=[NSDate date];
    if (day7) {
        int ddays=6-nowWek;
        ddays=ddays*1440+nowMinite-nowhour;
        if (ddays<0) {
            ddays=ddays+7*1440;
        }
        ddays=ddays*60;
        mdate=[[NSDate alloc] initWithTimeInterval:ddays sinceDate:mdate];
        [self openClock:7 withDate:mdate];
    }else
    {
        [self deleteClock:7];
    }
}

-(IBAction)btnOk:(id)sender
{
    if (mSwitch_check.selectedSegmentIndex!=1&&mSwitch_health.selectedSegmentIndex!=1&&mSwitch_sleep.selectedSegmentIndex!=1) {
        remarkIndex=-1;
    }
    [self saveSate:mType];
    
    if (mSwitch.selectedSegmentIndex==1) {
        [self setClock];
    }
    else
    {
        [self deleteClock:7];
        [self deleteClock:6];
        [self deleteClock:5];
        [self deleteClock:4];
        [self deleteClock:3];
        [self deleteClock:2];
        [self deleteClock:1];
        
    }
    clockManager *sql=[[clockManager alloc]init];
    sql.path=[self dataFilePath];
    clockInfo *itemInfo=[[clockInfo alloc]init];
    itemInfo.mID=mType;
    if (mSwitch.selectedSegmentIndex==1)
    {
        itemInfo.mUserSex=1;
    }
    if (day1||day2||day3||day4||day5||day6||day7) {
        itemInfo.mUserPwd=[NSString stringWithFormat:@"%@",mWeekString];
    }
    else
    {
         if ([self isEnglish]) {
              itemInfo.mUserPwd=@"One Time";
         }
        else
        {
            itemInfo.mUserPwd=@"不重复";
        }
        
    }
    
    NSString * key=[NSString stringWithFormat:@"clock%d_clockStartTime",mType];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    itemInfo.mUserName=[prefs objectForKey:key];
    [sql deleteById:mType];
    [sql insert:itemInfo];
    
    [self closeMe];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!misload) {
        misload=YES;
        mmhour=8;
        [self initSate:mType];
        if ([self isEnglish]) {
             mTitle.text=@"Time Edit";
            [mBtnOk setTitle:@"Save" forState:UIControlStateNormal];
            mBg.image=[UIImage imageNamed:@"clock_set_bg_en"];
        }
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
