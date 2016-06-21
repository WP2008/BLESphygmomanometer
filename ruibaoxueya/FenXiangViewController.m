//
//  FenXiangViewController.m
//  ruibaoxueya
//
//  Created by zbf on 14-6-24.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "FenXiangViewController.h"
#import "OxyStat.h"
#import "AdInfoManager.h"
#import "DateInfo.h"
#import "XinLvStat.h"
#import "StatInfo.h"
#import "OxyCheck.h"
#import "QRHosInfo.h"
#import "WorkTimeManager.h"

@interface FenXiangViewController ()

@end

@implementation FenXiangViewController
@synthesize btn_1d;
@synthesize btn_1m;
@synthesize btn_1w;
@synthesize btn_1y;
@synthesize btn_6m;
@synthesize btn_csv;
@synthesize btn_htm;
@synthesize btn_txt;
@synthesize txt_email;
@synthesize btn_24h;
@synthesize mTitle;
@synthesize mBtnOk;
@synthesize mldata;
@synthesize mlemail;
@synthesize mlformat;
@synthesize btn_24ht;
@synthesize btn_1dt;
@synthesize btn_1mt;
@synthesize btn_1wt;
@synthesize btn_1yt;
@synthesize btn_6mt;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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

-(IBAction)btn_txt:(id)sender
{
    formatType=0;
    [btn_txt setBackgroundImage:[UIImage imageNamed:@"schecked"] forState:UIControlStateNormal];
    [btn_htm setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [btn_csv setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
}

-(IBAction)btn_htm:(id)sender
{
    formatType=1;
    [btn_txt setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [btn_htm setBackgroundImage:[UIImage imageNamed:@"schecked"] forState:UIControlStateNormal];
    [btn_csv setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
}

-(IBAction)btn_csv:(id)sender
{
    formatType=1;
    [btn_txt setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [btn_htm setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [btn_csv setBackgroundImage:[UIImage imageNamed:@"schecked"] forState:UIControlStateNormal];
}

-(IBAction)btn_24h:(id)sender
{
    dayType=0;
    [btn_24h setBackgroundImage:[UIImage imageNamed:@"schecked"] forState:UIControlStateNormal];
    [btn_1y setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [btn_1d setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [btn_1w setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [btn_1m setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [btn_6m setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [self stat];
}

-(IBAction)btn_1d:(id)sender
{
    dayType=1;
    [btn_1d setBackgroundImage:[UIImage imageNamed:@"schecked"] forState:UIControlStateNormal];
    [btn_1w setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [btn_1m setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [btn_6m setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [btn_24h setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [btn_1y setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [self stat];
}

-(IBAction)btn_1w:(id)sender
{
    dayType=2;
    [btn_1d setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [btn_1w setBackgroundImage:[UIImage imageNamed:@"schecked"] forState:UIControlStateNormal];
    [btn_1m setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [btn_6m setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [btn_24h setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [btn_1y setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [self stat];
}

-(IBAction)btn_1m:(id)sender
{
    dayType=3;
    [btn_1d setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [btn_1w setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [btn_1m setBackgroundImage:[UIImage imageNamed:@"schecked"] forState:UIControlStateNormal];
    [btn_6m setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [btn_24h setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [btn_1y setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [self stat];
}

-(IBAction)btn_6m:(id)sender
{
    dayType=4;
    [btn_1d setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [btn_1w setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [btn_1m setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [btn_6m setBackgroundImage:[UIImage imageNamed:@"schecked"] forState:UIControlStateNormal];
    [btn_24h setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [btn_1y setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [self stat];
}

-(IBAction)btn_1y:(id)sender
{
    dayType=5;
    [btn_1d setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [btn_1w setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [btn_1m setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [btn_6m setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [btn_24h setBackgroundImage:[UIImage imageNamed:@"scheckno"] forState:UIControlStateNormal];
    [btn_1y setBackgroundImage:[UIImage imageNamed:@"schecked"] forState:UIControlStateNormal];
    [self stat];
}
-(void)stat
{
    DateInfo *Now=[[DateInfo alloc]init];
    eDate=Now.mDate;
  
    
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
            [self showAlertView:@"没有24h测量的数据"];
            return;
        }
        
    }else if (dayType==1)
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
        [s initDateWithDay:-29];
        sDate=s.mDate;
        
    }
    else if (dayType==4)
    {
        DateInfo *s=[[DateInfo alloc]init];
        [s initDateWithDay:-179];
        sDate=s.mDate;
        
    }
    else
    {
        sDate=eDate-10000;
        
    }
    //[self stat:sDate withEndDate:eDate];
}

-(void)sendMail:(NSString *)mailBody
{
    NSMutableString *mailUrl = [[NSMutableString alloc]init];
    //添加收件人
    NSArray *toRecipients = [NSArray arrayWithObject: txt_email.text];
    [mailUrl appendFormat:@"mailto:%@", [toRecipients componentsJoinedByString:@","]];
    
    //添加主题
    [mailUrl appendString:@"&subject=龍脉分享"];
    //添加邮件内容
    [mailUrl appendFormat:@"&body=<b>%@</b>",mailBody];
    NSString* email = [mailUrl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];
}

- (BOOL)sendMailInApp
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (!mailClass) {
        
        return false;
    }
    if (![mailClass canSendMail]) {
        
        return false;
    }
    return YES;
}
- (void)displayMailPicker :(NSString *)mailBody
{
    if (![self sendMailInApp]) {
        [self sendMail:mailBody];
        return;
    }
    
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate = self;
    if ([self isEnglish]) {
        [mailPicker setSubject: @"Sharing"];
    
    }
    else
    {
        [mailPicker setSubject: @"分享"];
    }
    //添加收件人
    NSArray *toRecipients = [NSArray arrayWithObject: txt_email.text];
    [mailPicker setToRecipients: toRecipients];
    
    NSString *emailBody =[NSString stringWithFormat: @"%@",mailBody];
    [mailPicker setMessageBody:emailBody isHTML:YES];
    [self presentModalViewController: mailPicker animated:YES];
    
}




-(IBAction)btn_send:(id)sender
{
    if (txt_email.text&&txt_email.text.length>0&&[txt_email.text rangeOfString:@"@"].length>0) {
        [self stat:sDate withEndDate:eDate];
    }
    else
    {
        [self showAlertView:@"请输入收件地址"];
    }
    
    
}

-(void)stat:(int)sdate withEndDate:(int)edate
{
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
            [self showAlertView:@"没有24h测量的数据"];
            return;
        }
        
    }
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *uid=[prefs objectForKey:@"id"];
    NSString *sqlwhere=Nil;
    if (dayType!=0) {
        
            sqlwhere=[NSString stringWithFormat:@" mDate>=%d and mDate<= %d  and mUserID=%@ and mPulse>0 and mHighSpO2>0 and  mMinSpO2>0 ",sdate,edate,uid];
        
        
    }
    else
    {
        
            sqlwhere=[NSString stringWithFormat:@" ( (mDate =%d and mTimeCount>%d)  or (mDate =%d and mTimeCount<%d) ) and  mUserID=%@ and mPulse>0  and mHighSpO2>0 and  mMinSpO2>0  ",sdate,sTime,edate,eTime,uid];
        

        
    }
    
    AdInfoManager *sql=[[AdInfoManager alloc]init];
    sql.path=[self dataFilePath];
    NSMutableArray* datas=[sql queryInfoByWhere:[NSString stringWithFormat:@" %@ order by mDate asc,mTime asc ",sqlwhere]];
    if(datas&&datas.count>0)
    {
        NSMutableString *info=[[NSMutableString alloc]init];
        if (formatType==1) {
             if ([self isEnglish]) {
                 [info appendString:@"<html><title>Sharing</title><body>"];
            }
            else
            {
                [info appendString:@"<html><title>分享</title><body><div>"];
            }
        }
        
        for (int i=0; i<datas.count; i++) {
            AdInfo *arecord=[datas objectAtIndex:i];
             if ([self isEnglish]) {
                 [info appendFormat:@"%d-%d-%d Sys.:%d,Dia.：%d,HR:%d\r\n",arecord.mYear,arecord.mHour,arecord.mDay,arecord.mHighSpO2,arecord.mMinSpO2,arecord.mPulse];             }
            else
            {
                
                [info appendFormat:@"%d-%d-%d 收缩压:%d,舒张压：%d,心率:%d\r\n",arecord.mYear,arecord.mHour,arecord.mDay,arecord.mHighSpO2,arecord.mMinSpO2,arecord.mPulse];
            }
        }
        if (formatType==1) {
            [info appendString:@"</div></body></html>"];
        }
        [self displayMailPicker:info];
    }
    else
    {
        if ([self isEnglish]) {
             [self showAlertView:@"No Sharing Data "];
        }
        else
        {
            [self showAlertView:@"没有分享数据"];
        }
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTextFiledStyle:txt_email withType:1];
     if ([self isEnglish]) {
         mlformat.text=@"Format";
         mlemail.text=@"Email";
         mldata.text=@"Data";
         mTitle.text=@"Sharing";
        [mBtnOk setTitle:@"Send" forState:UIControlStateNormal];
         [btn_6mt setTitle:@"6M" forState:UIControlStateNormal];
         [btn_24ht setTitle:@"24h" forState:UIControlStateNormal];
         [btn_1yt setTitle:@"1Y" forState:UIControlStateNormal];
         [btn_1wt setTitle:@"1W" forState:UIControlStateNormal];
         [btn_1mt setTitle:@"1M" forState:UIControlStateNormal];
         [btn_1dt setTitle:@"1D" forState:UIControlStateNormal];
     }
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 实现 MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    //关闭邮件发送窗口
    [self dismissModalViewControllerAnimated:YES];
    NSString *msg;
    switch (result) {
        case MFMailComposeResultCancelled:
            msg = @"用户取消编辑邮件";
            break;
        case MFMailComposeResultSaved:
            msg = @"用户成功保存邮件";
            break;
        case MFMailComposeResultSent:
            msg = @"用户点击发送，将邮件放到队列中，还没发送";
            break;
        case MFMailComposeResultFailed:
            msg = @"用户试图保存或者发送邮件失败";
            break;
        default:
            msg = @"";
            break;
    }
    //[self showAlertView:msg];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
