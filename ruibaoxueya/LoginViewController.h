//
//  LoginViewController.h
//  haihuang
//
//  Created by zbf on 14-2-18.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetViewController.h"
#import "RegestViewController.h"
#import "QRHosInfo.h"
@class BaseTabBarController;
@interface LoginViewController : BaseNetViewController<UITabBarControllerDelegate,RegestUserDelegate,UITableViewDataSource,UITableViewDelegate>
{

    BOOL isOpenRegest;
    BaseTabBarController *tabBar;
    
    NSMutableArray *mData;
    BOOL mIsLoad;
    QRHosInfo *currItem;
}

@property(retain,nonatomic)IBOutlet UITextField *mTxt_name;
@property(retain,nonatomic)IBOutlet UITableView *mmTable;
@property(retain,nonatomic)IBOutlet UIButton *mbtnOpen;

@property(retain,nonatomic)IBOutlet UIImageView *mBg;
@property(retain,nonatomic)IBOutlet UIButton *mbtnOk;
@property(retain,nonatomic)IBOutlet UIButton *mbtnAdd;
@property(retain,nonatomic)IBOutlet UIButton *mbtnVisit;
-(IBAction)loginPress:(id)sender;
-(IBAction)regestPress:(id)sender;
-(IBAction)guestPress:(id)sender;
-(IBAction)btnOpen:(id)sender;
@end
