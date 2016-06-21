//
//  DateSelectViewController.m
//  haihuaguser
//
//  Created by zbf on 14-3-14.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "DateSelectViewController.h"

@interface DateSelectViewController ()

@end

@implementation DateSelectViewController
@synthesize mTime;
@synthesize delegate;
@synthesize mMonth;
@synthesize mDay;
@synthesize mYear;
@synthesize mBtnOk;
@synthesize mTitle;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        mYears=[[NSMutableArray alloc] init];
        mDays=[[NSMutableArray alloc] init];
        mMonths=[[NSMutableArray alloc] init];
        for (int i=1; i<=12; i++) {
            if ([self isEnglish]) {
                NSString *item=[NSString stringWithFormat: @"%dM",i];
                [mMonths addObject:item];
            }
            else
            {
                NSString *item=[NSString stringWithFormat: @"%d月",i];
                [mMonths addObject:item];
            }
           
        }
        for (int j=1; j<=31; j++) {
             if ([self isEnglish]) {
                 NSString *item=[NSString stringWithFormat: @"%dD",j];
                 [mDays addObject:item];
             }
            else
            {
                NSString *item=[NSString stringWithFormat: @"%d日",j];
                [mDays addObject:item];
            }
        }
        
        for (int j=0; j<100; j++) {
            int year=2000+j;
             if ([self isEnglish]) {
                 NSString *item=[NSString stringWithFormat: @"%dY",year];
                 [mYears addObject:item];
             }else
             {
                 NSString *item=[NSString stringWithFormat: @"%d年",year];
                 [mYears addObject:item];
             }
        }
        
        
    }
    return self;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
  
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
        if (component==0) {
            return 100*1000;
        }
        if (component==1) {
            return 12*1000;
        }
   
       return 31*1000;
}

-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    CGRect ret=CGRectMake(5, 0, pickerView.frame.size.width/3-5, pickerView.frame.size.height/3-3);
    UILabel *mLabel=[[UILabel alloc] initWithFrame:ret];
    if (component==0) {
        mLabel.text=[mYears objectAtIndex:row%100];
        
    }
    else if (component==1)     {
        mLabel.text=[mMonths objectAtIndex:row%12];
    }
    else
    {
        mLabel.text=[mDays objectAtIndex:row%31];
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
    }else
    {
        mDay=row%31+1;
    }
}

-(IBAction)btnOk:(id)sender
{
    if (delegate) {
        [delegate selectYear:mYear selectMonth:mMonth selectDay:mDay];
    }
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
        [mTime selectRow:100*100+mYear%2000 inComponent:0 animated:NO];
        [mTime selectRow:100*12+mMonth-1 inComponent:1 animated:NO];
        [mTime selectRow:100*31+mDay-1 inComponent:2 animated:NO];
        mYear=2000+mYear%2000;
       // mMonth=mMonth;
    }
    if ([self isEnglish]) {
        mTitle.text=@"Date";
        [mBtnOk setTitle:@"Ok" forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
