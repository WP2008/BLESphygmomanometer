//
//  RegestViewController.h
//  haihuang
//
//  Created by zbf on 14-2-18.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetViewController.h"
@protocol RegestUserDelegate <NSObject>
-(void)regestOK:(NSString *)userName withPwd:(NSString *)pwd;
@end
@interface RegestViewController : BaseNetViewController<UIAlertViewDelegate>
{
    id<RegestUserDelegate> mRegestDelegate;
}
@property(retain,nonatomic)IBOutlet UITextField *mTxt_userName;
@property(retain,nonatomic)IBOutlet UITextField *mTxt_userPwad;
@property(retain,nonatomic)IBOutlet UITextField *mTxt_userPwd1;
@property(retain,nonatomic)id<RegestUserDelegate> mRegestDelegate;
-(IBAction)btnRegest:(id)sender;
@end
