//
//  OxyAddViewController.m
//  ruibaoxueya
//
//  Created by zbf on 14-4-20.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "OxyAddViewController.h"
#import "AdInfoManager.h"
#import "DateInfo.h"
#import "AFNetworking.h"

@interface OxyAddViewController ()

@end

@implementation OxyAddViewController
@synthesize mDate;
@synthesize mSate;
@synthesize mShouSuo;
@synthesize mShouZhang;
@synthesize mXinLv;
@synthesize mInfo;
@synthesize mTitle;
@synthesize mBtnOk;
@synthesize mlshoushuya;
@synthesize mlshuzhangya;
@synthesize mlStat;
@synthesize mlxinLv;
@synthesize mDate1;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        mNumbers=[[NSMutableArray alloc]init];
        for (int i=0; i<255; i++) {
            NSString *item=[NSString stringWithFormat: @"%d",i];
            [mNumbers addObject:item];
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
    
    return mNumbers.count*1000;
}

-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    CGRect ret=CGRectMake(0, 0, pickerView.frame.size.width/2-5, pickerView.frame.size.height/3-3);
    UILabel *mLabel=[[UILabel alloc] initWithFrame:ret];
    
    mLabel.text=[mNumbers objectAtIndex:row%mNumbers.count];
    mLabel.font=[UIFont fontWithName:@"Helvetica" size:9];
    
    return  mLabel;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([pickerView isEqual:mShouSuo]) {
         mIndex1=(int)row%mNumbers.count;
    }else  if ([pickerView isEqual:mShouZhang]) {
        mIndex2=(int)row%mNumbers.count;
    }else
    {
        mIndex3=(int)row%mNumbers.count;
    }
}
-(void)selectYear:(int)year selectMonth:(int)month selectDay:(int)day
{
    mdate=year*10000+month*100+day;
}

-(void)selectHour:(int)hour selectMinite:(int)minite
{
    mtime=hour*10000+minite*100;
}

-(void)selectDate:(NSString *)date
{
    [mDate setTitle:date forState:UIControlStateNormal];
    mDateString=date;
}

-(IBAction)btn_date:(id)sender
{
    DateTimeSelectViewController *mView=[[DateTimeSelectViewController alloc]initWithNibName:@"DateTimeSelectViewController" bundle:Nil];
    mView.mYear=mdate/10000;
    mView.mMonth=mdate%10000/100;
    mView.mDay=mdate%10000%100;
    mView.mHour=mtime/10000;
    mView.mMite=mtime%10000/100;
    mView.delegate=self;
    [self openWindow:mView];
}

-(IBAction)btn_ok:(id)sender
{
    AdInfoManager *sql=[[AdInfoManager alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *uid=[prefs objectForKey:@"id"];
    
    sql.path=[self dataFilePath];
    if (mInfo) {
        mInfo.mDate=mdate;
        mInfo.mTime=mtime;
        mInfo.mHighSpO2=mIndex1;
        mInfo.mMinSpO2=mIndex2;
        mInfo.mPulse=mIndex3;
        mInfo.mUserID=[uid intValue];
        [self postDataToWeb];
        if (mSate.selectedSegmentIndex==1) {
            mInfo.mState=1;
        }
        else
        {
            mInfo.mState=0;
        }
         mInfo.mInfo=mDateString;
        [sql update:mInfo];
       
        if ([self isEnglish]) {
            [self showAlertView:@"Saving Success" withDelegate:self];
        }else
        {
            [self showAlertView:@"保存成功" withDelegate:self];
        }
    }
    else
    {
        mInfo=[[AdInfo alloc]init];
        mInfo.mDate=mdate;
        mInfo.mTime=mtime;
        mInfo.mHighSpO2=mIndex1;
        mInfo.mMinSpO2=mIndex2;
        mInfo.mPulse=mIndex3;
        mInfo.mInfo=mDateString;
         mInfo.mUserID=[uid intValue];
        if (mSate.selectedSegmentIndex==1) {
             mInfo.mState=1;
        }
        else
        {
            mInfo.mState=0;
        }
        
        [sql insert:mInfo];
        if ([self isEnglish]) {
            [self showAlertView:@"Saving Success" withDelegate:self];
        }else
        {
            [self showAlertView:@"保存成功" withDelegate:self];
        }
        
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
        if ([self isEnglish]) {
            mTitle.text=@"History";
            mlStat.text=@"Stat";
            mlshuzhangya.text=@"Dia.";
            mlshoushuya.text=@"Sys.";
            mlxinLv.text=@"HR";
            //mlStat.font=[UIFont fontWithName:@"Helvetica" size:13];
            [mBtnOk setTitle:@"Save" forState:UIControlStateNormal];
            [mDate1 setTitle:@"DateTime" forState:UIControlStateNormal];
        }
        misload=YES;
        if (mInfo) {
            mIndex1=mInfo.mHighSpO2;
            mIndex2=mInfo.mMinSpO2;
            mIndex3=mInfo.mPulse;
            mdate=mInfo.mDate;
            mtime=mInfo.mTime;
            if (mInfo.mState==1) {
                mSate.selectedSegmentIndex=1;
            }
            else
            {
                mSate.selectedSegmentIndex=0;
            }
            
            if (mInfo.mInfo) {
                mDateString=mInfo.mInfo;
                
            }else
            {
                 DateInfo *day=[[DateInfo alloc]init];
                [day initDate:mdate withTime:mtime];
                mDateString=[day getDateTimeString];
            }
        }
        else
        {
            DateInfo *day=[[DateInfo alloc]init];
            [day initNow];
            mdate=day.mDate;
            mtime=day.mTime;
            mDateString=[day getDateTimeString];
            mIndex1=120;
            mIndex2=80;
            mIndex3=80;
            mSate.selectedSegmentIndex=1;
        }
        [mDate setTitle:mDateString forState:UIControlStateNormal];
        [mShouSuo selectRow:mIndex1+mNumbers.count*500 inComponent:0 animated:NO];
        [mShouZhang selectRow:mIndex2+mNumbers.count*500 inComponent:0 animated:NO];
        [mXinLv selectRow:mIndex3+mNumbers.count*500 inComponent:0 animated:NO];
        
    }
}

-(void)postDataToWeb
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *URL = [NSString stringWithFormat:@"http://192.168.1.17:8080/CloudService"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
//    parameters    暂时没给json
    
    [manager POST:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
    }];
}

@end
