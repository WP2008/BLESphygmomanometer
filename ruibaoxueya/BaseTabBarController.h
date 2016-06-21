//
//  BaseTabBarController.h
//  TCode
//
//  Created by  on 12-2-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabBarController : UITabBarController

- (id)initWithControllerArray:(NSArray *)controllerArray;
- (void)switchViewAt:(int)index;
@end
