//
//  StatViewController.h
//  ruibaoxueya
//
//  Created by zbf on 14-4-17.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "BaseNetViewController.h"

@interface StatViewController : BaseNetViewController<UIScrollViewDelegate,SwithRefreshDelegate>
{
    int dayType;
    int timeType;
    int sDate;
    int eDate;
    int sTime;
    int eTime;
    int index;
    BOOL mIsLoad;
    BOOL mIsFirst;
    NSMutableArray *mData;
    NSMutableArray *mTimeData;
    
}
@property(nonatomic,retain)IBOutlet UIImageView *mTitleBg;
@property(nonatomic,retain)IBOutlet UIImageView *mTypeBg;
@property(nonatomic,retain)IBOutlet UIImageView *mStatOxy;
@property(nonatomic,retain)IBOutlet UIImageView *mStatXinLv;
@property(nonatomic,retain)IBOutlet UIImageView *mSelect0;
@property(nonatomic,retain)IBOutlet UIImageView *mSelect1;
@property(nonatomic,retain)IBOutlet UIWebView *mStatWeb;
@property(nonatomic,retain)IBOutlet UILabel *mDate;
@property(nonatomic,retain)IBOutlet UILabel *meDate;
@property(nonatomic,retain)IBOutlet UIScrollView *mScollView;
@property(nonatomic,retain)IBOutlet UILabel *mLeft;
@property(nonatomic,retain)IBOutlet UILabel *mRight;
@property(nonatomic,retain)IBOutlet UILabel *mlShouAndShu;
@property(nonatomic,retain)IBOutlet UILabel *mXinLv;

@property(nonatomic,retain)IBOutlet UIButton *btn_24h;
@property(nonatomic,retain)IBOutlet UIButton *btn_1d;
@property(nonatomic,retain)IBOutlet UIButton *btn_1w;
@property(nonatomic,retain)IBOutlet UIButton *btn_1m;
@property(nonatomic,retain)IBOutlet UIButton *btn_6m;
@property(nonatomic,retain)IBOutlet UIButton *btn_1y;

-(IBAction)btn_24h:(id)sender;
-(IBAction)btn_1d:(id)sender;
-(IBAction)btn_1w:(id)sender;
-(IBAction)btn_1m:(id)sender;
-(IBAction)btn_6m:(id)sender;
-(IBAction)btn_1y:(id)sender;

-(IBAction)btn_all:(id)sender;
-(IBAction)btn_am:(id)sender;
-(IBAction)btn_pm:(id)sender;
-(void)stat;
-(void)stat:(int)sDate withEndDate:(int)eDate;
-(IBAction)btn_left:(id)sender;
-(IBAction)btn_right:(id)sender;
@end
