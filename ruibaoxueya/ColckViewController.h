//
//  ColckViewController.h
//  haihuaguser
//
//  Created by zbf on 14-3-14.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "BaseNetViewController.h"
#import "TimeSelectViewController.h"
@interface ColckViewController : BaseNetViewController<TimeSelectDelegate>
{
    IBOutlet UIButton *btn1;
    IBOutlet UIButton *btn2;
    IBOutlet UIButton *btn3;
    IBOutlet UIButton *btn4;
    IBOutlet UIButton *btn5;
    IBOutlet UIButton *btn6;
    IBOutlet UIButton *btn7;
    IBOutlet UIButton *btnTime;
    IBOutlet UISegmentedControl *mSwitch;
    BOOL day1;
    BOOL day2;
    BOOL day3;
    BOOL day4;
    BOOL day5;
    BOOL day6;
    BOOL day7;
    int mmhour;
    int mmminite;
    NSMutableString *mWeekString;
    BOOL misload;
    IBOutlet UISegmentedControl *mSwitch_check;
    IBOutlet UISegmentedControl *mSwitch_sleep;
    IBOutlet UISegmentedControl *mSwitch_health;
     int remarkIndex;
}
@property(assign)int mType;
@property(nonatomic,retain)IBOutlet UIButton *btn1;
@property(nonatomic,retain)IBOutlet UIButton *btn2;
@property(nonatomic,retain)IBOutlet UIButton *btn3;
@property(nonatomic,retain)IBOutlet UIButton *btn4;
@property(nonatomic,retain)IBOutlet UIButton *btn5;
@property(nonatomic,retain)IBOutlet UIButton *btn6;
@property(nonatomic,retain)IBOutlet UIButton *btn7;
@property(nonatomic,retain)IBOutlet UIButton *btnTime;
@property(nonatomic,retain)IBOutlet UISegmentedControl *mSwitch;
@property(nonatomic,retain)IBOutlet UILabel *mTitle;
@property(retain,nonatomic)IBOutlet UIButton *mBtnOk;
@property(retain,nonatomic)IBOutlet UIImageView *mBg;
-(IBAction)btn1:(id)sender;
-(IBAction)btn2:(id)sender;
-(IBAction)btn3:(id)sender;
-(IBAction)btn4:(id)sender;
-(IBAction)btn5:(id)sender;
-(IBAction)btn6:(id)sender;
-(IBAction)btn7:(id)sender;
-(IBAction)btnTime:(id)sender;
-(IBAction)btnOk:(id)sender;

-(IBAction)btn_check:(id)sender;
-(IBAction)btn_sleep:(id)sender;
-(IBAction)btn_health:(id)sender;
@end
