//
//  NumberSelectViewController.m
//  ruibaoxueya
//
//  Created by zbf on 14-4-18.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "NumberSelectViewController.h"

@interface NumberSelectViewController ()

@end

@implementation NumberSelectViewController
@synthesize mRequestCode;
@synthesize mTime;
@synthesize delegate;
@synthesize mIndex;
@synthesize mNumbers;
@synthesize mBtnOk;
@synthesize mTitle;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
       
    }
    return self;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return mNumbers.count*100;
}

-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    CGRect ret=CGRectMake(0, 0, pickerView.frame.size.width/2-5, pickerView.frame.size.height/3-3);
    UILabel *mLabel=[[UILabel alloc] initWithFrame:ret];
  
    mLabel.text=[mNumbers objectAtIndex:row%mNumbers.count];
    mLabel.textAlignment=NSTextAlignmentCenter;
    mLabel.font=[UIFont fontWithName:@"Helvetica" size:9];
    return  mLabel;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    mIndex=(int)row%mNumbers.count;
}

-(IBAction)btnOk:(id)sender
{
    if (delegate) {
        [delegate selectAtIndex:mIndex andRequest :self.mRequestCode];
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
        [mTime selectRow:mIndex+mNumbers.count*50 inComponent:0 animated:NO];
        if ([self isEnglish]) {
            mTitle.text=@"Select";
            [mBtnOk setTitle:@"Ok" forState:UIControlStateNormal];
        }
    }
}


@end
