//
//  UserListViewController.m
//  ruibaoxueya
//
//  Created by zbf on 14-4-16.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "UserListViewController.h"
#import "UserAddViewController.h"
#import "QRHosInfo.h"
#import "SqlHelper.h"
#import "UserListExViewController.h"

@interface UserListViewController ()

@end

@implementation UserListViewController
@synthesize mmTable;
@synthesize mTitle;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
         mData=[[NSMutableArray alloc]init];
    }
    return self;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(mData.count>indexPath.row)
    {
        QRHosInfo *itemInfo=[mData objectAtIndex:indexPath.row];
        if (itemInfo) {
            if ([self strIsEqual:itemInfo.mUserName equal:@"visitor"]) {
                return UITableViewCellEditingStyleNone;
            }
            
            if (itemInfo.mSate==1) {
                
                return UITableViewCellEditingStyleNone;
            }
            
            return UITableViewCellEditingStyleDelete;
        }
    
    }
    return UITableViewCellEditingStyleNone;  
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
    return 66;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
};

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(mData.count<=indexPath.row)
    {
        return;
    }
    QRHosInfo *itemInfo=[mData objectAtIndex:indexPath.row];
    if (itemInfo) {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:itemInfo.mUserName forKey:@"name"];
        [prefs setObject:[NSString stringWithFormat:@"%d",itemInfo.mID] forKey:@"id"];
        [prefs synchronize];
        if ([self strIsEqual:itemInfo.mUserName equal:@"visitor"]) {
            [self loadData];
            return;
        }
        if(lastdate)
        {
            DateInfo *now=[[DateInfo alloc]init];
            [now initNow];
            int time=now.mSecond-lastdate.mSecond;
            if(time<0)
            {
                time=time+60;
            }
            if(time<3)
            {
                int height=[[UIScreen mainScreen] bounds].size.height;
                if (height==480) {
                    
                    UserAddViewController* showView=[[UserAddViewController alloc]initWithNibName:@"UserAddViewController" bundle:Nil];
                    showView.mInfo=itemInfo;
                    [self openWindow:showView];
                    
                }
                else
                {
                    UserAddViewController* showView=[[UserAddViewController alloc]initWithNibName:@"UserAddViewControllerEx" bundle:Nil];
                    showView.mInfo=itemInfo;
                    [self openWindow:showView];
                }
            }
            else
            {
                lastdate=[[DateInfo alloc]init];
                [lastdate initNow];
            }
        }
        else
        {
            lastdate=[[DateInfo alloc]init];
            [lastdate initNow];
        }
        [self loadData];
            
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if(mData.count<=indexPath.row)
    {
        return  nil;
    }
    static NSString *activityCellIdentifier = @"activityCellIdentifier";
     /*UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:activityCellIdentifier];
	
    if(cell == nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:activityCellIdentifier];
    }
    QRHosInfo *itemInfo=[mData objectAtIndex:indexPath.row];
   cell.textLabel.text=itemInfo.mUserName;
    if (itemInfo.mUserSex==1) {
        //cell.detailTextLabel.text=@"女";
         cell.detailTextLabel.text=[NSString stringWithFormat:@"%@   %d岁",@"女",itemInfo.mUserAge];
    }
    else
    {
        cell.detailTextLabel.text=[NSString stringWithFormat:@"%@   %d岁",@"男",itemInfo.mUserAge];
    }
    if (itemInfo.mSate==1) {
        
        if (itemInfo.mUserSex==1) {
             cell.imageView.image=[UIImage imageNamed:@"woman_check"];
        }
        else
        {
             cell.imageView.image=[UIImage imageNamed:@"man_check"];
        }
    }
    else
    {
        if (itemInfo.mUserSex==1) {
             cell.imageView.image=[UIImage imageNamed:@"woman_uncheck"];
        }
        else
        {
            cell.imageView.image=[UIImage imageNamed:@"man_uncheck"];
        }
    }*/
    
    //cell.imageView.image=[UIImage imageNamed:@"man_check"];
    
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:activityCellIdentifier];
    QRHosInfo *itemInfo=[mData objectAtIndex:indexPath.row];
    CGRect ret=CGRectMake(60, 23, cell.frame.size.width-200, 20);
    UILabel *mLabel=[[UILabel alloc] initWithFrame:ret];
    [ cell.contentView addSubview:mLabel];
    mLabel.backgroundColor=[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0];
    ret=CGRectMake(cell.frame.size.width-140, 23, 50, 20);
    UILabel *mDate=[[UILabel alloc] initWithFrame:ret];
    [ cell.contentView addSubview:mDate];
      mDate.backgroundColor=[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0];
    ret=CGRectMake(cell.frame.size.width-80, 23, 70, 20);
    UILabel *mInfo=[[UILabel alloc] initWithFrame:ret];
    [ cell.contentView addSubview:mInfo];
    mInfo.backgroundColor=[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0];
    
    mLabel.text=itemInfo.mUserName;
    if (itemInfo.mUserSex==1) {
        if ([self isEnglish])
        {
            mInfo.text=@"Female";        }
        else
        {
            mInfo.text=@"女";
        }
    }
    else
    {
        if ([self isEnglish])
        {
            mInfo.text=@"Male";        }
        else
        {
            mInfo.text=@"男";
        }
    }
    if ([self isEnglish])
    {
         mDate.text=[NSString stringWithFormat:@"%dY",itemInfo.mUserAge];
    }
    else
    {
        mDate.text=[NSString stringWithFormat:@"%d岁",itemInfo.mUserAge];
    }
    ret=CGRectMake(10, 24, 22, 22);
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
    ret=CGRectMake(2, 65, cell.frame.size.width-4, 1);
    micon=[[UIImageView alloc] initWithFrame:ret];
    [cell.contentView addSubview:micon];
    
    micon.image=[UIImage imageNamed:@"userline"];
    
    ret=CGRectMake(cell.frame.size.width-20, 28, 8, 15);
    micon=[[UIImageView alloc] initWithFrame:ret];
    [cell.contentView addSubview:micon];
    
    micon.image=[UIImage imageNamed:@"btn_right"];
    cell.backgroundColor=[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0];
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
    if(editingStyle==UITableViewCellEditingStyleDelete)
    {
        if(mData.count>indexPath.row)
        {
            QRHosInfo *itemInfo=[mData objectAtIndex:indexPath.row];
            if (itemInfo) {
                if ([self isEnglish])
                {
                    if ([self strIsEqual:itemInfo.mUserName equal:@"visitor"]||[self strIsEqual:itemInfo.mUserName equal:@"Standard"]) {
                        [self showAlertView:@"visitor or Standard don‘t allow delete"];
                        [mmTable reloadData];
                        return;
                    }
                    
                    if (itemInfo.mSate==1) {
                        [self showAlertView:@"current user don‘t allow delete"];
                        [mmTable reloadData];
                        return;
                    }
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle: @"Dlete the user name & data?"
                                          message: nil
                                          delegate: self
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:@"Cancel", nil];
                    [alert show];
                    currItem=  itemInfo;
                }
                else
                {
                    if ([self strIsEqual:itemInfo.mUserName equal:@"visitor"]||[self strIsEqual:itemInfo.mUserName equal:@"Standard"]) {
                        [self showAlertView:@"visitor or Standard 不能删除"];
                        [mmTable reloadData];
                        return;
                    }
                    
                    if (itemInfo.mSate==1) {
                        [self showAlertView:@"当前用户不能不能删除"];
                        [mmTable reloadData];
                        return;
                    }
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle: @"你确认删除该用户"
                                          message: nil
                                          delegate: self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:@"取消", nil];
                    [alert show];
                    currItem=  itemInfo;
                }
            }
           
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        
        if (currItem) {
            SqlHelper *sql=[[SqlHelper alloc]init];
            sql.path=[self dataFilePath];
            [sql deleteById:currItem.mID];
            [mData removeObject:currItem];
            [mmTable reloadData];
           
        }
    }
    else
    {
        [mmTable reloadData];
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     if (indexPath.row%2==1) {
     [cell setBackgroundColor:[UIColor yellowColor]];
     }else {
     [cell setBackgroundColor:[UIColor lightGrayColor]];
     }
     // [cell setSelected:YES animated:YES];
     */
}

-(IBAction)btn_del:(id)sender
{
     int height=[[UIScreen mainScreen] bounds].size.height;
    if (height==480) {
        UserListExViewController *mview=[[UserListExViewController alloc]initWithNibName:@"UserListExViewController" bundle:Nil];
        [self openWindow:mview];
    }
    else
    {
        UserListExViewController *mview=[[UserListExViewController alloc]initWithNibName:@"UserListExViewControllerEx" bundle:Nil];
        [self openWindow:mview];
    }
   
}

-(IBAction)btn_add:(id)sender
{
    int height=[[UIScreen mainScreen] bounds].size.height;
    if (height==480) {
        
        UserAddViewController *mview=[[UserAddViewController alloc]initWithNibName:@"UserAddViewController" bundle:Nil];
        [self openWindow:mview];
    }
    else
    {
        UserAddViewController *mview=[[UserAddViewController alloc]initWithNibName:@"UserAddViewControllerEx" bundle:Nil];
        [self openWindow:mview];    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     mmTable.separatorStyle = UITableViewCellSeparatorStyleNone;
     mmTable.allowsSelection=YES;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    // Do any additional setup after loading the view from its nib.
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
        user.mSate=1;
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.navigationController!=Nil) {
        [self.navigationController setNavigationBarHidden:YES];
        
    }
    if ([self isEnglish]) {
        mTitle.text=@"User";
    }
    //if (!mIsLoad) {
        //mIsLoad=YES;
        [self loadData];
    //}
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
