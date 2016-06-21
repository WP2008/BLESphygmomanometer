//
//  OxyBiaoZhunViewController.m
//  ruibaoxueya
//
//  Created by zbf on 14-4-18.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "OxyBiaoZhunViewController.h"

@interface OxyBiaoZhunViewController ()

@end

@implementation OxyBiaoZhunViewController
@synthesize mTitle;
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
        mTitle.text=@"BP Standards";
        mInfo.image=[UIImage imageNamed:@"bianzhun_en"];
        
    }
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
