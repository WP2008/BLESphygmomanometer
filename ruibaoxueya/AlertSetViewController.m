//
//  AlertSetViewController.m
//  ruibaoxueya
//
//  Created by zbf on 14-4-20.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "AlertSetViewController.h"

@interface AlertSetViewController ()

@end

@implementation AlertSetViewController


@synthesize mSate;
@synthesize mShouSuo;
@synthesize mShouZhang;
@synthesize mSate1;
@synthesize mTitle;
@synthesize mBtnOk;
@synthesize mlSate;
@synthesize mlSate1;
@synthesize mlShouSuo;
@synthesize mlShouZhang;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        mNumbers=[[NSMutableArray alloc]init];
         mNumbers1=[[NSMutableArray alloc]init];
        for (int i=140; i<200; i++) {
            NSString *item=[NSString stringWithFormat: @"%d",i];
            [mNumbers addObject:item];
        }
        for (int i=90; i<150; i++) {
            NSString *item=[NSString stringWithFormat: @"%d",i];
            [mNumbers1 addObject:item];
        }
    }
    return self;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
     if ([pickerView isEqual:mShouSuo]) {
         return mNumbers.count*1000;
     }
    else
    {
         return mNumbers1.count*1000;
    }
}

-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    CGRect ret=CGRectMake(0, 0, pickerView.frame.size.width/2-5, pickerView.frame.size.height/3-3);
    UILabel *mLabel=[[UILabel alloc] initWithFrame:ret];
     if ([pickerView isEqual:mShouSuo]) {
         mLabel.text=[mNumbers objectAtIndex:row%mNumbers.count];
     }
     else
     {
          mLabel.text=[mNumbers1 objectAtIndex:row%mNumbers1.count];
     }
    mLabel.font=[UIFont fontWithName:@"Helvetica" size:9];
    return  mLabel;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([pickerView isEqual:mShouSuo]) {
        mIndex1=(int)row%mNumbers.count;
    }else  if ([pickerView isEqual:mShouZhang]) {
        mIndex2=(int)row%mNumbers1.count;
    }
}




-(IBAction)btn_ok:(id)sender
{
     NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:[NSString stringWithFormat:@"%d",mIndex1] forKey:@"alert_shousuo_value"];
     [prefs setObject:[NSString stringWithFormat:@"%d",mIndex2] forKey:@"alert_shuzhang_value"];
    if (mSate.selectedSegmentIndex==1) {
        mIndex1=1;
    }else
    {
        mIndex1=0;
    }
     [prefs setObject:[NSString stringWithFormat:@"%d",mIndex1] forKey:@"alert_state_value"];
    if (mSate1.selectedSegmentIndex==1) {
        mIndex1=1;
    }else
    {
        mIndex1=0;
    }
    [prefs setObject:[NSString stringWithFormat:@"%d",mIndex1] forKey:@"alert_state1_value"];
    [prefs synchronize];
    if ([self isEnglish]) {
          [self showAlertView:@"Saving Success" withDelegate:self];
    }else
    {
        [self showAlertView:@"保存成功" withDelegate:self];
    }
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
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
         NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *mind1=[prefs objectForKey:@"alert_shousuo_value"];
        if (mind1) {
            mIndex1=[mind1 intValue];
        }else
        {
            mIndex1=140;
        }
        mind1=[prefs objectForKey:@"alert_shuzhang_value"];
        if (mind1) {
            mIndex2=[mind1 intValue];
        }else
        {
            mIndex2=140;
        }
        mind1=[prefs objectForKey:@"alert_state_value"];
        if (mind1) {
            if ([mind1 intValue]==1) {
                mSate.selectedSegmentIndex=1;
            }
        }
        mind1=[prefs objectForKey:@"alert_state1_value"];
        if (mind1) {
            if ([mind1 intValue]==1) {
                mSate1.selectedSegmentIndex=1;
            }
        }
        if ([self isEnglish]) {
            mTitle.text=@"BP Alarm";
            [mBtnOk setTitle:@"Save" forState:UIControlStateNormal];
            mlShouZhang.text=@"Dia. Alarm Limit";
            mlShouSuo.text=@"Sys. Alarm Limit";
            mlSate1.text=@"BP Alarm";
            mlSate.text=@"BP Meas. Fialed";
             mlShouZhang.font=[UIFont fontWithName:@"Helvetica" size:13];
             mlShouSuo.font=[UIFont fontWithName:@"Helvetica" size:13];
        }

        [mShouSuo selectRow:mIndex1+mNumbers.count*500 inComponent:0 animated:NO];
        [mShouZhang selectRow:mIndex2+mNumbers.count*500 inComponent:0 animated:NO];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
