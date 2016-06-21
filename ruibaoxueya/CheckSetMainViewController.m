//
//  CheckSetMainViewController.m
//  ruibaoxueya
//
//  Created by zbf on 14-4-28.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "CheckSetMainViewController.h"
#import "CheckSetViewController.h"
#import "WorkTimeManager.h"
#import "QRHosInfo.h"
#import "DateInfo.h"
@interface CheckSetMainViewController ()

@end

@implementation CheckSetMainViewController
@synthesize delegate;
@synthesize mRequestCode;
@synthesize mQiYa;
@synthesize mIndex;
@synthesize mNumbers;
@synthesize indicatorView;
@synthesize btnOk;
@synthesize mBtnOk;
@synthesize mTitle;
@synthesize mBtnSet1;
@synthesize mBtnSet2;
@synthesize mlQiYA;
@synthesize mlset1;
@synthesize mlset2;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        mNumbers=[[NSMutableArray alloc]init];
        [mNumbers  addObject:@"200"];
        [mNumbers  addObject:@"210"];
        [mNumbers  addObject:@"220"];
        [mNumbers  addObject:@"230"];
        [mNumbers  addObject:@"240"];
        [mNumbers  addObject:@"250"];
        [mNumbers  addObject:@"260"];
        [mNumbers  addObject:@"270"];
        [mNumbers  addObject:@"280"];
        if ([self isEnglish]) {
            mAlertInfo=@"The Time Set is Error,Please ReSet";
        }
        else
        {
            mAlertInfo=@"时间段设置不正确或者重复,请重新设置";
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
    mIndex=(int)row%mNumbers.count;
}

-(IBAction)btnBaiTian:(id)sender
{
    CheckSetViewController* mview=[[CheckSetViewController alloc]initWithNibName:@"CheckSetViewController" bundle:nil];
    mview.mtype=0;
    [self openWindow:mview];
}

-(IBAction)btnWanShang:(id)sender
{
    CheckSetViewController* mview=[[CheckSetViewController alloc]initWithNibName:@"CheckSetViewController" bundle:nil];
    mview.mtype=1;
    [self openWindow:mview];
}

-(IBAction)btnOk:(id)sender
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
     [prefs setObject:[NSString stringWithFormat:@"%d",mIndex] forKey:@"maxindex"];
    int max=200+mIndex*10;
    [prefs setObject:[NSString stringWithFormat:@"%d",max] forKey:@"max"];
    [prefs synchronize];
    int mIndex1=0;
    int  mIndex2=0;
    BOOL openBaiTian=false;
    NSString *mindex=[prefs objectForKey:@"openbaitian"];
    if (mindex) {
        if ([mindex intValue]==1) {
            openBaiTian=YES;
            mindex=[prefs objectForKey:@"openbaitiantimesindex"];
            if (mindex) {
                mIndex1=[mindex intValue];
                mindex=[prefs objectForKey:@"openbaitiantimeeindex"];
                if (mindex) {
                    mIndex2=[mindex intValue];
                }
                else
                {
                    [self showAlertView:mAlertInfo];
                    return;
                }
                
            }
            else
            {
                [self showAlertView:mAlertInfo];
                return;
            }
        }
        else
        {
            openBaiTian=NO;
        }
    }
    
    int emIndex1=0;
    int  emIndex2=0;
    BOOL openwanShang=false;
    
    mindex=[prefs objectForKey:@"openwanshang"];
    if (mindex) {
        if ([mindex intValue]==1) {
            openwanShang=YES;
            mindex=[prefs objectForKey:@"openwanshangtimesindex"];
            if (mindex) {
                emIndex1=[mindex intValue];
                mindex=[prefs objectForKey:@"openwanshangtimeeindex"];
                if (mindex) {
                    emIndex2=[mindex intValue];
                }
            }
        }
        else
        {
            openwanShang=NO;
        }
    }
   
    DateInfo *date=[[DateInfo alloc]init];
    int hour=date.mHour;
    int minite=date.mMinite;
    hour=hour*2+minite/30;
    
    int bs=0;
    int be=0;
    int es=0;
    int ee=0;
    if (openBaiTian) {
        if (mIndex1==mIndex2) {
            [self showAlertView:mAlertInfo];
            return;
        }
        if (mIndex1<mIndex2) {
            bs=mIndex1;
            be=mIndex2;
        }
        else
        {
            if (emIndex1<emIndex2) {
                bs=mIndex1;
                be=mIndex2+48;
                if (mIndex2>emIndex1) {
                    [self showAlertView:mAlertInfo];
                    return;
                }
            }
            else
            {
                [self showAlertView:mAlertInfo];
                return;
            }
        }
    }
    
    if (openwanShang) {
        if (emIndex1==emIndex2) {
            [self showAlertView:mAlertInfo];
            return;
        }
        if (emIndex1<emIndex2) {
            es=emIndex1;
            ee=emIndex2;
        }
        else
        {
           if (mIndex1<mIndex2)
           {
               es=emIndex1;
               ee=emIndex2+48;
               if (emIndex2>mIndex1) {
                   [self showAlertView:mAlertInfo];
                   return;
               }
           }
           else
           {
               [self showAlertView:mAlertInfo];
               return;
           }
        }
    }
    
    if (openBaiTian&&openwanShang) {
        if (bs>es&&bs<ee) {
            [self showAlertView:mAlertInfo];
            return;
        }
        if (be>es&&be<ee) {
            [self showAlertView:mAlertInfo];
            return;
        }
        
        if (ee>bs&&ee<be) {
            [self showAlertView:mAlertInfo];
            return;
        }
        
        if (es>bs&&es<be) {
            [self showAlertView:mAlertInfo];
            return;
        }
    }
    
    if (self.delegate) {
        
        WorkTimeManager *sql=[[WorkTimeManager alloc]init];
        sql.path=[self dataFilePath];
        [sql createDb];
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *uid=[prefs objectForKey:@"id"];
        
        QRHosInfo *info=[[QRHosInfo alloc]init];
        info.mUserKg=date.mDate;
        info.mUserAge=date.mHour*60+date.mMinite;
        info.mUserName=uid;
        [date initDateWithDay:1];
        info.mUserSex=date.mDate;
        info.mUserHigh=info.mUserAge;
        [sql insert:info];
        [self.delegate startBianChang ];
        indicatorView.hidden=NO;
        
        btnOk.hidden=YES;
    }
    else
    {
         if ([self isEnglish]) {
             [self showAlertView:@"Save Ok " withDelegate:self];
         }
        else
        {
            [self showAlertView:@"编程设置成功" withDelegate:self];
        }
    }
}

-(void)sendOk
{
     indicatorView.hidden=YES;
    [self  closeMe];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    indicatorView.hidden=YES;
    [self  closeMe];
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
    indicatorView.hidden=YES;
    indicatorView.hidesWhenStopped = TRUE;
    if (!misload) {
        misload=YES;
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString* mindex=[prefs objectForKey:@"maxindex"];
        if (mindex) {
            mIndex=[mindex intValue];
        }
        [mQiYa selectRow:mIndex+mNumbers.count*500 inComponent:0 animated:NO];
        if ([self isEnglish]) {
            mTitle.text=@"Programming";
            [mBtnOk setTitle:@"Ok" forState:UIControlStateNormal];
            [mBtnSet2 setTitle:@"Set" forState:UIControlStateNormal];
            [mBtnSet1 setTitle:@"Set" forState:UIControlStateNormal];
            mlset2.text=@"Asleep Setting";
            mlset1.text=@"Awake Setting";
            mlQiYA.text=@"Inflation Limit";
            
        }
    }
}
- (void)viewWillDisappear{
    if ([indicatorView isAnimating]) {
		[indicatorView stopAnimating];
	}
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
