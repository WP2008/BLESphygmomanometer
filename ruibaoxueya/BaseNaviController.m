//
//  BaseNaviController.m
//  TCode
//
//  Created by  on 12-2-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BaseNaviController.h"

@implementation BaseNaviController

@synthesize selBarImage = _selBarImage;
@synthesize unSelBarImage = _unSelBarImage;
@synthesize baseRootView;
- (id)initWithRootViewController:(BaseNetViewController *)rootViewController selImage:(UIImage *)selImage unSelImage:(UIImage *)unSelImage{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.selBarImage = selImage;
        self.unSelBarImage = unSelImage;
        self.baseRootView=rootViewController;
    }
    return self;
}

- (void)dealloc{
   // [super dealloc];
}


@end
