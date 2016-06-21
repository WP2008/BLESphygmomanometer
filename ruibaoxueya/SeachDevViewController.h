//
//  SeachDevViewController.h
//  ruibaoxueya
//
//  Created by zbf on 14-5-4.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "BaseNetViewController.h"
@interface SeachDevViewController : BaseNetViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    NSMutableArray *mData;
  
    BOOL mIsLoad;
    
}
@property(retain,nonatomic)IBOutlet UITableView *mmTable;
-(IBAction)btnbak:(id)sender;
@property(retain,nonatomic)IBOutlet UILabel *mTitle;
@end
