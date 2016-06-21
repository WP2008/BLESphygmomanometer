//
//  MoreViewController.m
//  ruibaoxueya
//
//  Created by zbf on 14-4-17.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "MoreViewController.h"
#import "ActionInfoModel.h"

#import "OxyBiaoZhunViewController.h"
#import "AlertSetViewController.h"
#import "SeachDevViewController.h"
#import "FenXiangViewController.h"
#import "AoatViewController.h"
#import "HelpViewController.h"
#import "ClockListViewController.h"
@interface MoreViewController ()

@end

@implementation MoreViewController
@synthesize mTitle;
@synthesize mmTable;
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
    return 40;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
};

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   ClockListViewController *mcview=[[ClockListViewController alloc] initWithNibName:@"ClockListViewController" bundle:Nil];
    //ColckViewController *mcview1=[[ColckViewController alloc] initWithNibName:@"ColckViewController" bundle:Nil];
    OxyBiaoZhunViewController *mcview1=[[OxyBiaoZhunViewController alloc] initWithNibName:@"OxyBiaoZhunViewController" bundle:Nil];
    ActionInfoModel *itemInfo=[mData objectAtIndex:indexPath.row];
    AlertSetViewController *alertView=[[ AlertSetViewController alloc]initWithNibName:@"AlertSetViewController" bundle:Nil];
    SeachDevViewController *mseachv=[[SeachDevViewController alloc] initWithNibName:@"SeachDevViewController" bundle:Nil];
    FenXiangViewController *fxview=[[FenXiangViewController alloc]initWithNibName:@"FenXiangViewController" bundle:nil];
    HelpViewController *hpview=[[HelpViewController alloc]initWithNibName:@"HelpViewController" bundle:nil];
    AoatViewController *abview=[[AoatViewController alloc]initWithNibName:@"AoatViewController" bundle:nil];
    
    if (itemInfo) {
        switch (itemInfo.mClass)
        {
            case 1:
              
                [self openWindow:mcview];
                break;
                
            case 2:
                
                [self openWindow:alertView];
                break;
            case 3:
                
                [self openWindow:mseachv];
                break;

            case 4:
                
                [self openWindow:mcview1];
                break;
            case 5:
                
                [self openWindow:abview];
                break;
                
            case 6:
                
                [self openWindow:hpview];
                break;
            case 7:
                
                [self openWindow:fxview];
                break;
                
            case 8:
                
                [self btn_excit:nil];
                break;
                
            default:
               
                break;
        }
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *activityCellIdentifier = @"activityCellIdentifier";
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:activityCellIdentifier];
    ActionInfoModel *itemInfo=[mData objectAtIndex:indexPath.row];
    CGRect ret=CGRectMake(40, 3, cell.frame.size.width-90, 30);
    UILabel *mLabel=[[UILabel alloc] initWithFrame:ret];
    [ cell.contentView addSubview:mLabel];
    ret=CGRectMake(5, 10, 20, 20);
    UIImageView *micon=[[UIImageView alloc] initWithFrame:ret];
    [ cell.contentView addSubview:micon];
    
    micon.image=[UIImage imageNamed:itemInfo.mInfo];
    
    mLabel.text=itemInfo.mTitle;
   // mInfo.text=itemInfo.mRemark;
    //mDate.text=itemInfo.mDate;
    itemInfo.mType=[NSString stringWithFormat:@"%@",itemInfo.mType];
    ret=CGRectMake(cell.frame.size.width-40, 10, 10, 20);
    micon=[[UIImageView alloc] initWithFrame:ret];
    [cell.contentView addSubview:micon];
    
    micon.image=[UIImage imageNamed:@"btn_right"];
    return cell;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    // mmTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view from its nib.
}

-(void)loadData
{
    if ([self isEnglish]) {
        ActionInfoModel *mInf0=[[ActionInfoModel alloc]init];
        mInf0.mTitle=@"Time Alarm";
        mInf0.mClass=1;
        mInf0.mInfo=@"ic_clock";
        [mData addObject:mInf0];
        mInf0=[[ActionInfoModel alloc]init];
        mInf0.mTitle=@"BP Alarm";
        mInf0.mClass=2;
        mInf0.mInfo=@"ic_set";
        [mData addObject:mInf0];
        mInf0=[[ActionInfoModel alloc]init];
        mInf0.mTitle=@"BT Setting";
        mInf0.mClass=3;
        mInf0.mInfo=@"ic_blue_set";
        [mData addObject:mInf0];
        mInf0=[[ActionInfoModel alloc]init];
        mInf0.mTitle=@"BP Standards";
        mInf0.mClass=4;
        mInf0.mInfo=@"ic_bz";
        [mData addObject:mInf0];
        mInf0=[[ActionInfoModel alloc]init];
        mInf0.mTitle=@"About us";
        mInf0.mClass=5;
        mInf0.mInfo=@"ic_aboat";
        [mData addObject:mInf0];
        mInf0=[[ActionInfoModel alloc]init];
        mInf0.mTitle=@"Help";
        mInf0.mClass=6;
        mInf0.mInfo=@"ic_help";
        [mData addObject:mInf0];
        mInf0=[[ActionInfoModel alloc]init];
        mInf0.mTitle=@"Sharing";
        mInf0.mClass=7;
        mInf0.mInfo=@"ic_fenxiang";
        [mData addObject:mInf0];
        mInf0=[[ActionInfoModel alloc]init];
        mInf0.mTitle=@"Exit";
        mInf0.mClass=8;
        mInf0.mInfo=@"ic_excit";
         [mData addObject:mInf0];
    }
    else
    {
        ActionInfoModel *mInf0=[[ActionInfoModel alloc]init];
        mInf0.mTitle=@"测量提醒";
        mInf0.mClass=1;
        mInf0.mInfo=@"ic_clock";
        [mData addObject:mInf0];
        mInf0=[[ActionInfoModel alloc]init];
        mInf0.mTitle=@"警示设定";
        mInf0.mClass=2;
        mInf0.mInfo=@"ic_set";
        [mData addObject:mInf0];
        mInf0=[[ActionInfoModel alloc]init];
        mInf0.mTitle=@"蓝牙设置";
        mInf0.mClass=3;
        mInf0.mInfo=@"ic_blue_set";
        [mData addObject:mInf0];
        mInf0=[[ActionInfoModel alloc]init];
        mInf0.mTitle=@"血压范围定义";
        mInf0.mClass=4;
        mInf0.mInfo=@"ic_bz";
        [mData addObject:mInf0];
        mInf0=[[ActionInfoModel alloc]init];
        mInf0.mTitle=@"关于我们";
        mInf0.mClass=5;
        mInf0.mInfo=@"ic_aboat";
        [mData addObject:mInf0];
        mInf0=[[ActionInfoModel alloc]init];
        mInf0.mTitle=@"帮助";
        mInf0.mClass=6;
        mInf0.mInfo=@"ic_help";
        [mData addObject:mInf0];
        mInf0=[[ActionInfoModel alloc]init];
        mInf0.mTitle=@"分享";
        mInf0.mClass=7;
        mInf0.mInfo=@"ic_fenxiang";
        [mData addObject:mInf0];
        mInf0=[[ActionInfoModel alloc]init];
        mInf0.mTitle=@"退出";
        mInf0.mClass=8;
        mInf0.mInfo=@"ic_excit";
        [mData addObject:mInf0];
    }
    //[mData addObject:mInf0];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.navigationController!=Nil) {
        [self.navigationController setNavigationBarHidden:YES];
        
    }
     if ([self isEnglish]) {
         mTitle.text=@"More";
     }
    if (!mIsLoad) {
        mIsLoad=YES;
        [self loadData];
    }
}

-(IBAction)btn_excit:(id)sender
{
    alertType=1;
    if ([self isEnglish]) {
        NSString *btnStr = @"ok";
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Exit?"
                              message: nil
                              delegate: self
                              cancelButtonTitle:btnStr
                              otherButtonTitles:@"cancel", nil];
        [alert show];

    }
    else
    {
        NSString *btnStr = @"ok";
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"你确认退出系统吗"
                              message: nil
                              delegate: self
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:@"取消", nil];
        [alert show];
    }
}

-(IBAction)btn_zhuXiao:(id)sender
{
    alertType=2;
    
    NSString *btnStr = @"ok";
     if ([self isEnglish]) {
         UIAlertView *alert = [[UIAlertView alloc]
                               initWithTitle: @"Login Out?"
                               message: nil
                               delegate: self
                               cancelButtonTitle:btnStr
                               otherButtonTitles:@"cancel", nil];
         [alert show];
     }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"你确认注销吗"
                              message: nil
                              delegate: self
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:@"取消", nil];
        [alert show];
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        if (alertType==1) {
             exit(-1);
        }
        else if (alertType==2)
        {
            if (self.parentViewController&&self.parentViewController.navigationController) {
                [self.parentViewController.navigationController popToRootViewControllerAnimated:YES];
            }
            else
            {
                 exit(-1);
            }
        }
        
    }
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
