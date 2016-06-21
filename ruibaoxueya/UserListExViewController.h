//
//  UserListExViewController.h
//  ruibaoxueya
//
//  Created by zbf on 14-5-12.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "BaseNetViewController.h"
@class QRHosInfo;
@interface UserListExViewController : BaseNetViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    NSMutableArray *mData;
    BOOL mIsLoad;
    QRHosInfo *currItem;
    int alertType;
}
@property(retain,nonatomic)IBOutlet UITableView *mmTable;
-(IBAction)btn_del:(id)sender;
@property(retain,nonatomic)IBOutlet UILabel *mTitle;
@end
