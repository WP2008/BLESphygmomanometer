//
//  OxyListExViewController.m
//  ruibaoxueya
//
//  Created by zbf on 14-5-12.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "OxyListExViewController.h"
#import "AdInfo.h"
#import "AdInfoManager.h"
#import "OxyAddViewController.h"
#import "DateInfo.h"
#import "OxyCheck.h"

@interface OxyListExViewController ()

@end

@implementation OxyListExViewController
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
            if (itemInfo.mDayIndex==0) {
                itemInfo.mDayIndex=1;
            }else
            {
                itemInfo.mDayIndex=0;
            }
            [mmTable reloadData];
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
    
    UIColor *aColor = [UIColor colorWithRed:0.0 green:1.0 blue:0 alpha:1];
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
    
    CGRect ret=CGRectMake(45, 13, 80, 20);
    UILabel *mLabel=[[UILabel alloc] initWithFrame:ret];
    [ cell.contentView addSubview:mLabel];
    mLabel.text=[NSString stringWithFormat:@"%d/%d",itemInfo.mHighSpO2,itemInfo.mMinSpO2];
     mLabel.backgroundColor=[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0];
    ret=CGRectMake(10, 10, 24, 24);
    UIImageView *micon=[[UIImageView alloc] initWithFrame:ret];
    [ cell.contentView addSubview:micon];
   
    if (itemInfo.mDayIndex==1) {
        
        micon.image=[UIImage imageNamed:@"schecked"];
    }
    else
    {
          micon.image=[UIImage imageNamed:@"scheckno"];
    }
    ret=CGRectMake(185, 13, 110, 20);
    UILabel *mDate=[[UILabel alloc] initWithFrame:ret];
    [ cell.contentView addSubview:mDate];
    mDate.text=itemInfo.mTiWeiName;
    mDate.textColor=[[UIColor alloc] initWithRed:0.478 green:0.710 blue:0.643 alpha:1.0];
    mDate.textAlignment=NSTextAlignmentRight;
    mDate.backgroundColor=[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0];
    ret=CGRectMake(40, 40, 80, 20);
    UILabel *mXinlV=[[UILabel alloc] initWithFrame:ret];
    [ cell.contentView addSubview:mXinlV];
    if ([self isEnglish])
    {
        mXinlV.text=[NSString stringWithFormat:@"HR %d",itemInfo.mPulse];    }
    else
    {
        mXinlV.text=[NSString stringWithFormat:@"心率 %d",itemInfo.mPulse];
    }
    mXinlV.textColor=[[UIColor alloc] initWithRed:0.298 green:0.298 blue:0.298 alpha:1.0];
    mXinlV.backgroundColor=[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0];
    ret=CGRectMake(125, 40, 90, 20);
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
    ret=CGRectMake(215, 40, 100, 20);
    mXinlV=[[UILabel alloc] initWithFrame:ret];
    [ cell.contentView addSubview:mXinlV];
    if ([self isEnglish]) {
        mXinlV.text=[NSString stringWithFormat:@"Per. %d",itemInfo.mHighSpO2-itemInfo.mMinSpO2];    }
    else
    {
        mXinlV.text=[NSString stringWithFormat:@"脉压差  %d",itemInfo.mHighSpO2-itemInfo.mMinSpO2];
    }
    mXinlV.textColor=[[UIColor alloc] initWithRed:0.298 green:0.298 blue:0.298 alpha:1.0];
      mXinlV.backgroundColor=[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0];
    ret=CGRectMake(40, 65, 130, 20);
    UILabel *mtiwei=[[UILabel alloc] initWithFrame:ret];
    [ cell.contentView addSubview:mtiwei];
    mtiwei.text=itemInfo.mInfo;
    mtiwei.textColor=[[UIColor alloc] initWithRed:0.298 green:0.298 blue:0.298 alpha:1.0];
     mtiwei.backgroundColor=[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0];
    mtiwei.font=[UIFont fontWithName:@"Helvetica" size:12];
    ret=CGRectMake(225, 65, 90, 20);
    mtiwei=[[UILabel alloc] initWithFrame:ret];
    [ cell.contentView addSubview:mtiwei];
    mtiwei.text=itemInfo.mTestName;
    mtiwei.textAlignment=NSTextAlignmentRight;
    mtiwei.textColor=[[UIColor alloc] initWithRed:0.298 green:0.298 blue:0.298 alpha:1.0];
    mtiwei.backgroundColor=[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0];
    mtiwei.font=[UIFont fontWithName:@"Helvetica" size:14];
    if (itemInfo.mCreateUserID!=0) {
        ret=CGRectMake(175, 65, 45, 20);
        mtiwei=[[UILabel alloc] initWithFrame:ret];
        [ cell.contentView addSubview:mtiwei];
        mtiwei.text=[NSString stringWithFormat:@"EC:%d",itemInfo.mCreateUserID];
        mtiwei.textAlignment=NSTextAlignmentRight;
        mtiwei.textColor=[[UIColor alloc] initWithRed:0.298 green:0.298 blue:0.298 alpha:1.0];
        mtiwei.font=[UIFont fontWithName:@"Helvetica" size:14];
    }

    ret=CGRectMake(2, 94, cell.frame.size.width-4, 1);
    micon=[[UIImageView alloc] initWithFrame:ret];
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
            
            alertType=0;
            currItem=  itemInfo;
            if ([self isEnglish]) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"Dlete the select data?"
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
            
            
            
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0&&alertType==0) {
        
        if (currItem) {
            AdInfoManager *sql=[[AdInfoManager alloc]init];
            sql.path=[self dataFilePath];
            [sql deleteById:currItem.mId];
            [mData removeObject:currItem];
            [mmTable reloadData];
            
        }
    }
    else if(buttonIndex==0&&alertType==1)
    {
        AdInfoManager *sql=[[AdInfoManager alloc]init];
        sql.path=[self dataFilePath];
        for (int i=0; i<mData.count; i++) {
            AdInfo *itemInfo=[mData objectAtIndex:i];
            if (itemInfo.mDayIndex==1) {
                
                [sql deleteById:itemInfo.mId];
                [mData removeObject:itemInfo];
                i=i-1;
            }
            
        }
        [mmTable reloadData];
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
    alertType=1;
    
        BOOL isSelect=false;
        for (int i=0; i<mData.count; i++) {
            AdInfo *itemInfo=[mData objectAtIndex:i];
            if (itemInfo.mDayIndex==1) {
                isSelect=true;
                break;
            }
        }
        if(isSelect)
        {
            if ([self isEnglish]) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"Dlete the select data?"
                                      message: nil
                                      delegate: self
                                      cancelButtonTitle:@"Ok"
                                      otherButtonTitles:@"Cancel", nil];
                [alert show];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"你确认删除选中记录"
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
                [self showAlertView:@"No Delete Data "];
            }
            else
            {
                [self showAlertView:@"没有删除的数据"];
            }
        }
    

   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mmTable.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    NSMutableArray* datas=[sql queryInfoByWhere:[NSString stringWithFormat:@" mDate>=%d and mDate<= %d and mUserID=%@  order by mDate desc,mTime desc ",msDate,meDate,uid]];
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
        if ([self isEnglish]) {
            mTitle.text=@"History";
            mlDate.text=@"Date";
            mlDate.font=[UIFont fontWithName:@"Helvetica" size:13];
            [mBtnOk setTitle:@"Ok" forState:UIControlStateNormal];
        }
        mIsLoad=YES;
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
