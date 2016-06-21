//
//  UserAddViewController.h
//  ruibaoxueya
//
//  Created by zbf on 14-4-16.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "BaseNetViewController.h"
#import "NumberSelectViewController.h"
#import "QRHosInfo.h"
@interface UserAddViewController : BaseNetViewController<UIAlertViewDelegate,NumberSelectDelegate>
{
    BOOL mIsLoad;
    int mhigh;
    int mage;
    int mkg;
    int msex;
    NSMutableArray *mAges;
    NSMutableArray *mKgs;
    NSMutableArray *mHighs;

}
@property(retain,nonatomic)IBOutlet UITextField *mName;
@property(retain,nonatomic)IBOutlet UIButton *mAge;
@property(retain,nonatomic)IBOutlet UIButton *mHigh;
@property(retain,nonatomic)IBOutlet UIButton *mKg;
@property(retain,nonatomic)IBOutlet UISegmentedControl *mSex;
@property(retain,nonatomic)QRHosInfo *mInfo;
@property(retain,nonatomic)IBOutlet UIButton *mBtnOk;
@property(retain,nonatomic)IBOutlet UILabel *mTitle;

@property(retain,nonatomic)IBOutlet UILabel *mlAge;
@property(retain,nonatomic)IBOutlet UILabel *mlhigh;
@property(retain,nonatomic)IBOutlet UILabel *mlkg;
@property(retain,nonatomic)IBOutlet UILabel *mlsex;
@property(retain,nonatomic)IBOutlet UILabel *mlname;
-(IBAction)btn_age:(id)sender;
-(IBAction)btn_hight:(id)sender;
-(IBAction)btn_kg:(id)sender;
-(IBAction)btn_save:(id)sender;
-(IBAction)btn_saveEx:(id)sender;
@end
