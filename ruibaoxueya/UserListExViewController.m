//
//  UserListExViewController.m
//  ruibaoxueya
//
//  Created by zbf on 14-5-12.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "UserListExViewController.h"
#import "UserAddViewController.h"
#import "QRHosInfo.h"
#import "SqlHelper.h"
@interface UserListExViewController ()

@end

@implementation UserListExViewController
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

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(mData.count>indexPath.row)
    {
        QRHosInfo *itemInfo=[mData objectAtIndex:indexPath.row];
        if (itemInfo) {
            if ([self strIsEqual:itemInfo.mUserName equal:@"admin"]) {
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
    return 56;
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
        if ([self strIsEqual:itemInfo.mUserName equal:@"admin"]) {
            return;
        }
         if (itemInfo.mDelSate==1) {
             itemInfo.mDelSate=0;
         }
         else
         {
               itemInfo.mDelSate=1;
         }
        [mmTable reloadData];
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
    if (itemInfo.mDelSate==1) {
        
        
            cell.imageView.image=[UIImage imageNamed:@"schecked"];
       
    }
    else
    {
            cell.imageView.image=[UIImage imageNamed:@"scheckno"];
        
    }
    
    //cell.imageView.image=[UIImage imageNamed:@"man_check"];*/
    
     UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:activityCellIdentifier];
     QRHosInfo *itemInfo=[mData objectAtIndex:indexPath.row];
     CGRect ret=CGRectMake(60, 13, cell.frame.size.width-200, 20);
     UILabel *mLabel=[[UILabel alloc] initWithFrame:ret];
     [ cell.contentView addSubview:mLabel];
     mLabel.backgroundColor=[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0];
    ret=CGRectMake(cell.frame.size.width-140, 13, 50, 20);
     UILabel *mDate=[[UILabel alloc] initWithFrame:ret];
     [ cell.contentView addSubview:mDate];
      mDate.backgroundColor=[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0];
    ret=CGRectMake(cell.frame.size.width-80, 13, 70, 20);
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
            mInfo.text=@"Male";
        }
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

     ret=CGRectMake(10, 13, 30, 30);
     UIImageView *micon=[[UIImageView alloc] initWithFrame:ret];
     [ cell.contentView addSubview:micon];
     if (itemInfo.mDelSate==1) {
     
    
         micon.image=[UIImage imageNamed:@"schecked"];
     
     }
     else
     {
     
         micon.image=[UIImage imageNamed:@"scheckno"];
     
     }
     ret=CGRectMake(2, 55, cell.frame.size.width-4, 1);
     micon=[[UIImageView alloc] initWithFrame:ret];
     [cell.contentView addSubview:micon];
     
     micon.image=[UIImage imageNamed:@"userline"];
    
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
    }
    else
    {
        return  @"";
    }

}



-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle==UITableViewCellEditingStyleDelete&&mData.count>indexPath.row)
    {
        QRHosInfo *itemInfo=[mData objectAtIndex:indexPath.row];
        if (itemInfo) {
             if ([self isEnglish])
             {
                 if ([self strIsEqual:itemInfo.mUserName equal:@"visitor"]||[self strIsEqual:itemInfo.mUserName equal:@"Standard"]) {
                     [self showAlertView:@"visitor  or Standard don‘t allow delete"];
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
                
                if ([self strIsEqual:itemInfo.mUserName equal:@"visitor"]||[self strIsEqual:itemInfo.mUserName equal:@"Standard"] ) {
                    [self showAlertView:@"visitor or Standard 不能删除"];
                    [mmTable reloadData];
                    return;
                }
                
                
                if (itemInfo.mSate==1) {
                    [self showAlertView:@"当前用户不能不能删除"];
                    [mmTable reloadData];
                    return;
                }
                
                alertType=0;
                currItem=  itemInfo;
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"你确认删除该用户"
                                      message: nil
                                      delegate: self
                                      cancelButtonTitle:@"确定"
                                      otherButtonTitles:@"取消", nil];
                [alert show];
            }
           
        }
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0&&alertType==0) {
        
        if (currItem) {
            SqlHelper *sql=[[SqlHelper alloc]init];
            sql.path=[self dataFilePath];
            [sql deleteById:currItem.mID];
            [mData removeObject:currItem];
            [mmTable reloadData];
            
        }
    }
    else  if (buttonIndex==0&&alertType==1) {
        SqlHelper *sql=[[SqlHelper alloc]init];
        sql.path=[self dataFilePath];
        for (int i=0; i<mData.count; i++) {
            QRHosInfo *itemInfo=[mData objectAtIndex:i];
            if (itemInfo.mDelSate==1&&itemInfo.mSate==0) {
                
                [sql deleteById:itemInfo.mID];
                [mData removeObject:itemInfo];
                i=i-1;
            }
            
        }
        [mmTable reloadData];    }
    
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
    alertType=1;
    BOOL isSelect=false;
    for (int i=0; i<mData.count; i++) {
        QRHosInfo *itemInfo=[mData objectAtIndex:i];
        if (itemInfo.mDelSate==1&&itemInfo.mSate==0) {
            isSelect=true;
            break;
        }
    }
    
    if(isSelect)
    {
        if ([self isEnglish]) {
            
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"Dlete the user name & data?"
                                  message: nil
                                  delegate: self
                                  cancelButtonTitle:@"Ok"
                                  otherButtonTitles:@"Cancel", nil];
            [alert show];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"你确认删除选中用户"
                                  message: nil
                                  delegate: self
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:@"取消", nil];
            [alert show];
            
        }
    }
    else
    {
        if ([self isEnglish]) {
            [self showAlertView:@"No Select User Or User Can't Delete "];
        }
        else
        {
            [self showAlertView:@"没有选中用户或者选中用户不能删除"];
        }
    }

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
        
         for (int i=0; i<mData.count; i++)
         {
              QRHosInfo *minf0=[mData objectAtIndex:i];
             if ([self strIsEqual:minf0.mUserName equal:@"visitor"] ) {
                 [mData removeObject:minf0];
                 break;
             }
         }
    }
    if(mData&&mData.count>0)
    {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *mid=[prefs objectForKey:@"id"];
        int uid=[mid intValue];
        for (int j=0; j<mData.count; j++) {
            QRHosInfo *minf0=[mData objectAtIndex:j];
            if (minf0.mID==uid) {
                minf0.mSate=1;
                break;
            }
        }
        
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
