//
//  OxyListViewController.m
//  ruibaoxueya
//
//  Created by zbf on 14-4-17.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "OxyListViewController.h"
#import "AdInfo.h"
#import "AdInfoManager.h"
#import "OxyAddViewController.h"
#import "DateInfo.h"
#import "OxyCheck.h"
#import "OxyListExViewController.h"


@interface OxyListViewController ()

@end

@implementation OxyListViewController
@synthesize mBtnEDate;
@synthesize mBtnSDate;
@synthesize mmTable;
@synthesize mTitle;
@synthesize mBtnOk;
@synthesize mlDate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        mIsFirst=YES;
        mData=[[NSMutableArray alloc]init];
    }
    return self;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(mData.count>indexPath.row)
    {
        return UITableViewCellEditingStyleDelete;
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
    return 95;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
};

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(mData.count>indexPath.row)
    {
        AdInfo *itemInfo=[mData objectAtIndex:indexPath.row];
        if (itemInfo) {
            int height=[[UIScreen mainScreen] bounds].size.height;
            if (height==480) {
                
                
                OxyAddViewController *mview=[[OxyAddViewController alloc] initWithNibName:@"OxyAddViewController" bundle:Nil];
                mview.mInfo=itemInfo;
                [self openWindow:mview];
            }else
            {
                OxyAddViewController *mview=[[OxyAddViewController alloc] initWithNibName:@"OxyAddViewControllerEx" bundle:Nil];
                mview.mInfo=itemInfo;
                [self openWindow:mview];
            }
        }
    }
}

-(UIImage *)getIcon:(int )type
{
    float scaleFactor = [[UIScreen mainScreen] scale];
    CGSize size = CGSizeMake(48, 48);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef micon=CGBitmapContextCreate(NULL, size.width*scaleFactor, size.height*scaleFactor, 8, size.width*scaleFactor*4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextScaleCTM(micon, scaleFactor, scaleFactor);
    CGContextSetRGBFillColor(micon,0.0, 1.0, 0.0, 1.0);
    CGContextSetRGBStrokeColor(micon, 0.0, 1.0, 0.0, 1.0);
    CGContextSetLineWidth(micon, 1);
    CGContextAddArc(micon, size.width/2, size.height/2, size.width/2, 0, 2*3.1415927, 0);
    CGContextDrawPath(micon, kCGPathStroke);
   
    UIColor *aColor = nil;
    if (type==0) {
        aColor =[UIColor colorWithRed:0.165 green:0.686 blue:0.62 alpha:1];
    }else if (type==1) {
       aColor =[UIColor colorWithRed:0.165 green:0.686 blue:0.62 alpha:1];
    }else if (type==2) {
        aColor =[UIColor colorWithRed:0.165 green:0.686 blue:0.62 alpha:1];
        
    }else if (type==3) {
       aColor =[UIColor colorWithRed:0.165 green:0.686 blue:0.62 alpha:1];
        
    }else if (type==4) {
       aColor =[UIColor colorWithRed:0.165 green:0.686 blue:0.62 alpha:1];
        
    }else if (type==5) {
        aColor =[UIColor colorWithRed:0.165 green:0.686 blue:0.62 alpha:1];
    }else if (type==6) {
       aColor =[UIColor colorWithRed:0.165 green:0.686 blue:0.62 alpha:1];
        
    }else if (type==7) {
        aColor =[UIColor colorWithRed:0.165 green:0.686 blue:0.62 alpha:1];
    }else  {
        aColor =[UIColor colorWithRed:0.165 green:0.686 blue:0.62 alpha:1];
    }
    
    CGContextSetFillColorWithColor(micon, aColor.CGColor);//填充颜色
    CGContextSetLineWidth(micon, 1.0);//线的宽度
    CGContextAddArc(micon, size.width/2, size.height/2, size.width/2, 0, 2*3.1415927, 0); //添加一个圆
    //kCGPathFill填充非零绕数规则,kCGPathEOFill表示用奇偶规则,kCGPathStroke路径,kCGPathFillStroke路径填充,kCGPathEOFillStroke表示描线，不是填充
    CGContextDrawPath(micon, kCGPathFillStroke);
    CGImageRef img=CGBitmapContextCreateImage(micon);
    UIImage *mImg= [UIImage imageWithCGImage:img ];
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(micon);
    CGImageRelease(img);
   
    UIGraphicsBeginImageContext(CGSizeMake(size.width/2, size.height/2));
    [mImg drawInRect:CGRectMake(0, 0, size.width/2, size.height/2)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
    //return mImg;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(mData.count<=indexPath.row)
    {
        return  nil;
    }
    static NSString *activityCellIdentifier = @"activityCellIdentifier";
    /*UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:activityCellIdentifier];
    AdInfo *itemInfo=[mData objectAtIndex:indexPath.row];
    if (itemInfo) {
        cell.textLabel.text=[NSString stringWithFormat:@"%d  %d  %d",itemInfo.mHighSpO2,itemInfo.mMinSpO2,itemInfo.mPulse];
    }
    cell.imageView.image=[self getIcon:0];
     */
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:activityCellIdentifier];
    AdInfo *itemInfo=[mData objectAtIndex:indexPath.row];
    
    CGRect ret=CGRectMake(10, 13, 90, 20);
    UILabel *mLabel=[[UILabel alloc] initWithFrame:ret];
    [ cell.contentView addSubview:mLabel];
    mLabel.text=[NSString stringWithFormat:@"%d/%d",itemInfo.mHighSpO2,itemInfo.mMinSpO2];
    mLabel.textColor=[[UIColor alloc] initWithRed:0.298 green:0.298 blue:0.298 alpha:1.0];
    mLabel.backgroundColor=[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0];

    ret=CGRectMake(175, 13, 130, 20);
    UILabel *mDate=[[UILabel alloc] initWithFrame:ret];
    [ cell.contentView addSubview:mDate];
    mDate.text=itemInfo.mTiWeiName;
    mDate.textColor=[[UIColor alloc] initWithRed:0.478 green:0.710 blue:0.643 alpha:1.0];
    mDate.textAlignment=NSTextAlignmentRight;
    mDate.backgroundColor=[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0];
    ret=CGRectMake(10, 40, 90, 20);
    UILabel *mXinlV=[[UILabel alloc] initWithFrame:ret];
    [ cell.contentView addSubview:mXinlV];
    if ([self isEnglish])
    {
        mXinlV.text=[NSString stringWithFormat:@"HR. %d",itemInfo.mPulse];    }
    else
    {
        mXinlV.text=[NSString stringWithFormat:@"心率 %d",itemInfo.mPulse];
    }
    mXinlV.textColor=[[UIColor alloc] initWithRed:0.298 green:0.298 blue:0.298 alpha:1.0];
     mXinlV.backgroundColor=[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0];
    ret=CGRectMake(110, 40, 90, 20);
    mXinlV=[[UILabel alloc] initWithFrame:ret];
    [ cell.contentView addSubview:mXinlV];
     if ([self isEnglish])
     {
         mXinlV.text=[NSString stringWithFormat:@"MAP %d",itemInfo.mHighSpO2*2/3+itemInfo.mMinSpO2/3];
     }
    else
    {
        mXinlV.text=[NSString stringWithFormat:@"平均压 %d",itemInfo.mHighSpO2*2/3+itemInfo.mMinSpO2/3];
    }
    mXinlV.textColor=[[UIColor alloc] initWithRed:0.298 green:0.298 blue:0.298 alpha:1.0];
 mXinlV.backgroundColor=[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0];
    ret=CGRectMake(210, 40, 105, 20);
    mXinlV=[[UILabel alloc] initWithFrame:ret];
    [ cell.contentView addSubview:mXinlV];
    if ([self isEnglish]) {
        mXinlV.text=[NSString stringWithFormat:@"Per. %d",itemInfo.mHighSpO2-itemInfo.mMinSpO2];    }
    else
    {
        mXinlV.text=[NSString stringWithFormat:@"脉压差 %d",itemInfo.mHighSpO2-itemInfo.mMinSpO2];
    }
    mXinlV.textColor=[[UIColor alloc] initWithRed:0.298 green:0.298 blue:0.298 alpha:1.0];
     mXinlV.backgroundColor=[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0];
    ret=CGRectMake(10, 65, 135, 20);
    UILabel *mtiwei=[[UILabel alloc] initWithFrame:ret];
    [ cell.contentView addSubview:mtiwei];
    mtiwei.text=itemInfo.mInfo;
    mtiwei.textColor=[[UIColor alloc] initWithRed:0.298 green:0.298 blue:0.298 alpha:1.0];
     mtiwei.backgroundColor=[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0];
    mtiwei.font=[UIFont fontWithName:@"Helvetica" size:13];
    ret=CGRectMake(200, 65, 115, 20);
     mtiwei=[[UILabel alloc] initWithFrame:ret];
    [ cell.contentView addSubview:mtiwei];
    mtiwei.text=itemInfo.mTestName;
     mtiwei.textAlignment=NSTextAlignmentRight;
    mtiwei.textColor=[[UIColor alloc] initWithRed:0.298 green:0.298 blue:0.298 alpha:1.0];
     mtiwei.font=[UIFont fontWithName:@"Helvetica" size:14];
    mtiwei.backgroundColor=[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0];
    if (itemInfo.mCreateUserID!=0) {
        ret=CGRectMake(145, 65, 45, 20);
        mtiwei=[[UILabel alloc] initWithFrame:ret];
        [ cell.contentView addSubview:mtiwei];
        mtiwei.text=[NSString stringWithFormat:@"EC:%d",itemInfo.mCreateUserID];
        mtiwei.textAlignment=NSTextAlignmentRight;
        mtiwei.textColor=[[UIColor alloc] initWithRed:0.298 green:0.298 blue:0.298 alpha:1.0];
        mtiwei.font=[UIFont fontWithName:@"Helvetica" size:14];
    }
    
    ret=CGRectMake(2, 94, cell.frame.size.width-4, 1);
    UIImageView *micon=[[UIImageView alloc] initWithFrame:ret];
    [cell.contentView addSubview:micon];
      mtiwei.backgroundColor=[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0];
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
    if(editingStyle==UITableViewCellEditingStyleDelete&&mData.count>indexPath.row&&indexPath.row>=0)
    {
        AdInfo *itemInfo=[mData objectAtIndex:indexPath.row];
        if (itemInfo) {
            
            if ([self isEnglish]) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"Dlete the data?"
                                      message: nil
                                      delegate: self
                                      cancelButtonTitle:@"Ok"
                                      otherButtonTitles:@"Cancel", nil];
                [alert show];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"你确认删除该记录"
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
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        
        if (currItem) {
            AdInfoManager *sql=[[AdInfoManager alloc]init];
            sql.path=[self dataFilePath];
            [sql deleteById:currItem.mId];
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
        

        OxyListExViewController *mview=[[OxyListExViewController alloc] initWithNibName:@"OxyListExViewController" bundle:Nil];
        [self openWindow:mview];
    }else
    {
        OxyListExViewController *mview=[[OxyListExViewController alloc] initWithNibName:@"OxyListExViewControllerEx" bundle:Nil];
        [self openWindow:mview];
    }
}

-(IBAction)btn_add:(id)sender
{
    int height=[[UIScreen mainScreen] bounds].size.height;
    if (height==480) {
        

        OxyAddViewController *mview=[[OxyAddViewController alloc] initWithNibName:@"OxyAddViewController" bundle:Nil];
        [self openWindow:mview];
    }else
    {
        OxyAddViewController *mview=[[OxyAddViewController alloc] initWithNibName:@"OxyAddViewControllerEx" bundle:Nil];
        [self openWindow:mview];
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
    AdInfoManager *sql=[[AdInfoManager alloc]init];
    sql.path=[self dataFilePath];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *uid=[prefs objectForKey:@"id"];
    NSMutableArray* datas=[sql queryInfoByWhere:[NSString stringWithFormat:@" mDate>=%d and mDate<= %d and mUserID=%@ order by mDate desc,mTime desc ",msDate,meDate,uid]];
    if(datas&&datas.count>0)
    {
        [mData addObjectsFromArray:datas];
    }
    [mmTable reloadData];
}

-(void)selectYear:(int)year selectMonth:(int)month selectDay:(int)day
{
    if (mtype==0) {
        msDate=year*10000+month*100+day;
        [mBtnSDate setTitle:[NSString stringWithFormat:@"%d/%d",day,month] forState:UIControlStateNormal];
        
    }
    else
    {
         meDate=year*10000+month*100+day;
        [mBtnEDate setTitle:[NSString stringWithFormat:@"%d/%d",day,month] forState:UIControlStateNormal];

    }
}

-(IBAction)btn_sDate:(id)sender
{
    mtype=0;
    DateSelectViewController *mView=[[DateSelectViewController alloc]initWithNibName:@"DateSelectViewController" bundle:Nil];
    mView.mYear=msDate/10000;
    mView.mMonth=msDate%10000/100;
    mView.mDay=msDate%10000%100;
    
    mView.delegate=self;
    [self openWindow:mView];
}

-(IBAction)btn_eDate:(id)sender
{
     mtype=1;
    DateSelectViewController *mView=[[DateSelectViewController alloc]initWithNibName:@"DateSelectViewController" bundle:Nil];
    mView.mYear=meDate/10000;
    mView.mMonth=meDate%10000/100;
    mView.mDay=meDate%10000%100;
   
    mView.delegate=self;
    [self openWindow:mView];
}

-(IBAction)btn_select:(id)sender
{
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.navigationController!=Nil) {
        [self.navigationController setNavigationBarHidden:YES];
        
    }
    if (!mIsLoad) {
        
        mIsLoad=YES;
        mIsFirst=NO;
        if ([self isEnglish]) {
            mTitle.text=@"History";
            mlDate.text=@"Date";
            mlDate.font=[UIFont fontWithName:@"Helvetica" size:13];
            [mBtnOk setTitle:@"Ok" forState:UIControlStateNormal];
        }
        DateInfo *dayInfo=[[DateInfo alloc]init];
        meDate=dayInfo.mYear*10000+dayInfo.mMonth*100+dayInfo.mDay;
        [mBtnEDate setTitle:[NSString stringWithFormat:@"%d/%d",dayInfo.mDay,dayInfo.mMonth] forState:UIControlStateNormal];
        if (dayInfo.mMonth>1) {
            msDate=meDate-100;
            [mBtnSDate setTitle:[NSString stringWithFormat:@"%d/%d",dayInfo.mDay,dayInfo.mMonth-1] forState:UIControlStateNormal];
        }
        else
        {
            msDate=(dayInfo.mYear-1)*10000+12*100+dayInfo.mDay;
            [mBtnSDate setTitle:[NSString stringWithFormat:@"%d/%d",dayInfo.mDay,12] forState:UIControlStateNormal];
        }
        
    }
    [self loadData];

}

-(void)swithRefreshData
{
    if(!mIsFirst)
    {
         [self loadData];
    }
}













@end
