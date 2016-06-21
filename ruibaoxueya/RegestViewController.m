//
//  RegestViewController.m
//  haihuang
//
//  Created by zbf on 14-2-18.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "RegestViewController.h"
@interface RegestViewController ()

@end

@implementation RegestViewController
@synthesize mTxt_userName;
@synthesize mTxt_userPwad;
@synthesize mTxt_userPwd1;
@synthesize mRegestDelegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(IBAction)btnRegest:(id)sender
{
    NSString *mPwd= mTxt_userPwad.text;
    NSString *mName=mTxt_userName.text;
    NSString *mPwd1= mTxt_userPwd1.text;
    if (mPwd!=Nil&&mName!=Nil&&mPwd.length>0&&mName.length>0&&mPwd1&&mPwd1.length>0) {
        
        if ([self strIsEqual:mPwd equal:mPwd1]) {
            
            
        }
        else
        {
            [self showAlertView:@"密码和确认密码不一致!"];
        }
    }
    else
    {
        [self showAlertView:@"用户名和密码不能为空!"];
    }
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.title= @"用户注册";
  
    [self initTextFiledStyle:mTxt_userPwad withType:3];
    [self initTextFiledStyle:mTxt_userPwd1 withType:3];
    [self initTextFiledStyle:mTxt_userName withType:1];
    if (self.navigationItem.backBarButtonItem!=Nil) {
        self.navigationItem.backBarButtonItem.title=Nil;
        
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.navigationController!=Nil) {
        [self.navigationController setNavigationBarHidden:YES];
        
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
