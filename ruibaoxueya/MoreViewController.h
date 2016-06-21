//
//  MoreViewController.h
//  ruibaoxueya
//
//  Created by zbf on 14-4-17.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "BaseNetViewController.h"

@interface MoreViewController : BaseNetViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    NSMutableArray *mData;
    BOOL mIsLoad;
    int alertType;
}
@property(retain,nonatomic)IBOutlet UITableView *mmTable;
-(IBAction)btn_excit:(id)sender;
-(IBAction)btn_zhuXiao:(id)sender;
@property(retain,nonatomic)IBOutlet UILabel *mTitle;
@end
