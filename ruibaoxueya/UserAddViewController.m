//
//  UserAddViewController.m
//  ruibaoxueya
//
//  Created by zbf on 14-4-16.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "UserAddViewController.h"
#import "SqlHelper.h"
@interface UserAddViewController ()

@end

@implementation UserAddViewController
@synthesize mInfo;
@synthesize mSex;
@synthesize mName;
@synthesize mKg;
@synthesize mHigh;
@synthesize mAge;
@synthesize mBtnOk;
@synthesize mTitle;
@synthesize mlAge;
@synthesize mlhigh;
@synthesize mlkg;
@synthesize mlname;
@synthesize mlsex;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        msex=0;
        mhigh=170;
        mage=40;
        mkg=60;
        mKgs=[[NSMutableArray alloc] init];
        mHighs=[[NSMutableArray alloc] init];
        mAges=[[NSMutableArray alloc] init];
        for (int i=0; i<250; i++) {
            NSString *item=nil;
            if ([self isEnglish]) {
                item=[NSString stringWithFormat: @"%dY",i];
            }else
            {
                item=[NSString stringWithFormat: @"%d岁",i];
            }
            [mAges addObject:item];
            item=[NSString stringWithFormat: @"%dKg",i];
            [mKgs addObject:item];
            item=[NSString stringWithFormat: @"%dCM",i];
            [mHighs addObject:item];
        }
        
    }
    return self;
}
-(void)selectAtIndex:(int)index andRequest:(int)requestCode
{
    if (requestCode==0) {
        mage=index;
         if ([self isEnglish]) {
               [mAge setTitle:[NSString stringWithFormat:@"%dY",mage] forState:UIControlStateNormal];
         }
        else
        {
            [mAge setTitle:[NSString stringWithFormat:@"%d岁",mage] forState:UIControlStateNormal];
        }
    }
    else if (requestCode==1)
    {
        mhigh=index;
         [mHigh setTitle:[NSString stringWithFormat:@"%dCM",mhigh] forState:UIControlStateNormal];
    }else
    {
        mkg=index;
        [mKg setTitle:[NSString stringWithFormat:@"%dKg",mkg] forState:UIControlStateNormal];
    }
    
    
   
}

-(IBAction)btn_age:(id)sender
{
    NumberSelectViewController *mview=[[NumberSelectViewController alloc]initWithNibName:@"NumberSelectViewController" bundle:Nil];
    mview.mIndex=mage;
    mview.mRequestCode=0;
    mview.delegate=self;
    mview.mNumbers=mAges;
    [self openWindow:mview];
}

-(IBAction)btn_hight:(id)sender
{
    NumberSelectViewController *mview=[[NumberSelectViewController alloc]initWithNibName:@"NumberSelectViewController" bundle:Nil];
    mview.mIndex=mhigh;
    mview.mRequestCode=1;
    mview.delegate=self;
    mview.mNumbers=mHighs;

    [self openWindow:mview];}

-(IBAction)btn_kg:(id)sender
{
    NumberSelectViewController *mview=[[NumberSelectViewController alloc]initWithNibName:@"NumberSelectViewController" bundle:Nil];
    mview.mIndex=mkg;
    mview.mRequestCode=2;
    mview.delegate=self;
    mview.mNumbers=mKgs;

    [self openWindow:mview];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self closeMe];
}
-(IBAction)btn_saveEx:(id)sender
{
    [self btn_save:sender];
}
-(IBAction)btn_save:(id)sender
{
    if (!mName.text||mName.text.length<1) {
         if ([self isEnglish])
         {
              [self showAlertView:@"Name Input"];
         }
        else
        {
            [self showAlertView:@"用户名不能为空"];
        }
        return;
    }
    SqlHelper *sql=[[SqlHelper alloc]init];
    sql.path=[self dataFilePath];
    if (mInfo) {
        mInfo.mUserKg=mkg;
        mInfo.mUserHigh=mhigh;
        mInfo.mUserAge=mage;
        mInfo.mUserSex=mSex.selectedSegmentIndex;
        mInfo.mUserName=mName.text;
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
        QRHosInfo *u=[sql queryInfoByName:mName.text];
        if (!u) {
            mInfo=[[QRHosInfo alloc]init];
            mInfo.mUserKg=mkg;
            mInfo.mUserHigh=mhigh;
            mInfo.mUserAge=mage;
            mInfo.mUserSex=mSex.selectedSegmentIndex;
            mInfo.mUserName=mName.text;
            [sql insert:mInfo];
            if ([self isEnglish]) {
                [self showAlertView:@"Saving Success" withDelegate:self];
            }else
            {
                [self showAlertView:@"保存成功" withDelegate:self];
            }
        }
        else
        {
            if ([self isEnglish])
            {
                [self showAlertView:@"User name existed"];
            }
            else
            {
                 [self showAlertView:@"用户名已经存在"];
            }
            return;
        }
       
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTextFiledStyle:mName withType:1];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!mIsLoad) {
        mIsLoad=YES;
         if ([self isEnglish]) {
             mTitle.text=@"User Info.";
             [mBtnOk setTitle:@"Save" forState:UIControlStateNormal];
             mlsex.text=@"Gender";
             mlname.text=@"Name";
             mlkg.text=@"Weight";
             mlAge.text=@"Age";
             mlhigh.text=@"Height";
             [mSex setTitle:@"Male" forSegmentAtIndex:0];
             [mSex setTitle:@"Female" forSegmentAtIndex:1];
             mlhigh.font=[UIFont fontWithName:@"Helvetica" size:13];
             mlAge.font=[UIFont fontWithName:@"Helvetica" size:13];
              mlkg.font=[UIFont fontWithName:@"Helvetica" size:13];
              mlname.font=[UIFont fontWithName:@"Helvetica" size:13];
              mlsex.font=[UIFont fontWithName:@"Helvetica" size:13];
         }
        if (mInfo) {
            mName.text=mInfo.mUserName;
             if ([self isEnglish]) {
                 [mAge setTitle:[NSString stringWithFormat:@"%dY",mInfo.mUserAge] forState:UIControlStateNormal];
             }else
             {
                 [mAge setTitle:[NSString stringWithFormat:@"%d岁",mInfo.mUserAge] forState:UIControlStateNormal];
             }
            [mKg setTitle:[NSString stringWithFormat:@"%dKg",mInfo.mUserKg] forState:UIControlStateNormal];
            [mHigh setTitle:[NSString stringWithFormat:@"%dCM",mInfo.mUserHigh] forState:UIControlStateNormal];
            mSex.selectedSegmentIndex=mInfo.mUserSex;
            mage=mInfo.mUserAge;
            mhigh=mInfo.mUserHigh;
            mkg=mInfo.mUserKg;
            msex=mInfo.mUserSex;
        }
        else
        {
            mSex.selectedSegmentIndex=msex;
             if ([self isEnglish]) {
                 [mAge setTitle:[NSString stringWithFormat:@"%dY",mage] forState:UIControlStateNormal];
             }
            else
            {
                 [mAge setTitle:[NSString stringWithFormat:@"%d岁",mage] forState:UIControlStateNormal];
            }
            [mKg setTitle:[NSString stringWithFormat:@"%dKg",mkg] forState:UIControlStateNormal];
            [mHigh setTitle:[NSString stringWithFormat:@"%dCM",mhigh] forState:UIControlStateNormal];
        }
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
