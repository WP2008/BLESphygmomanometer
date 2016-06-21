//
//  HelpViewController.m
//  ruibaoxueya
//
//  Created by zbf on 14-6-24.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController
@synthesize mTitle;
@synthesize mWebInfo;
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
    
    if ([self isEnglish]) {
        mTitle.text=@"Help";
        NSString *filePath = [[NSBundle mainBundle]pathForResource:@"help_en" ofType:@"html"];
        NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        [mWebInfo loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    }else
    {
        NSString *filePath = [[NSBundle mainBundle]pathForResource:@"help_cn" ofType:@"html"];
        NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        [mWebInfo loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
