 //
//  CheckSetViewController.m
//  ruibaoxueya
//
//  Created by zbf on 14-4-28.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "CheckSetViewController.h"

@interface CheckSetViewController ()

@end

@implementation CheckSetViewController
@synthesize mtype;
@synthesize mSate;
@synthesize mStart;
@synthesize mEnd;
@synthesize mJianGe;
@synthesize mTitle;
@synthesize mTitleEx;
@synthesize mBtnOk;
@synthesize mlend;
@synthesize mljiange;
@synthesize mlstart;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        mNumbers=[[NSMutableArray alloc]init];
        [mNumbers addObject:@"00:00"];
        [mNumbers addObject:@"00:30"];
        [mNumbers addObject:@"01:00"];
        [mNumbers addObject:@"01:30"];
        [mNumbers addObject:@"02:00"];
        [mNumbers addObject:@"02:30"];
        [mNumbers addObject:@"03:00"];
        [mNumbers addObject:@"03:30"];
        [mNumbers addObject:@"04:00"];
        [mNumbers addObject:@"04:30"];
        [mNumbers addObject:@"05:00"];
        [mNumbers addObject:@"05:30"];
        [mNumbers addObject:@"06:00"];
        [mNumbers addObject:@"06:30"];
        [mNumbers addObject:@"07:00"];
        [mNumbers addObject:@"07:30"];
        [mNumbers addObject:@"08:00"];
        [mNumbers addObject:@"08:30"];
        [mNumbers addObject:@"09:00"];
        [mNumbers addObject:@"09:30"];
        [mNumbers addObject:@"10:00"];
        [mNumbers addObject:@"10:30"];
        [mNumbers addObject:@"11:00"];
        [mNumbers addObject:@"11:30"];
        
        [mNumbers addObject:@"12:00"];
        [mNumbers addObject:@"12:30"];
        [mNumbers addObject:@"13:00"];
        [mNumbers addObject:@"13:30"];
        [mNumbers addObject:@"14:00"];
        [mNumbers addObject:@"14:30"];
        [mNumbers addObject:@"15:00"];
        [mNumbers addObject:@"15:30"];
        [mNumbers addObject:@"16:00"];
        [mNumbers addObject:@"16:30"];
        [mNumbers addObject:@"17:00"];
        [mNumbers addObject:@"17:30"];
        [mNumbers addObject:@"18:00"];
        [mNumbers addObject:@"18:30"];
        [mNumbers addObject:@"19:00"];
        [mNumbers addObject:@"19:30"];
        [mNumbers addObject:@"20:00"];
        [mNumbers addObject:@"20:30"];
        [mNumbers addObject:@"21:00"];
        [mNumbers addObject:@"21:30"];
        [mNumbers addObject:@"22:00"];
        [mNumbers addObject:@"22:30"];
        [mNumbers addObject:@"23:00"];
        [mNumbers addObject:@"23:30"];
        
        mNumbers2=[[NSMutableArray alloc]init];
        [mNumbers2 addObject:@"15"];
        [mNumbers2 addObject:@"30"];
        [mNumbers2 addObject:@"45"];
        [mNumbers2 addObject:@"60"];
        [mNumbers2 addObject:@"90"];
        [mNumbers2 addObject:@"120"];
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
    if ([pickerView isEqual:mStart]||[pickerView isEqual:mEnd])
    {
        return mNumbers.count*1000;
    }
    return mNumbers2.count*1000;}

-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    CGRect ret=CGRectMake(0, 0, pickerView.frame.size.width/2-5, pickerView.frame.size.height/3-3);
    UILabel *mLabel=[[UILabel alloc] initWithFrame:ret];
    if ([pickerView isEqual:mStart]||[pickerView isEqual:mEnd])
    {
        mLabel.text=[mNumbers objectAtIndex:row%mNumbers.count];
        
    
    }
    else
    {
        mLabel.text=[mNumbers2 objectAtIndex:row%mNumbers2.count];
        
    }
    mLabel.font=[UIFont fontWithName:@"Helvetica" size:9];
    return  mLabel;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([pickerView isEqual:mStart]) {
        mIndex1=(int)row%mNumbers.count;
    }else  if ([pickerView isEqual:mEnd]) {
        mIndex2=(int)row%mNumbers.count;
    }else
    {
        mIndex3=(int)row%mNumbers2.count;
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self closeMe];
}
-(int )getInternel:(int )index
{
    switch (index) {
        case 0:
            return 15;
            break;
        case 1:
            return 30;
            break;
        case 2:
            return 45;
            break;
        case 3:
            return 60;
            break;
        case 4:
            return 90;
            break;
        case 5:
            return 120;
            break;
            
    }
    return 15;
}


-(int )getTime:(int )index
{
    switch (index) {
        case 0:
            return 0;
            break;
        case 1:
            return 30;
            break;
        case 2:
            return 100;
            break;
        case 3:
            return 130;
            break;
        case 4:
            return 200;
            break;
        case 5:
            return 230;
            break;
        case 6:
            return 300;
            break;
        case 7:
            return 330;
            break;
        case 8:
            return 400;
            break;
        case 9:
            return 430;
            break;
        case 10:
            return 500;
            break;
        case 11:
            return 530;
            break;
        case 12:
            return 600;
            break;
        case 13:
            return 630;
            break;
        case 14:
            return 700;
            break;
        case 15:
            return 730;
            break;
        case 16:
            return 800;
            break;
        case 17:
            return 830;
            break;
        case 18:
            return 900;
            break;
        case 19:
            return 930;
            break;
        case 20:
            return 1000;
            break;
        case 21:
            return 1030;
            break;
        case 22:
            return 1100;
            break;
        case 23:
            return 1130;
            break;
        case 24:
            return 1200;
            break;
        case 25:
            return 1230;
            break;
        case 26:
            return 1300;
            break;
        case 27:
            return 1330;
            break;
        case 28:
            return 1400;
            break;
        case 29:
            return 1430;
            break;
        case 30:
            return 1500;
            break;
        case 31:
            return 1530;
            break;
        case 32:
            return 1600;
            break;
        case 33:
            return 1630;
            break;
        case 34:
            return 1700;
            break;
        case 35:
            return 1730;
            break;
        case 36:
            return 1800;
            break;
        case 37:
            return 1830;
            break;
        case 38:
            return 1900;
            break;
        case 39:
            return 1930;
            break;
        case 40:
            return 2000;
            break;
        case 41:
            return 2030;
            break;
        case 42:
            return 2100;
            break;
        case 43:
            return 2130;
            break;
        case 44:
            return 2200;
            break;
        case 45:
            return 2230;
            break;
        case 46:
            return 2300;
            break;
        case 47:
            return 2330;
            break;
            
        default:
            return 0;

    }
}

-(IBAction)btn_ok:(id)sender
{
    int s=[self getTime:mIndex1];
    int e=[self getTime:mIndex2];
    
    int inel=[self getInternel:mIndex3];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if (mtype==0) {
        if (mSate.selectedSegmentIndex==1) {
            [prefs setObject:@"1" forKey:@"openbaitian"];
            if (mIndex1==mIndex2) {
                [self showAlertView:mAlertInfo];
                return;
            }
        }
        else
        {
            [prefs setObject:@"0" forKey:@"openbaitian"];
        }
        [prefs setObject:[NSString stringWithFormat:@"%d",s] forKey:@"openbaitiantimes"];
        [prefs setObject:[NSString stringWithFormat:@"%d",e] forKey:@"openbaitiantimee"];
        [prefs setObject:[NSString stringWithFormat:@"%d",inel] forKey:@"openbaitiantimeinel"];
        
        [prefs setObject:[NSString stringWithFormat:@"%d",mIndex1] forKey:@"openbaitiantimesindex"];
        [prefs setObject:[NSString stringWithFormat:@"%d",mIndex2] forKey:@"openbaitiantimeeindex"];
        [prefs setObject:[NSString stringWithFormat:@"%d",mIndex3] forKey:@"openbaitiantimeinelindex"];
    }
    else
    {
        if (mSate.selectedSegmentIndex==1) {
            [prefs setObject:@"1" forKey:@"openwanshang"];
            if (mIndex1==mIndex2) {
                [self showAlertView:mAlertInfo];
                return;
            }
        }
        else
        {
            [prefs setObject:@"0" forKey:@"openwanshang"];
        }
        [prefs setObject:[NSString stringWithFormat:@"%d",s] forKey:@"openwanshangtimes"];
        [prefs setObject:[NSString stringWithFormat:@"%d",e] forKey:@"openwanshangtimee"];
        [prefs setObject:[NSString stringWithFormat:@"%d",inel] forKey:@"openwanshangtimeinel"];
        [prefs setObject:[NSString stringWithFormat:@"%d",mIndex1] forKey:@"openwanshangtimesindex"];
        [prefs setObject:[NSString stringWithFormat:@"%d",mIndex2] forKey:@"openwanshangtimeeindex"];
        [prefs setObject:[NSString stringWithFormat:@"%d",mIndex3] forKey:@"openwanshangtimeinelindex"];
    }
    [prefs synchronize];
    [self closeMe];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!misload) {
        misload=YES;
         NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        if (mtype==0) {
            if ([self isEnglish]) {
                mTitleEx.text=@"Awake Setting";
            }
            else
            {
                mTitleEx.text=@"白天连续测量模式";
            }
            NSString *mindex=[prefs objectForKey:@"openbaitiantimesindex"];
            if (mindex) {
                mIndex1=[mindex intValue];
                mindex=[prefs objectForKey:@"openbaitiantimeeindex"];
                if (mindex) {
                    mIndex2=[mindex intValue];
                }
                mindex=[prefs objectForKey:@"openbaitiantimeinelindex"];
                if (mindex) {
                    mIndex3=[mindex intValue];
                }
                mindex=[prefs objectForKey:@"openbaitian"];
                if (mindex) {
                    if ([mindex intValue]==1) {
                        mSate.selectedSegmentIndex=1;
                    }
                    else
                    {
                        mSate.selectedSegmentIndex=0;
                    }
                }
            }
        }
        else
        {
             if ([self isEnglish]) {
                 mTitleEx.text=@"Asleep Setting";
             }
            else
            {
                mTitleEx.text=@"夜间连续测量模式";
            }
            NSString *mindex=[prefs objectForKey:@"openwanshangtimesindex"];
            if (mindex) {
                mIndex1=[mindex intValue];
                mindex=[prefs objectForKey:@"openwanshangtimeeindex"];
                if (mindex) {
                    mIndex2=[mindex intValue];
                }
                mindex=[prefs objectForKey:@"openwanshangtimeinelindex"];
                if (mindex) {
                    mIndex3=[mindex intValue];
                }
                mindex=[prefs objectForKey:@"openwanshang"];
                if (mindex) {
                    if ([mindex intValue]==1) {
                        mSate.selectedSegmentIndex=1;
                    }else
                    {
                        mSate.selectedSegmentIndex=0;
                    }
                }
            }
            
        }
        if ([self isEnglish]) {
            mTitle.text=@"Programming";
            [mBtnOk setTitle:@"Ok" forState:UIControlStateNormal];
           
            mlstart.text=@"Start";
            mlend.text=@"end";
            mljiange.text=@"Interals";
            
        }

        [mStart selectRow:mIndex1+mNumbers.count*500 inComponent:0 animated:NO];
        [mEnd selectRow:mIndex2+mNumbers.count*500 inComponent:0 animated:NO];
        [mJianGe selectRow:mIndex3+mNumbers2.count*500 inComponent:0 animated:NO];
        
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
