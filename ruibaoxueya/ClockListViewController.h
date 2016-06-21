//
//  ClockListViewController.h
//  ruibaoxueya
//
//  Created by zbf on 14-7-7.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "BaseNetViewController.h"
@class clockInfo;
@interface ClockListViewController : BaseNetViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *mData;
    clockInfo *currItem;
    BOOL mIsLoad;
    
}
@property(retain,nonatomic)IBOutlet UITableView *mmTable;
@property(retain,nonatomic)IBOutlet UILabel *mTitle;
-(IBAction)btnbak:(id)sender;
-(IBAction)btnAdd:(id)sender;

@end
