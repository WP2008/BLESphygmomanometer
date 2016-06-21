//
//  AppDelegate.h
//  ruibaoxueya
//
//  Created by zbf on 14-4-15.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(retain,nonatomic)UINavigationController *mNavController;
@property(retain,nonatomic)LoginViewController *loginWindow;
@end
