//
//  BaseNaviController.h
//  TCode
//
//  Created by  on 12-2-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetViewController.h"
@interface BaseNaviController : UINavigationController
{
    UIImage         *_selBarImage;
    UIImage         *_unSelBarImage;
    BaseNetViewController *_baseRootView;
}

@property(nonatomic, retain) UIImage *selBarImage;
@property(nonatomic, retain) UIImage *unSelBarImage;
@property(nonatomic, retain) BaseNetViewController *baseRootView;
- (id)initWithRootViewController:(BaseNetViewController *)rootViewController selImage:(UIImage *)selImage unSelImage:(UIImage *)unSelImage;

@end
