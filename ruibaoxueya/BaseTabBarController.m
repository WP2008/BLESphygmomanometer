//
//  BaseTabBarController.m
//  TCode
//
//  Created by  on 12-2-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNaviController.h"
#import "TabButton.h"

#define KCustomBarView  100

@implementation BaseTabBarController

- (id)initWithControllerArray:(NSArray *)controllerArray
{
    self = [super init];
    if (self) {
        self.viewControllers = controllerArray;
        
        CGRect tabFrame = [self tabBar].frame;
        [self tabBar].hidden = YES;
        
        UIScrollView *barView = [[UIScrollView alloc] initWithFrame:tabFrame];
        barView.showsVerticalScrollIndicator = NO;
        barView.showsHorizontalScrollIndicator = NO;
        //barView.backgroundColor = [UIColor grayColor];
        barView.backgroundColor = [UIColor clearColor];
        //barView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"tab_bg.png"]];

        barView.tag = KCustomBarView;

        int width = tabFrame.size.width/controllerArray.count;
        int height = tabFrame.size.height;
        
        CGRect iconRect = CGRectMake(0, 0, width, height);
        for(NSInteger i = 0; i < controllerArray.count; i++)
        {
            BaseNaviController *ctrl = (BaseNaviController*)[controllerArray objectAtIndex:i];
            TabButton *bt = [[TabButton alloc] initWithFrame:iconRect];
            bt.imageView.frame=iconRect;
            bt.tag = i;
            //UIImage *img=ctrl.unSelBarImage;
            //img=[img stretchableImageWithLeftCapWidth:floorf(img.size.width/2) topCapHeight:floorf(img.size.height/2)];
            [bt setBackgroundImage: ctrl.unSelBarImage forState:UIControlStateNormal];
            
            //img=ctrl.selBarImage ;
            [bt setBackgroundImage:ctrl.selBarImage forState:UIControlStateSelected];
            [bt addTarget:self action:@selector(switchView:) forControlEvents:UIControlEventTouchUpInside];
            [barView addSubview:bt];
           
            iconRect.origin.x += width;
            iconRect.origin.y=0;
            if (i==0) {
                [bt setFocus:YES];
            }
        }
        [barView setContentSize:tabFrame.size];
        
        [self.view addSubview:barView];
    }
    return self;
}

- (void)refreshView
{
    BaseNaviController *ctrl = (BaseNaviController*)[self.viewControllers objectAtIndex:self.selectedIndex];
    if(ctrl)
    {
        if(ctrl.baseRootView&&ctrl.baseRootView.mSwithRefreshDelegate)
        {
            [ctrl.baseRootView.mSwithRefreshDelegate  swithRefreshData ];
        }
    }
}

- (void)switchView:(id)sender
{
    NSInteger oldIndex = self.selectedIndex;
    
    UIView *barView = [self.view viewWithTag:KCustomBarView];
    int index = [barView.subviews indexOfObject:sender];
    
    if (oldIndex == index)
    {
        return;
    }
    
    for (TabButton *button in barView.subviews) 
    {        
        if (oldIndex == button.tag)
        {
            [button setFocus:NO];
        }
        else if (index == button.tag)
        {
            [button setFocus:YES];
        }
    }
	self.selectedIndex = index;
    [self refreshView];
}

- (void)switchViewAt:(int)index
{
    NSInteger oldIndex = self.selectedIndex;
    if (oldIndex == index)
    {
        return;
    }
    UIView *barView = [self.view viewWithTag:KCustomBarView];
    for (TabButton *button in barView.subviews)
    {
        if (oldIndex == button.tag)
        {
            [button setFocus:NO];
        }
        else if (index == button.tag)
        {
            [button setFocus:YES];
        }
    }
	self.selectedIndex = index;
    [self refreshView];
}

@end
