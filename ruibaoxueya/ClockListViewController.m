//
//  ClockListViewController.m
//  ruibaoxueya
//
//  Created by zbf on 14-7-7.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "ClockListViewController.h"
#import "clockManager.h"
#import "clockInfo.h"
#import "ColckViewController.h"
#import "AlertHelper.h"

@interface ClockListViewController ()

@end

@implementation ClockListViewController
@synthesize mTitle;
@synthesize mmTable;
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
    return 65;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
    
};

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(mData.count>indexPath.row)
    {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(mData.count<=indexPath.row)
    {
        return  ;
    }
    clockInfo *itemInfo=[mData objectAtIndex:indexPath.row];
    ColckViewController  *mview=[[ColckViewController alloc]initWithNibName:@"ColckViewController" bundle:nil];
    mview.mType=itemInfo.mID;
    [self openWindow:mview];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(mData.count<=indexPath.row)
    {
        return  nil;
    }
    static NSString *activityCellIdentifier = @"activityCellIdentifier";
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:activityCellIdentifier];
    clockInfo *itemInfo=[mData objectAtIndex:indexPath.row];
    CGRect ret=CGRectMake(50, 5, 100, 25);
    UILabel *mLabel=[[UILabel alloc] initWithFrame:ret];
    [ cell.contentView addSubview:mLabel];
     mLabel.backgroundColor=[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0];
    mLabel.text=itemInfo.mUserName;
    ret=CGRectMake(50, 35, 180, 20);
    
    mLabel=[[UILabel alloc] initWithFrame:ret];
    [ cell.contentView addSubview:mLabel];
     mLabel.text=itemInfo.mUserPwd;
     mLabel.backgroundColor=[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0];
    ret=CGRectMake(10, 15, 30, 30);
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

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(mData.count>indexPath.row)
    {
        if ([self isEnglish])
        {
            return @"Del";
        }
        return @"删除";
    }else
    {
        return @"";
    }
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle==UITableViewCellEditingStyleDelete&&mData.count>indexPath.row)
    {
        clockInfo *itemInfo=[mData objectAtIndex:indexPath.row];
        if (itemInfo) {
            if ([self isEnglish])
            {
                
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"Dlete the Data?"
                                      message: nil
                                      delegate: self
                                      cancelButtonTitle:@"ok"
                                      otherButtonTitles:@"Cancel", nil];
                [alert show];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"确认删除数据?"
                                      message: nil
                                      delegate: self
                                      cancelButtonTitle:@"确定"
                                      otherButtonTitles:@"取消", nil];
                [alert show];
            }
            currItem=  itemInfo;
            
        }
    }
}
-(void)deleteClock:(int )day withType: (int)mType
{
    [AlertHelper deleteLocalNotification:[NSString stringWithFormat:@"clock_%d_alert_day_%d",mType,day]];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        
        if (currItem) {
            clockManager *sql=[[clockManager alloc]init];
            sql.path=[self dataFilePath];
            [sql deleteById:currItem.mID];
            [mData removeObject:currItem];
            [mmTable reloadData];
            [self deleteClock:7  withType:currItem.mID];
            [self deleteClock:6 withType:currItem.mID];
            [self deleteClock:5 withType:currItem.mID];
            [self deleteClock:4 withType:currItem.mID];
            [self deleteClock:3 withType:currItem.mID];
            [self deleteClock:2 withType:currItem.mID];
            [self deleteClock:1 withType:currItem.mID];
        }
    }
    else
    {
        [mmTable reloadData];
    }
    
}
-(IBAction)btnbak:(id)sender
{
    
    
    [self closeMe];
}

-(IBAction)btnAdd:(id)sender
{
    clockManager *sql=[[clockManager alloc]init];
    sql.path=[self dataFilePath];
    [ sql createDb];

    ColckViewController  *mview=[[ColckViewController alloc]initWithNibName:@"ColckViewController" bundle:nil];
    mview.mType=[sql getMaxID];
    [self openWindow:mview];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    if ([self isEnglish]) {
        mTitle.text=@"Time Alarm";
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    clockManager *sql=[[clockManager alloc]init];
    sql.path=[self dataFilePath];
    [sql createDb];
    mData= [sql queryInfo];
    [mmTable reloadData];
    
}



@end
