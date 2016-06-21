//
//  DateTimeSelectViewController.m
//  haihuaguser
//
//  Created by zbf on 14-3-14.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "DateTimeSelectViewController.h"

@interface DateTimeSelectViewController ()

@end

@implementation DateTimeSelectViewController
@synthesize mTime;
@synthesize delegate;
@synthesize mMonth;
@synthesize mDay;
@synthesize mYear;
@synthesize mMite;
@synthesize mHour;
@synthesize mBtnOk;
@synthesize mTitle;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        mHours=[[NSMutableArray alloc] init];
        mMinite=[[NSMutableArray alloc] init];
        for (int i=0; i<24; i++) {
            NSString *item=[NSString stringWithFormat: @"%d",i];
            [mHours addObject:item];
        }
        for (int j=0; j<60; j++) {
            NSString *item=[NSString stringWithFormat: @"%d",j];
            [mMinite addObject:item];
        }
        
        mYears=[[NSMutableArray alloc] init];
        mDays=[[NSMutableArray alloc] init];
        mMonths=[[NSMutableArray alloc] init];
        for (int i=1; i<=12; i++) {
            NSString *item=[NSString stringWithFormat: @"%d",i];
            [mMonths addObject:item];
        }
        for (int j=1; j<=31; j++) {
            NSString *item=[NSString stringWithFormat: @"%d",j];
            [mDays addObject:item];
        }
        
        for (int j=0; j<100; j++) {
            int year=2000+j;
            NSString *item=[NSString stringWithFormat: @"%d",year];
            [mYears addObject:item];
        }
    }
    return self;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 5;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (component==0) {
        return 100*1000;
    }
    if (component==1) {
        return 12*1000;
    }
    if (component==2) {
        return 31*1000;
    }
    if (component==3) {
        return 24*1000;
    }
    return 60*1000;
}

-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    CGRect ret=CGRectMake(5, 0, pickerView.frame.size.width/5-5, pickerView.frame.size.height/3-3);
    UILabel *mLabel=[[UILabel alloc] initWithFrame:ret];
    if (component==0) {
        mLabel.text=[mYears objectAtIndex:row%100];
        
    }
    else if (component==1)     {
        mLabel.text=[mMonths objectAtIndex:row%12];
    }
    else if (component==2)       {
        mLabel.text=[mDays objectAtIndex:row%31];
    }else if (component==3) {
        mLabel.text=[mHours objectAtIndex:row%24];
        
    }
    else
    {
        mLabel.text=[mMinite objectAtIndex:row%60];
    }
    mLabel.textAlignment=NSTextAlignmentCenter;
    mLabel.font=[UIFont fontWithName:@"Helvetica" size:9];
    return  mLabel;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component==0) {
        mYear=row%100+2000;
    }
    else  if (component==1)     {
        mMonth=row%12+1;
    }else if (component==2)    {
        mDay=row%31+1;
    }else if (component==3)    {
        mHour=row%24;
    }
    mMite=row%60;
}

-(IBAction)btnOk:(id)sender
{
    if (delegate) {
        [delegate selectYear:mYear selectMonth:mMonth selectDay:mDay];
        [delegate selectHour:mHour selectMinite:mMite];
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
        
        if (mMite>9) {
            [sb appendFormat:@":%d",mMite];
        }
        else
        {
            [sb appendFormat:@":0%d",mMite];
        }
        [sb appendFormat:@":00"];
        [delegate selectDate:sb];
    }
    [self closeMe];
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
    
    if (mHour>9) {
        [sb appendFormat:@" %d",mHour];
    }
    else
    {
        [sb appendFormat:@" 0%d",mHour];
    }
    
    if (mMite>9) {
        [sb appendFormat:@":%d",mMite];
    }
    else
    {
        [sb appendFormat:@":0%d",mMite];
    }
    [sb appendFormat:@":00"];
    return sb;
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
        [mTime selectRow:100*100+mYear%2000 inComponent:0 animated:NO];
        [mTime selectRow:100*12+mMonth-1 inComponent:1 animated:NO];
        [mTime selectRow:100*31+mDay-1 inComponent:2 animated:NO];
        
        [mTime selectRow:100*24+mHour inComponent:3 animated:NO];
        [mTime selectRow:100*60+mMite inComponent:4 animated:NO];
        
        if (mMite<0) {
            mMite=0;
        }
    }
    if ([self isEnglish]) {
        mTitle.text=@"DateTime";
        [mBtnOk setTitle:@"Ok" forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
