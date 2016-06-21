//
//  SeachDevViewController.m
//  ruibaoxueya
//
//  Created by zbf on 14-5-4.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "SeachDevViewController.h"
#import "ActionInfoModel.h"
#import "DevManager.h"
#import "QRHosInfo.h"
@interface SeachDevViewController ()

@end

@implementation SeachDevViewController
@synthesize mmTable;
@synthesize mTitle;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        

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
    return 50;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
};

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(mData.count>indexPath.row)
    {
        QRHosInfo *itemInfo=[mData objectAtIndex:indexPath.row];
        if(!itemInfo)
        {
            return;
        }
        
        if (itemInfo.mUserSex==0) {
            for (int i=0; i<mData.count; i++) {
                itemInfo=[mData objectAtIndex:i];
                if (i==indexPath.row) {
                    itemInfo.mUserSex=1;
                    
                    DevManager *sql=[[DevManager alloc]init];
                    sql.path=[self dataFilePath];
                    [sql update:itemInfo];
                    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                    [prefs setObject:itemInfo.mUserName forKey:@"bluename"];
                    [prefs synchronize];
                }
                else
                {
                    itemInfo.mUserSex=0;
                    DevManager *sql=[[DevManager alloc]init];
                    sql.path=[self dataFilePath];
                    [sql update:itemInfo];
                }
            }
            [mmTable reloadData];
            NSString *btnStr = @"ok";
            if ([self isEnglish]) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"Switch BT ，Next Time is Working,Login Out?"
                                      message: nil
                                      delegate: self
                                      cancelButtonTitle:btnStr
                                      otherButtonTitles:@"cancel", nil];
                [alert show];
            }
            else
            {
                btnStr = @"确定";
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"设备切换，需要下次登录才能有效,你确认注销退出吗"
                                      message: nil
                                      delegate: self
                                      cancelButtonTitle:btnStr
                                      otherButtonTitles:@"取消", nil];
                [alert show];
            }
           
        }
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(mData.count>indexPath.row)
    {
         NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *devName=[prefs objectForKey:@"bluename"];
        static NSString *activityCellIdentifier = @"activityCellIdentifier";
        UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:activityCellIdentifier];
        QRHosInfo *itemInfo=[mData objectAtIndex:indexPath.row];
        CGRect ret=CGRectMake(50, 13, cell.frame.size.width-52, 25);
        UILabel *mLabel=[[UILabel alloc] initWithFrame:ret];
        [ cell.contentView addSubview:mLabel];
        mLabel.backgroundColor=[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0];
        mLabel.text=itemInfo.mUserName;
        ret=CGRectMake(10, 10, 30, 30);
        UIImageView *micon=[[UIImageView alloc] initWithFrame:ret];
        [ cell.contentView addSubview:micon];
        if (itemInfo.mUserSex==1) {
            micon.image=[UIImage imageNamed:@"schecked"];
        }
        else
        {
            micon.image=[UIImage imageNamed:@"scheckno"];
        }
        return cell;
    }
    else
    {
        return nil;
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
         exit(-1);
    }
}

-(IBAction)btnbak:(id)sender
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
        // mmTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    DevManager *sql=[[DevManager alloc]init];
    sql.path=[self dataFilePath];
    [ sql createDb];
    mData= [sql queryInfo];
    if (mData==nil||mData.count==0) {
        if ([self isEnglish]) {
            [self showAlertView:@"BT Searching No Find "];
        }
        else
        {
            [self showAlertView:@"没有搜索到蓝牙设备"];
        }
    }
    else
    {
        for (int i=0;i<mData.count; i++) {
            QRHosInfo *itemInfo=[mData objectAtIndex:i];
            if (!itemInfo||!itemInfo.mUserName||itemInfo.mUserName.length<2) {
                [mData removeObjectAtIndex:i];
                i=i-1;
            }
        }
    }
    
    if ([self isEnglish]) {
        mTitle.text=@"BT Setting";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
