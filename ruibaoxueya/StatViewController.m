//
//  StatViewController.m
//  ruibaoxueya
//
//  Created by zbf on 14-4-17.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "StatViewController.h"
#import "OxyStat.h"
#import "AdInfoManager.h"
#import "DateInfo.h"
#import "XinLvStat.h"
#import "StatInfo.h"
#import "OxyCheck.h"
#import "QRHosInfo.h"
#import "WorkTimeManager.h"
@interface StatViewController ()

@end

@implementation StatViewController
@synthesize mDate;
@synthesize mStatOxy;
@synthesize mStatXinLv;
@synthesize mTitleBg;
@synthesize mTypeBg;
@synthesize mSelect0;
@synthesize mSelect1;
@synthesize mStatWeb;
@synthesize mScollView;
@synthesize mLeft;
@synthesize mRight;
@synthesize meDate;
@synthesize mlShouAndShu;
@synthesize mXinLv;
@synthesize btn_1d;
@synthesize btn_1m;
@synthesize btn_1w;
@synthesize btn_1y;
@synthesize btn_24h;
@synthesize btn_6m;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        mData=[[NSMutableArray alloc]init];
        self.mSwithRefreshDelegate=self;
        mIsFirst=YES;
        //CGRect rect=CGRectMake(0, 100, 320, 310);
       // mScollView.frame=rect;
        int sh=[[UIScreen mainScreen] bounds].size.height;
        int width=[[UIScreen mainScreen] bounds].size.width;
        //int height=mScollView.frame.size.height;
        if(sh>480)
        {
            CGSize size=CGSizeMake( width*2,  380);
            mScollView.contentSize=size;
        }
        else
        {
            CGSize size=CGSizeMake( width*2,  300);
            mScollView.contentSize=size;
        }
        
        mScollView.pagingEnabled=YES;
        if(sh>480)
        {
            mScollView.frame= CGRectMake(0, 110, width, 380);
           // mStatOxy.frame= CGRectMake(15, 44, 290, 188);
           // mStatXinLv.frame= CGRectMake(15, 281, 290, 90);
        }
        else
        {
             mScollView.frame= CGRectMake(0, 93, width, 300);
        }
        mLeft.hidden=YES;
        mScollView.delegate=self;
        sTime=0;
        eTime=24*10000;
        mTimeData=[[NSMutableArray alloc]init];
        
        WorkTimeManager *sql=[[WorkTimeManager alloc]init];
         sql.path=[self dataFilePath];
        [sql createDb];
       
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *uid=[prefs objectForKey:@"id"];
        NSMutableArray *times=[sql queryInfoByName:uid];
        if(times&&times.count>0)
        {
            [ mTimeData addObjectsFromArray:times];
        }
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(mScollView.contentOffset.x>300)
    {
        mLeft.hidden=NO;
        mRight.hidden=YES;
        // UIImage *img=mSelect0.image;
        mSelect0.image=[UIImage imageNamed:@"unselectedflag"];
        mSelect1.image=[UIImage imageNamed:@"selectedflag"];;
    }
    else
    {
         mLeft.hidden=YES;
        mRight.hidden=NO;
        mSelect1.image=[UIImage imageNamed:@"unselectedflag"];
        mSelect0.image=[UIImage imageNamed:@"selectedflag"];;

    }
}
-(IBAction)btn_24h:(id)sender
{
    dayType=0;
    mTitleBg.image=[UIImage imageNamed:@"btn_item_24h"];
    [self stat];
}

-(IBAction)btn_1d:(id)sender
{
    dayType=1;
    mTitleBg.image=[UIImage imageNamed:@"btn_item_1d"];
    [self stat];
}

-(IBAction)btn_1w:(id)sender
{
     dayType=2;
    mTitleBg.image=[UIImage imageNamed:@"btn_item_1w"];
    [self stat];
}

-(IBAction)btn_1m:(id)sender
{
    dayType=3;
    mTitleBg.image=[UIImage imageNamed:@"btn_item_1m"];
    [self stat];
}

-(IBAction)btn_6m:(id)sender
{
    dayType=4;
    mTitleBg.image=[UIImage imageNamed:@"btn_item_6m"];
    [self stat];
}

-(IBAction)btn_1y:(id)sender
{
    dayType=5;
    mTitleBg.image=[UIImage imageNamed:@"btn_item_1y"];
    [self stat];
}

-(IBAction)btn_all:(id)sender
{
    timeType=0;
    mTypeBg.image=[UIImage imageNamed:@"item_all"];
    [self stat: sDate withEndDate:eDate];
}

-(IBAction)btn_am:(id)sender
{
    timeType=1;
     mTypeBg.image=[UIImage imageNamed:@"item_am"];
    [self stat: sDate withEndDate:eDate];
}

-(IBAction)btn_pm:(id)sender
{
    timeType=2;
    mTypeBg.image=[UIImage imageNamed:@"item_pm"];
    [self stat: sDate withEndDate:eDate];
}

-(void)loadStat:(NSMutableArray*)sDatas
{
    NSMutableString *sb=[[NSMutableString alloc]init];
    if ([self isEnglish]) {
        [sb appendString:@"<html><head><title>Stat</title></head><body><div style=\"text-align:center;background-color:White;\"><span style=\"font-size:12px; color:#4da58e;\">Sys.</span></div>"];    }
    else
    {
        [sb appendString:@"<html><head><title>基本资料</title></head><body><div style=\"text-align:center;background-color:White;\"><span style=\"font-size:12px; color:#4da58e;\">收缩压</span></div>"];
    }
    
    
    [sb appendString:@"<div style=\"text-align:center;background-color:Gray;width:290px;\"><table cellspacing=\"1\" cellpadding=\"0\"  border=\"0\" width=\"290px\" > "];
    OxyCheck *check=[[OxyCheck alloc]init];
    
    StatInfo *sinfo=[sDatas objectAtIndex:0];
    
    [sb appendFormat:@" <tr style=\"text-align:center;\"><td  style=\"text-align:center;background-color:White;\">%@</td><td  style=\"text-align:center;background-color:White;\">%@</td><td  style=\"text-align:center;background-color:White;\">%@</td><td  style=\"text-align:center;background-color:White;\">%@</td><td  style=\"text-align:center;background-color:White;\">%@</td></tr>",[check getHighInfo:0],[check getHighInfo:1],[check getHighInfo:2],[check getHighInfo:3],[check getHighInfo:4]];
    
   [sb appendFormat:@" <tr><td style=\"text-align:center;background-color:White;\">%d</td><td style=\"text-align:center;background-color:White;\">%d</td><td style=\"text-align:center;background-color:White;\">%d</td><td style=\"text-align:center;background-color:White;\">%d</td><td style=\"text-align:center;background-color:White;\">%d</td></tr>",sinfo.mType1Count,sinfo.mType2Count,sinfo.mType3Count,sinfo.mType4Count,sinfo.mType5Count];
    
    [sb appendFormat:@" <tr><td style=\"text-align:center;background-color:White;\">%d%@</td><td style=\"text-align:center;background-color:White;\">%d%@</td><td style=\"text-align:center;background-color:White;\">%d %@ </td><td style=\"text-align:center;background-color:White;\">%d%@</td><td style=\"text-align:center;background-color:White;\">%d%@</td></tr>",sinfo.mType1percent,@"%",sinfo.mType2percent,@"%",sinfo.mType3percent,@"%",sinfo.mType4percent,@"%",sinfo.mType5percent,@"%"];
     if ([self isEnglish]) {
         [sb appendString:@"</table></div></br><div style=\"text-align:center;background-color:White;\"><span style=\"font-size:12px; color:#4da58e;\">Dia.</span></div>"];
     }
    else
    {
        [sb appendString:@"</table></div></br><div style=\"text-align:center;background-color:White;\"><span style=\"font-size:12px; color:#4da58e;\">舒张压</span></div>"];
    }
    
    [sb appendString:@"<div style=\"text-align:center;background-color:Gray;width:290px;\"><table cellspacing=\"1\" cellpadding=\"0\"  border=\"0\" width=\"290px\" > "];

    
    sinfo=[sDatas objectAtIndex:1];
    
    [sb appendFormat:@" <tr style=\"text-align:center;\"><td style=\"text-align:center;background-color:White;\">%@</td><td  style=\"text-align:center;background-color:White;\">%@</td><td style=\"text-align:center;background-color:White;\">%@</td><td style=\"text-align:center;background-color:White;\">%@</td><td style=\"text-align:center;background-color:White;\">%@</td></tr>",[check getMinInfo:0],[check getMinInfo:1],[check getMinInfo:2],[check getMinInfo:3],[check getMinInfo:4]];
    
    [sb appendFormat:@" <tr><td style=\"text-align:center;background-color:White;\">%d</td><td style=\"text-align:center;background-color:White;\">%d</td><td style=\"text-align:center;background-color:White;\">%d</td><td style=\"text-align:center;background-color:White;\">%d</td><td style=\"text-align:center;background-color:White;\">%d</td></tr>",sinfo.mType1Count,sinfo.mType2Count,sinfo.mType3Count,sinfo.mType4Count,sinfo.mType5Count];
    
    [sb appendFormat:@" <tr><td style=\"text-align:center;background-color:White;\">%d%@</td><td style=\"text-align:center;background-color:White;\">%d%@</td><td style=\"text-align:center;background-color:White;\">%d %@ </td><td style=\"text-align:center;background-color:White;\">%d%@</td><td style=\"text-align:center;background-color:White;\">%d%@</td></tr>",sinfo.mType1percent,@"%",sinfo.mType2percent,@"%",sinfo.mType3percent,@"%",sinfo.mType4percent,@"%",sinfo.mType5percent,@"%"];
    if ([self isEnglish]) {
        [sb appendString:@"</table></div></br><div style=\"text-align:center;background-color:White;\"><span style=\"font-size:12px; color:#4da58e;\">HR</span></div>"];
    }
    else
    {
        [sb appendString:@"</table></div></br><div style=\"text-align:center;background-color:White;\"><span style=\"font-size:12px; color:#4da58e;\">心率</span></div>"];
    }
    
    [sb appendString:@"<div style=\"text-align:center;background-color:Gray;width:290px;\"><table cellspacing=\"1\" cellpadding=\"0\"  border=\"0\" width=\"290px\" > "];
    
    sinfo=[sDatas objectAtIndex:2];
    
    [sb appendFormat:@" <tr style=\"text-align:center;\"><td style=\"text-align:center;background-color:White;\">%@</td><td  style=\"text-align:center;background-color:White;\">%@</td><td style=\"text-align:center;background-color:White;\">%@</td><td style=\"text-align:center;background-color:White;\">%@</td><td style=\"text-align:center;background-color:White;\">%@</td></tr>",[check getPulseInfo:0],[check getPulseInfo:1],[check getPulseInfo:2],[check getPulseInfo:3],[check getPulseInfo:4]];
    
    [sb appendFormat:@" <tr><td style=\"text-align:center;background-color:White;\"style=\"text-align:center;background-color:White;\">%d</td><td style=\"text-align:center;background-color:White;\">%d</td><td style=\"text-align:center;background-color:White;\">%d</td><td style=\"text-align:center;background-color:White;\">%d</td><td style=\"text-align:center;background-color:White;\">%d</td></tr>",sinfo.mType1Count,sinfo.mType2Count,sinfo.mType3Count,sinfo.mType4Count,sinfo.mType5Count];
    
    [sb appendFormat:@" <tr><td style=\"text-align:center;background-color:White;\">%d%@</td><td style=\"text-align:center;background-color:White;\">%d%@</td><td style=\"text-align:center;background-color:White;\">%d %@ </td><td style=\"text-align:center;background-color:White;\">%d%@</td><td style=\"text-align:center;background-color:White;\">%d%@</td></tr>",sinfo.mType1percent,@"%",sinfo.mType2percent,@"%",sinfo.mType3percent,@"%",sinfo.mType4percent,@"%",sinfo.mType5percent,@"%"];
     if ([self isEnglish]) {
         [sb appendString:@"</table></div></br><div style=\"text-align:center;background-color:White;\"><span style=\"font-size:12px; color:#4da58e;\">MAP</span></div>"];
     }
    else
    {
        [sb appendString:@"</table></div></br><div style=\"text-align:center;background-color:White;\"><span style=\"font-size:12px; color:#4da58e;\">平均压</span></div>"];
    }
    
    [sb appendString:@"<div style=\"text-align:center;background-color:Gray;width:290px;\"><table cellspacing=\"1\" cellpadding=\"0\"  border=\"0\" width=\"290px\" > "];
    
    
    sinfo=[sDatas objectAtIndex:3];
    
    [sb appendFormat:@" <tr style=\"text-align:center;\"><td style=\"text-align:center;background-color:White;\">%@</td><td style=\"text-align:center;background-color:White;\">%@</td><td style=\"text-align:center;background-color:White;\">%@</td><td style=\"text-align:center;background-color:White;\">%@</td><td style=\"text-align:center;background-color:White;\">%@</td></tr>",[check getPjInfo:0],[check getPjInfo:1],[check getPjInfo:2],[check getPjInfo:3],[check getPjInfo:4]];
    
    [sb appendFormat:@" <tr><td style=\"text-align:center;background-color:White;\">%d</td><td style=\"text-align:center;background-color:White;\">%d</td><td style=\"text-align:center;background-color:White;\">%d</td><td style=\"text-align:center;background-color:White;\">%d</td><td style=\"text-align:center;background-color:White;\">%d</td></tr>",sinfo.mType1Count,sinfo.mType2Count,sinfo.mType3Count,sinfo.mType4Count,sinfo.mType5Count];
    
    [sb appendFormat:@" <tr><td style=\"text-align:center;background-color:White;\">%d%@</td><td style=\"text-align:center;background-color:White;\">%d%@</td><td style=\"text-align:center;background-color:White;\">%d %@ </td><td style=\"text-align:center;background-color:White;\">%d%@</td><td style=\"text-align:center;background-color:White;\">%d%@</td></tr>",sinfo.mType1percent,@"%",sinfo.mType2percent,@"%",sinfo.mType3percent,@"%",sinfo.mType4percent,@"%",sinfo.mType5percent,@"%"];
    if ([self isEnglish]) {
        [sb appendString:@"</table></div></br><div style=\"text-align:center;background-color:White;\"><span style=\"font-size:12px; color:#4da58e;\">Pulse Perssure</span></div>"];
    }
    else
    {    [sb appendString:@"</table></div></br><div style=\"text-align:center;background-color:White;\"><span style=\"font-size:12px; color:#4da58e;\">脉压差</span></div>"];
    }
    
    [sb appendString:@"<div style=\"text-align:center;background-color:Gray;width:290px;\"><table cellspacing=\"1\" cellpadding=\"0\"  border=\"0\" width=\"290px\" >"];
    
    sinfo=[sDatas objectAtIndex:4];
    
    [sb appendFormat:@" <tr style=\"text-align:center;\" ><td style=\"text-align:center;background-color:White;\">%@</td><td style=\"text-align:center;background-color:White;\">%@</td><td style=\"text-align:center;background-color:White;\">%@</td><td style=\"text-align:center;background-color:White;\">%@</td><td style=\"text-align:center;background-color:White;\">%@</td></tr>",[check getMCInfo:0],[check getMCInfo:1],[check getMCInfo:2],[check getMCInfo:3],[check getMCInfo:4]];
    
    [sb appendFormat:@" <tr><td style=\"text-align:center;background-color:White;\">%d</td><td style=\"text-align:center;background-color:White;\">%d</td><td style=\"text-align:center;background-color:White;\">%d</td><td style=\"text-align:center;background-color:White;\">%d</td><td style=\"text-align:center;background-color:White;\">%d</td></tr>",sinfo.mType1Count,sinfo.mType2Count,sinfo.mType3Count,sinfo.mType4Count,sinfo.mType5Count];
    
    [sb appendFormat:@" <tr><td style=\"text-align:center;background-color:White;\">%d%@</td><td style=\"text-align:center;background-color:White;\">%d%@</td><td style=\"text-align:center;background-color:White;\">%d %@ </td><td style=\"text-align:center;background-color:White;\">%d%@</td><td style=\"text-align:center;background-color:White;\">%d%@</td></tr>",sinfo.mType1percent,@"%",sinfo.mType2percent,@"%",sinfo.mType3percent,@"%",sinfo.mType4percent,@"%",sinfo.mType5percent,@"%"];
    
    [sb appendString:@"</table></div>"];

    
    [sb appendString:@"</body></html>"];
    [mStatWeb loadHTMLString:sb baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
}

-(void)stat
{
    DateInfo *Now=[[DateInfo alloc]init];
    eDate=Now.mDate;
    index=0;

    if (dayType==0)
    {
        if (mTimeData.count>0) {
            QRHosInfo *iinfo=[mTimeData objectAtIndex:mTimeData.count-1];
            sTime=iinfo.mUserAge;
            eTime=iinfo.mUserHigh;
            sDate=iinfo.mUserKg;
            eDate=iinfo.mUserSex;
        }
        else
        {
            if ([self isEnglish]) {
                [self showAlertView:@"No 24H Datas "];
            }
            else
            {
                [self showAlertView:@"没有24H测量的数据"];
            }
            return;
        }
        
    }
    else if (dayType==1)
    {
        sDate=eDate;
        
    }
    else if (dayType==2)
    {
        DateInfo *s=[[DateInfo alloc]init];

        [s initDateWithDay:-6];
        sDate=s.mDate;
        
        
    }
    else if (dayType==3)
    {
         DateInfo *s=[[DateInfo alloc]init];
        [s initDateWithDay:-27];
        sDate=s.mDate;
       
    }
    else if (dayType==4)
    {
         DateInfo *s=[[DateInfo alloc]init];
        [s initDateWithDay:-181];
        sDate=s.mDate;
        
    }
    else
    {
        DateInfo *s=[[DateInfo alloc]init];
        [s initDateWithDay:-363];
        sDate=s.mDate;
        
    }
    [self stat:sDate withEndDate:eDate];
}

-(StatInfo *)getStatInfo:(NSMutableArray*)datas
{
    StatInfo *stinfo=[[StatInfo alloc]init];
    if (datas&&datas.count>0) {
        for (int i=0;i<datas.count; i++) {
            StatInfo *obj=[datas objectAtIndex:i];
            if (obj.mType==0) {
                stinfo.mType1Count=obj.mCount;
            }else  if (obj.mType==1) {
                stinfo.mType2Count=obj.mCount;
            }else  if (obj.mType==2) {
                stinfo.mType3Count=obj.mCount;
            }else  if (obj.mType==3) {
                stinfo.mType4Count=obj.mCount;
            }else
            {
                stinfo.mType5Count=obj.mCount;
            }
            stinfo.mCount+=obj.mCount;
        }
    }
    if (stinfo.mCount>0) {
        stinfo.mType1percent=stinfo.mType1Count*100/stinfo.mCount;
        stinfo.mType2percent=stinfo.mType2Count*100/stinfo.mCount;
        stinfo.mType3percent=stinfo.mType3Count*100/stinfo.mCount;
        stinfo.mType4percent=stinfo.mType4Count*100/stinfo.mCount;
        stinfo.mType5percent=stinfo.mType5Count*100/stinfo.mCount;

    }
    return stinfo;
}

-(void)statEx:(NSString *)sqlwhere  withSql:(AdInfoManager *)sql
{
    
    
    NSMutableArray *statDatas=[[NSMutableArray alloc]init];
     NSMutableArray* datas=[sql queryHighStatInfoByWhere:sqlwhere];
    StatInfo *sinfo=[self getStatInfo:datas];
    [statDatas addObject:sinfo];
    
    datas=[sql queryMinStatInfoByWhere:sqlwhere];
    sinfo=[self getStatInfo:datas];
    [statDatas addObject:sinfo];
    
    datas=[sql queryPulseStatInfoByWhere:sqlwhere];
    sinfo=[self getStatInfo:datas];
    [statDatas addObject:sinfo];
    
    datas=[sql queryPjStatInfoByWhere:sqlwhere];
    sinfo=[self getStatInfo:datas];
    [statDatas addObject:sinfo];

    datas=[sql queryMcStatInfoByWhere:sqlwhere];
    sinfo=[self getStatInfo:datas];
    [statDatas addObject:sinfo];
    
    [self loadStat:statDatas];
}

-(void)stat:(int)sdate withEndDate:(int)edate
{
    int smonth=sdate%10000/100;
     int sday=sdate%10000%100;
    
    int emonth=edate%10000/100;
    int eday=edate%10000%100;
    
    mDate.text=[NSString stringWithFormat:@"%d-%d",smonth,sday];
    meDate.text=[NSString stringWithFormat:@"%d-%d",emonth,eday];
    [mData removeAllObjects];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *uid=[prefs objectForKey:@"id"];
    NSString *sqlwhere=Nil;
    if (dayType!=0) {
        if (timeType==0) {
            sqlwhere=[NSString stringWithFormat:@" mDate>=%d and mDate<= %d and mState=1  and mUserID=%@ and mPulse>0 and mHighSpO2>0 and  mMinSpO2>0  and mCreateUserID=0 ",sdate,edate,uid];
        }
        else if (timeType==1)
        {
            sqlwhere=[NSString stringWithFormat:@" mDate>=%d and mDate<= %d  and mState=1  and mUserID=%@ and mHour<12 and mPulse>0  and mHighSpO2>0 and  mMinSpO2>0  and mCreateUserID=0  ",sdate,edate,uid];
        }
        else
        {
            sqlwhere=[NSString stringWithFormat:@" mDate>=%d and mDate<= %d  and mState=1  and mUserID=%@ and mHour>=12 and mPulse>0  and mHighSpO2>0 and  mMinSpO2>0  and mCreateUserID=0 ",sdate,edate,uid];
        }
        
    }
    else
    {
        if (timeType==0) {
            sqlwhere=[NSString stringWithFormat:@" ( (mDate =%d and mTimeCount>%d)  or (mDate =%d and mTimeCount<%d) ) and  mUserID=%@ and mPulse>0  and mHighSpO2>0 and  mMinSpO2>0   and mState=1  and mCreateUserID=0  ",sdate,sTime,edate,eTime,uid];
        }
        else if (timeType==1)
        {
            sqlwhere=[NSString stringWithFormat:@" ( (mDate =%d and mTimeCount>%d)  or (mDate =%d and mTimeCount<%d) ) and  mUserID=%@  and mHour<12 and mPulse>0 and mHighSpO2>0 and  mMinSpO2>0  and mState=1  and mCreateUserID=0  ",sdate,sTime,edate,eTime,uid];
        }
        else
        {
            sqlwhere=[NSString stringWithFormat:@" ( (mDate =%d and mTimeCount>%d)  or (mDate =%d and mTimeCount<%d) ) and  mUserID=%@  and mHour>=12 and mPulse>0  and mHighSpO2>0 and  mMinSpO2>0  and mState=1  and mCreateUserID=0 ",sdate,sTime,edate,eTime,uid];
        }
        
    }
    
    AdInfoManager *sql=[[AdInfoManager alloc]init];
    sql.path=[self dataFilePath];
    NSMutableArray* datas=[sql queryInfoByWhere:[NSString stringWithFormat:@" %@ order by mDate asc,mTime asc ",sqlwhere]];
    if(datas&&datas.count>0)
    {
        [mData addObjectsFromArray:datas];
    }

    OxyStat *mView=[[OxyStat alloc]init];
    mView.mData=mData;
    if (dayType!=0) {
        [mView initSDate:sdate withstime:0];
    }else
    {
        [mView initSDate:sdate withstime:sTime];
    }
    if (dayType!=0) {

        [mView initType:dayType withSdate:sdate withsTime:0  withEn:YES withstime:0];
    }
    else
    {
         [mView initType:dayType withSdate:sdate withsTime:(sTime/60) withEn:YES withstime:sTime];
    }
    mStatOxy.image=[mView getImg];
    XinLvStat *mXinlv=[[XinLvStat alloc]init];
    mXinlv.mData=mData;
    if (dayType!=0) {
        [mXinlv initSDate:sdate withstime:0];
    }else
    {
        [mXinlv initSDate:sdate withstime:sTime];
    }
    //[mXinlv initSDate:sdate];
    [mXinlv initType:dayType];
    mStatXinLv.image=[mXinlv getImg];
    [self statEx:sqlwhere withSql:sql];
}

-(void)moveStat
{
    if (dayType==0)
    {
        if (index>=0&&index<mTimeData.count) {
            
            QRHosInfo *iinfo=[mTimeData objectAtIndex:mTimeData.count-index-1];
            sTime=iinfo.mUserAge;
            eTime=iinfo.mUserHigh;
            sDate=iinfo.mUserKg;
            eDate=iinfo.mUserSex;
            
        }
        else
        {
            if ([self isEnglish]) {
                [self showAlertView:@"No 24H Datas "];
            }
            else
            {
                [self showAlertView:@"没有24H测量的数据"];
            }
            return;
        }
    }
    else if (dayType==1)
    {
        DateInfo *s=[[DateInfo alloc]init];
        
        [s initDateWithDay:-1*index];
        sDate=s.mDate;
        eDate=s.mDate;
        
        
    }
    else if (dayType==2)
    {
        DateInfo *Now=[[DateInfo alloc]init];
        [Now initDateWithDay:-7*index];
        eDate=Now.mDate;
        
        DateInfo *s=[[DateInfo alloc]init];
        [s initDateWithDay:-7*index-6];
        sDate=s.mDate;
        
        
    }
    else if (dayType==3)
    {
        DateInfo *Now=[[DateInfo alloc]init];
        [Now initDateWithDay:-28*index];
        eDate=Now.mDate;
        
        DateInfo *s=[[DateInfo alloc]init];
        [s initDateWithDay:-28*index-27];
        sDate=s.mDate;
        
        
    }
    else if (dayType==4)
    {
        DateInfo *Now=[[DateInfo alloc]init];
        [Now initDateWithDay:-182*index];
        eDate=Now.mDate;
        
        DateInfo *s=[[DateInfo alloc]init];
        [s initDateWithDay:-182*index-181];
        sDate=s.mDate;
        
        
    }
    else
    {
        DateInfo *Now=[[DateInfo alloc]init];
        [Now initDateWithDay:-364*index];
        eDate=Now.mDate;
        
        DateInfo *s=[[DateInfo alloc]init];
        [s initDateWithDay:-364*index-363];
        sDate=s.mDate;
        
    }
    
    [self stat:sDate withEndDate:eDate];
}

-(IBAction)btn_left:(id)sender
{
    index+=1;
    
    [self moveStat];
    

}

-(IBAction)btn_right:(id)sender
{
    index-=1;
    [self moveStat];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.navigationController!=Nil) {
        [self.navigationController setNavigationBarHidden:YES];
        
    }
    WorkTimeManager *sql=[[WorkTimeManager alloc]init];
    sql.path=[self dataFilePath];
    [sql createDb];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *uid=[prefs objectForKey:@"id"];
    NSMutableArray *times=[sql queryInfoByName:uid];
    [mTimeData removeAllObjects];
    if(times&&times.count>0)
    {
        [ mTimeData addObjectsFromArray:times];
    }
    if (!mIsLoad) {
        mIsLoad=YES;
        mIsFirst=NO;
        DateInfo *dayInfo=[[DateInfo alloc]init];
        eDate=dayInfo.mYear*10000+dayInfo.mMonth*100+dayInfo.mDay;
        sDate=eDate;
        [self btn_1d:Nil];
        if ([self isEnglish]) {
            mXinLv.text=@"HR";
            mlShouAndShu.text=@"Sys.& Dia.";
            mLeft.text=@"Chart";
            mRight.text=@"Stat";
             [btn_6m setTitle:@"6M" forState:UIControlStateNormal];
             [btn_24h setTitle:@"24h" forState:UIControlStateNormal];
             [btn_1y setTitle:@"1Y" forState:UIControlStateNormal];
             [btn_1w setTitle:@"1W" forState:UIControlStateNormal];
             [btn_1m setTitle:@"1M" forState:UIControlStateNormal];
             [btn_1d setTitle:@"1D" forState:UIControlStateNormal];
        }
    }
}

-(void)swithRefreshData
{
    if(!mIsFirst)
    {
        //DateInfo *dayInfo=[[DateInfo alloc]init];
       // eDate=dayInfo.mYear*10000+dayInfo.mMonth*100+dayInfo.mDay;
       // sDate=eDate;
        if (dayType==0) {
             [self btn_24h:Nil];
        }
        else  if (dayType==1)
        {
            [self btn_1d:nil];
        }
        else  if (dayType==2)
        {
            [self btn_1w:nil];
        }
        else  if (dayType==3)
        {
            [self btn_1m:nil];
        }
        else  if (dayType==4)
        {
            [self btn_6m:nil];
        }
        else  if (dayType==5)
        {
            [self btn_1y:nil];
        }
        else
        {
            [self btn_1d:nil];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
