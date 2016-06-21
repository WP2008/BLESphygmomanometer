//
//  AoatViewController.m
//  ruibaoxueya
//
//  Created by zbf on 14-6-24.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "AoatViewController.h"

@interface AoatViewController ()

@end

@implementation AoatViewController
@synthesize mTitle;
@synthesize mContentInfo;
@synthesize mInfo;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mContentInfo.frame=CGRectMake(0, 65, 320, [UIScreen mainScreen].bounds.size.height-120);
    mContentInfo.contentSize=mInfo.frame.size;
    if ([self isEnglish]) {
        mTitle.text=@"About";
        mInfo.image=[UIImage imageNamed:@"aboat_en"];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
