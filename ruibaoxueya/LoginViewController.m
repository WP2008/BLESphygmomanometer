//
//  LoginViewController.m
//  haihuang
//
//  Created by zbf on 14-2-18.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "LoginViewController.h"
#import "BaseNaviController.h"
#import "BaseTabBarController.h"
#import "UserListViewController.h"
#import "MoreViewController.h"
#import "OxyListViewController.h"
#import "StatViewController.h"
#import "CheckMainViewController.h"
#import "SqlHelper.h"
#import "AdInfoManager.h"
#import "QRHosInfo.h"
#import "UserAddViewController.h"
#import "WorkTimeManager.h"
#import "SqlHelper.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize mTxt_name;
@synthesize mmTable;
@synthesize mbtnOpen;
@synthesize mBg;
@synthesize mbtnAdd;
@synthesize mbtnOk;
@synthesize mbtnVisit;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       mData=[[NSMutableArray alloc]init];
    }
    return self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mData.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
};

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    QRHosInfo *itemInfo=[mData objectAtIndex:indexPath.row];
    if (itemInfo) {
        mTxt_name.text=  itemInfo.mUserName;
        mmTable.hidden=YES;
        [mbtnOpen setBackgroundImage:[UIImage imageNamed:@"btn_down"] forState:UIControlStateNormal];
        /*NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:itemInfo.mUserName forKey:@"name"];
        [prefs setObject:[NSString stringWithFormat:@"%d",itemInfo.mID] forKey:@"id"];
        [prefs synchronize];
        [self loginOK];*/
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *activityCellIdentifier = @"activityCellIdentifier";
    
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:activityCellIdentifier];
    QRHosInfo *itemInfo=[mData objectAtIndex:indexPath.row];
    CGRect ret=CGRectMake(60, 13, cell.frame.size.width-200, 20);
    UILabel *mLabel=[[UILabel alloc] initWithFrame:ret];
    [ cell.contentView addSubview:mLabel];
     mLabel.text=itemInfo.mUserName;
    ret=CGRectMake(10, 10, 22, 22);
    UIImageView *micon=[[UIImageView alloc] initWithFrame:ret];
    [ cell.contentView addSubview:micon];
    if (itemInfo.mSate==1) {
        
        if (itemInfo.mUserSex==1) {
            micon.image=[UIImage imageNamed:@"wuman_check"];
        }
        else
        {
            micon.image=[UIImage imageNamed:@"man_check"];
        }
    }
    else
    {
        if (itemInfo.mUserSex==1) {
            micon.image=[UIImage imageNamed:@"wuman_uncheck"];
        }
        else
        {
            micon.image=[UIImage imageNamed:@"man_uncheck"];
        }
    }
    ret=CGRectMake(2, 44, tableView.frame.size.width-4, 1);
    micon=[[UIImageView alloc] initWithFrame:ret];
    [cell.contentView addSubview:micon];
    
    micon.image=[UIImage imageNamed:@"line"];
    
    ret=CGRectMake(tableView.frame.size.width-20, 15, 8, 15);
    micon=[[UIImageView alloc] initWithFrame:ret];
    [cell.contentView addSubview:micon];
    
    micon.image=[UIImage imageNamed:@"btn_right"];
    cell.backgroundColor=[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0];
    return cell;
}
-(void)loadData
{
    [mData removeAllObjects];
    SqlHelper *sql=[[SqlHelper alloc]init];
    sql.path=[self dataFilePath];
    NSMutableArray* datas=[sql queryInfo];
    if(datas&&datas.count>0)
    {
        
        [mData addObjectsFromArray:datas];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *mid=[prefs objectForKey:@"id"];
        int uid=[mid intValue];
        for (int i=0; i<mData.count; i++) {
            QRHosInfo *minf0=[mData objectAtIndex:i];
            if (minf0.mID==uid) {
                minf0.mSate=1;
                [mmTable reloadData];
                return;
            }
        }
        QRHosInfo *minf1=[mData objectAtIndex:0];
        minf1.mSate=1;
    }
    else
    {
        QRHosInfo* user=[[QRHosInfo alloc ]init];
        user.mUserName=@"visitor";
        user.mUserAge=40;
        user.mUserKg=60;
        user.mUserHigh=170;
        user.mSate=0;
        [sql insert:user];
        [mData addObject:user];
        user=[[QRHosInfo alloc ]init];
        user.mUserName=@"Standard";
        user.mUserAge=40;
        user.mUserKg=60;
        user.mUserHigh=170;
        user.mSate=1;
        [sql insert:user];
        [mData addObject:user];
    }
    [mmTable reloadData];
}

-(void)showAlert:(NSString*) mMsg buttonName:(NSString*)btnTitle
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:Nil message:mMsg delegate:Nil
                                        cancelButtonTitle:btnTitle
                                        otherButtonTitles:nil, nil];
    [alert show];
}

-(void)loginOK
{
    int height=[[UIScreen mainScreen] bounds].size.height;
    UIViewController *viewController1 =nil;
    //float version=[[[UIDevice currentDevice] systemVersion] floatValue];
    UIViewController *viewController2 = nil;
    UIViewController *viewController3 = nil;
    UIViewController *viewController4 =nil;
    UIViewController *viewController5 =nil;
    if (height==480) {
        viewController1 =[[UserListViewController alloc] initWithNibName:@"UserListViewController" bundle:nil];
        viewController2 =[[CheckMainViewController alloc] initWithNibName:@"CheckMainViewController" bundle:nil];
        viewController3 = [[StatViewController alloc] initWithNibName:@"StatViewController" bundle:nil];
        viewController4 = [[OxyListViewController alloc] initWithNibName:@"OxyListViewController" bundle:nil];
        viewController5 = [[MoreViewController alloc] initWithNibName:@"MoreViewController" bundle:nil];
    }
    else
    {
         viewController1 =[[UserListViewController alloc] initWithNibName:@"UserListViewControllerEx" bundle:nil];
         viewController2 =[[CheckMainViewController alloc] initWithNibName:@"CheckMainViewControllerEx" bundle:nil];
         viewController3 = [[StatViewController alloc] initWithNibName:@"StatViewControllerEx" bundle:nil];
        viewController4 = [[OxyListViewController alloc] initWithNibName:@"OxyListViewControllerEx" bundle:nil];
        viewController5 = [[MoreViewController alloc] initWithNibName:@"MoreViewControllerEx" bundle:nil];
    }
    BaseNaviController *naviController1 =nil;
    BaseNaviController *naviController2 =nil;
    BaseNaviController *naviController3 =nil;
    BaseNaviController *naviController4 =nil;
    BaseNaviController *naviController5 =nil;
    if ([self isEnglish]) {
        naviController1 = [[BaseNaviController alloc] initWithRootViewController:viewController1 selImage:[UIImage imageNamed:@"tab11ex.png"] unSelImage:[UIImage imageNamed:@"tab11.png"]];
        
        naviController2 = [[BaseNaviController alloc] initWithRootViewController:viewController2 selImage:[UIImage imageNamed:@"tab21ex.png"] unSelImage:[UIImage imageNamed:@"tab21.png"]];
        
        naviController3 = [[BaseNaviController alloc] initWithRootViewController:viewController3 selImage:[UIImage imageNamed:@"tab31ex.png"] unSelImage:[UIImage imageNamed:@"tab31.png"]];
        
        naviController4 = [[BaseNaviController alloc] initWithRootViewController:viewController4 selImage:[UIImage imageNamed:@"tab41ex.png"] unSelImage:[UIImage imageNamed:@"tab41.png"]];
        
        naviController5 = [[BaseNaviController alloc] initWithRootViewController:viewController5 selImage:[UIImage imageNamed:@"tab51ex.png"] unSelImage:[UIImage imageNamed:@"tab51.png"]];    }
    else
    {
         naviController1 = [[BaseNaviController alloc] initWithRootViewController:viewController1 selImage:[UIImage imageNamed:@"tab1ex.png"] unSelImage:[UIImage imageNamed:@"tab1.png"]];
        
         naviController2 = [[BaseNaviController alloc] initWithRootViewController:viewController2 selImage:[UIImage imageNamed:@"tab2ex.png"] unSelImage:[UIImage imageNamed:@"tab2.png"]];
        
         naviController3 = [[BaseNaviController alloc] initWithRootViewController:viewController3 selImage:[UIImage imageNamed:@"tab3ex.png"] unSelImage:[UIImage imageNamed:@"tab3.png"]];
        
         naviController4 = [[BaseNaviController alloc] initWithRootViewController:viewController4 selImage:[UIImage imageNamed:@"tab4ex.png"] unSelImage:[UIImage imageNamed:@"tab4.png"]];
        
         naviController5 = [[BaseNaviController alloc] initWithRootViewController:viewController5 selImage:[UIImage imageNamed:@"tab5ex.png"] unSelImage:[UIImage imageNamed:@"tab5.png"]];
    }
    
    
    NSArray *controllerArray = [NSArray arrayWithObjects:naviController1,naviController2,naviController3,naviController4,naviController5, nil];
    tabBar = [[BaseTabBarController alloc] initWithControllerArray:controllerArray];
    tabBar.delegate = self;
    
    tabBar.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [tabBar switchViewAt:1];
    if (self.navigationController!=Nil) {
        [self.navigationController pushViewController:tabBar animated:YES];
    }
    else {
        [self presentModalViewController:tabBar animated:YES];
    }
    
}
-(IBAction)btnOpen:(id)sender
{
    if (mmTable.hidden) {
        mmTable.hidden=NO;
        [mbtnOpen setBackgroundImage:[UIImage imageNamed:@"btn_up"] forState:UIControlStateNormal];
    }
    else
    {
        mmTable.hidden=YES;
        [mbtnOpen setBackgroundImage:[UIImage imageNamed:@"btn_down"] forState:UIControlStateNormal];
    }
}

-(IBAction)guestPress:(id)sender
{
    SqlHelper *sql=[[SqlHelper alloc]init];
    sql.path=[self dataFilePath];
    QRHosInfo *user=[sql queryInfoByName:@"visitor"];
    
    if (user) {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:@"visitor" forKey:@"name"];
        [prefs setObject:[NSString stringWithFormat:@"%d",user.mID] forKey:@"id"];
        [prefs synchronize];
    }
    else
    {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:@"visitor" forKey:@"name"];
        [prefs setObject:@"0" forKey:@"id"];
        [prefs synchronize];
    }
    
    [self loginOK];
}

-(IBAction)loginPress:(id)sender
{
    if (!mTxt_name.text) {
        [self showAlertView:@"请输入用户名"];
        return;
    }
    SqlHelper *sql=[[SqlHelper alloc]init];
    sql.path=[self dataFilePath];
    //[sql createDb];
    
    QRHosInfo *user=[sql queryInfoByName:mTxt_name.text];
    if (user) {
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:mTxt_name.text forKey:@"name"];
        [prefs setObject:[NSString stringWithFormat:@"%d",user.mID] forKey:@"id"];
        [prefs synchronize];
        [self loginOK];
    }
    else
    {
        if ([self isEnglish]) {
            [self showAlertView:@" Wrong Name"];
        }
        else
        {
            [self showAlertView:@"登录失败，用户不存在"];
        }
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	// the user pressed the "Done" button, so dismiss the keyboard
	[textField resignFirstResponder];
	return YES;
}

-(IBAction)regestPress:(id)sender
{
    int height=[[UIScreen mainScreen] bounds].size.height;
    if (height==480) {
        
        UserAddViewController* showView=[[UserAddViewController alloc]initWithNibName:@"UserAddViewController" bundle:Nil];
        
        [self openWindow:showView];
        
    }
    else
    {
        UserAddViewController* showView=[[UserAddViewController alloc]initWithNibName:@"UserAddViewControllerEx" bundle:Nil];
     
        [self openWindow:showView];
    }

}


-(void)regestOK:(NSString *)userName withPwd:(NSString *)pwd
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    mTxt_name.text=[prefs objectForKey:@"name"];
}

-(void)intDb
{
    SqlHelper *sql=[[SqlHelper alloc]init];
    sql.path=[self dataFilePath];
    [sql createDb];
    WorkTimeManager *worsql=[[WorkTimeManager alloc]init];
    worsql.path=[self dataFilePath];
    [worsql createDb];
    QRHosInfo *user=[sql queryInfoByName:@"visitor"];
    if (!user) {
        user=[[QRHosInfo alloc ]init];
        user.mUserName=@"visitor";
        user.mUserAge=40;
        user.mUserKg=60;
        user.mUserHigh=170;
        [sql insert:user];
        
        user=[[QRHosInfo alloc ]init];
        user.mUserName=@"Standard";
        user.mUserAge=40;
        user.mUserKg=60;
        user.mUserHigh=170;
        
        [sql insert:user];
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:@"Standard" forKey:@"name"];
        [prefs setObject:[NSString stringWithFormat:@"%d",user.mID] forKey:@"id"];
        [prefs synchronize];

    }
    AdInfoManager *sqlAd=[[AdInfoManager alloc]init];
    sqlAd.path=sql.path;
    [sqlAd createDb];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self intDb];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title=@"用户登录";
    [self initTextFiledStyle:self.mTxt_name withType:1];
    
     NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    mTxt_name.text=[prefs objectForKey:@"name"];
    
    mmTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    mmTable.allowsSelection=YES;
    if ([self isEnglish]) {
        mBg.image=[UIImage imageNamed:@"login_bg_en"];
        [mbtnVisit setBackgroundImage:[UIImage imageNamed:@"btn_login_visit_en"] forState:UIControlStateNormal];
        [mbtnOk setBackgroundImage:[UIImage imageNamed:@"btn_login_en"] forState:UIControlStateNormal];
        [mbtnAdd setBackgroundImage:[UIImage imageNamed:@"btn_login_add_en"] forState:UIControlStateNormal];
    }
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadData];
    mmTable.hidden=YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.navigationController!=Nil) {
        [self.navigationController setNavigationBarHidden:YES];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
