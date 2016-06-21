//
//  UserListViewController.h
//  ruibaoxueya
//
//  Created by zbf on 14-4-16.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "BaseNetViewController.h"
#import "DateInfo.h"
@class QRHosInfo;
@interface UserListViewController : BaseNetViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
      NSMutableArray *mData;
      BOOL mIsLoad;
     QRHosInfo *currItem;
    DateInfo *lastdate;
}
@property(retain,nonatomic)IBOutlet UITableView *mmTable;
@property(retain,nonatomic)IBOutlet UILabel *mTitle;
-(IBAction)btn_add:(id)sender;
-(IBAction)btn_del:(id)sender;
@end
