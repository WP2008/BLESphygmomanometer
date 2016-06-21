//
//  FenXiangViewController.h
//  ruibaoxueya
//
//  Created by zbf on 14-6-24.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "BaseNetViewController.h"
#import <MessageUI/MFMailComposeViewController.h>
@interface FenXiangViewController : BaseNetViewController<MFMailComposeViewControllerDelegate>
{
    int dayType;
    int formatType;
    int sDate;
    int eDate;
    int sTime;
    int eTime;
    NSMutableArray *mTimeData;
    int index;
    
}
@property(retain,nonatomic)IBOutlet UIButton *btn_1d;
@property(retain,nonatomic)IBOutlet UIButton *btn_1w;
@property(retain,nonatomic)IBOutlet UIButton *btn_1m;
@property(retain,nonatomic)IBOutlet UIButton *btn_6m;
@property(retain,nonatomic)IBOutlet UIButton *btn_1y;
@property(retain,nonatomic)IBOutlet UIButton *btn_24h;
@property(retain,nonatomic)IBOutlet UITextField *txt_email;
@property(retain,nonatomic)IBOutlet UIButton *btn_txt;
@property(retain,nonatomic)IBOutlet UIButton *btn_htm;
@property(retain,nonatomic)IBOutlet UIButton *btn_csv;

@property(retain,nonatomic)IBOutlet UILabel *mTitle;
@property(retain,nonatomic)IBOutlet UIButton *mBtnOk;


@property(retain,nonatomic)IBOutlet UILabel *mldata;
@property(retain,nonatomic)IBOutlet UILabel *mlemail;
@property(retain,nonatomic)IBOutlet UILabel *mlformat;


@property(nonatomic,retain)IBOutlet UIButton *btn_24ht;
@property(nonatomic,retain)IBOutlet UIButton *btn_1dt;
@property(nonatomic,retain)IBOutlet UIButton *btn_1wt;
@property(nonatomic,retain)IBOutlet UIButton *btn_1mt;
@property(nonatomic,retain)IBOutlet UIButton *btn_6mt;
@property(nonatomic,retain)IBOutlet UIButton *btn_1yt;


-(IBAction)btn_24h:(id)sender;
-(IBAction)btn_1d:(id)sender;
-(IBAction)btn_1w:(id)sender;
-(IBAction)btn_1m:(id)sender;
-(IBAction)btn_6m:(id)sender;
-(IBAction)btn_1y:(id)sender;

-(IBAction)btn_txt:(id)sender;
-(IBAction)btn_htm:(id)sender;
-(IBAction)btn_csv:(id)sender;

-(IBAction)btn_send:(id)sender;
-(void)stat;
-(void)stat:(int)sDate withEndDate:(int)eDate;
@end
