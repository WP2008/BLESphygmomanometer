//
//  TimeSelectViewController.m
//  haihuaguser
//
//  Created by zbf on 14-3-14.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "TimeSelectViewController.h"

@interface TimeSelectViewController ()

@end

@implementation TimeSelectViewController
@synthesize mTime;
@synthesize delegate;
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
              if ([self isEnglish]) {
                  NSString *item=[NSString stringWithFormat: @"%dH",i];
                  [mHours addObject:item];
              }
             else
              {
                  NSString *item=[NSString stringWithFormat: @"%d时",i];
                  [mHours addObject:item];
              }
        }
        for (int j=0; j<60; j++) {
              if ([self isEnglish]) {
                  NSString *item=[NSString stringWithFormat: @"%dM",j];
                  [mMinite addObject:item];
              }else
              {
                  NSString *item=[NSString stringWithFormat: @"%d分",j];
                  [mMinite addObject:item];
              }
        }

    }
    return self;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if ([pickerView isEqual:mTime]) {
        return 2;
    }
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([pickerView isEqual:mTime]) {
        if (component==0) {
            return 24*1000;
        }
        if (component==1) {
            return 60*1000;
        }
    }
    else
    {
        
    }
    return 10000;
}

-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    CGRect ret=CGRectMake(5, 0, pickerView.frame.size.width/2-5, pickerView.frame.size.height/3-3);
    UILabel *mLabel=[[UILabel alloc] initWithFrame:ret];
    if (component==0) {
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
        mHour=row%24;
    }
    else
    {
        mMite=row%60;
    }
}

-(IBAction)btnOk:(id)sender
{
    if (delegate) {
        [delegate selectHour:mHour selectMinite:mMite];
    }
    [self closeMe];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
        
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!misload) {
        misload=YES;
        [mTime selectRow:100*24+mHour inComponent:0 animated:NO];
        [mTime selectRow:100*60+mMite inComponent:1 animated:NO];
    }
    if ([self isEnglish]) {
        mTitle.text=@"Time";
        [mBtnOk setTitle:@"Ok" forState:UIControlStateNormal];
    }
}


@end
