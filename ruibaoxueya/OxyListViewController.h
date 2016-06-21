//
//  OxyListViewController.h
//  ruibaoxueya
//
//  Created by zbf on 14-4-17.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "BaseNetViewController.h"
#import "DateSelectViewController.h"
@class AdInfo;
@interface OxyListViewController : BaseNetViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,DateSelectDelegate,SwithRefreshDelegate>
{
    NSMutableArray *mData;
    BOOL mIsLoad;
    BOOL mIsFirst;
    AdInfo *currItem;
    int msDate;
    int meDate;
    int mtype;
}
@property(retain,nonatomic)IBOutlet UITableView *mmTable;
@property(retain,nonatomic)IBOutlet UIButton *mBtnSDate;
@property(retain,nonatomic)IBOutlet UIButton *mBtnEDate;
@property(retain,nonatomic)IBOutlet UIButton *mBtnOk;
@property(retain,nonatomic)IBOutlet UILabel *mTitle;

@property(retain,nonatomic)IBOutlet UILabel *mlDate;
-(IBAction)btn_del:(id)sender;
-(IBAction)btn_add:(id)sender;
-(IBAction)btn_sDate:(id)sender;
-(IBAction)btn_eDate:(id)sender;
-(IBAction)btn_select:(id)sender;
@end
