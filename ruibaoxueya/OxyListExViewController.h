//
//  OxyListExViewController.h
//  ruibaoxueya
//
//  Created by zbf on 14-5-12.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "BaseNetViewController.h"
#import "DateSelectViewController.h"
@class AdInfo;
@interface OxyListExViewController : BaseNetViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,DateSelectDelegate>
{
    NSMutableArray *mData;
    BOOL mIsLoad;
    AdInfo *currItem;
    int msDate;
    int meDate;
    int mtype;
    int alertType;
}
@property(retain,nonatomic)IBOutlet UITableView *mmTable;
@property(retain,nonatomic)IBOutlet UIButton *mBtnSDate;
@property(retain,nonatomic)IBOutlet UIButton *mBtnEDate;
@property(retain,nonatomic)IBOutlet UIButton *mBtnOk;
@property(retain,nonatomic)IBOutlet UILabel *mTitle;

@property(retain,nonatomic)IBOutlet UILabel *mlDate;
-(IBAction)btn_del:(id)sender;
-(IBAction)btn_sDate:(id)sender;
-(IBAction)btn_eDate:(id)sender;
-(IBAction)btn_select:(id)sender;

@end
