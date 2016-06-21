//
//  AppDelegate.m
//  ruibaoxueya
//
//  Created by zbf on 14-4-15.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "AppDelegate.h"
#import "AlertHelper.h"
@implementation AppDelegate
@synthesize loginWindow;
@synthesize mNavController;


-(void)deleteClock:(int )day withid:(int )mid
{
    [AlertHelper deleteLocalNotification:[NSString stringWithFormat:@"clock_%d_alert_day_%d",mid,day]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //float version=[[[UIDevice currentDevice] systemVersion] floatValue];
    
    
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    
    loginWindow=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    self.window.rootViewController = self.loginWindow;
    self.mNavController = [[UINavigationController alloc]initWithRootViewController:loginWindow];
    self.window.backgroundColor = [UIColor whiteColor];
    loginWindow.view.frame=CGRectMake(0, 0, self.window.screen.bounds.size.width, self.window.screen.bounds.size.height);
    
    
    [self.window addSubview:self.mNavController.view];
    [self.window makeKeyAndVisible];
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *mfirstLoad=[prefs objectForKey:@"mfirstLoad"];
    if (!mfirstLoad) {
        [prefs setObject:@"false" forKey:@"mfirstLoad"];
        [prefs synchronize];
        for (int i=0; i<11; i++) {
            [self deleteClock:1 withid:i];
            [self deleteClock:2 withid:i];
            [self deleteClock:3 withid:i];
            [self deleteClock:4 withid:i];
            [self deleteClock:5 withid:i];
            [self deleteClock:6 withid:i];
            [self deleteClock:7 withid:i];
        }
        
        
        
    }

    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(BOOL)strIsEqual:(NSString *)str1 equal:(NSString *)str2
{
    if (!str1&&!str2) {
        return YES;
    }
    
    if ([str1 compare:str2 options:NSCaseInsensitiveSearch]==NSOrderedSame) {
        return YES;
    }
    return  NO;
}

-(BOOL)isEnglish
{
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    
    NSString* preferredLang = [languages objectAtIndex:0];
    NSString* substring=[preferredLang substringToIndex:2];
    if ([self strIsEqual:substring equal:@"zh"]||[self strIsEqual:substring equal:@"cn"]) {
        return false;
    }
    NSLog(@"Preferred Language:%@", preferredLang);
    if ([self strIsEqual:preferredLang equal:@"zh-Hans"]||[self strIsEqual:preferredLang equal:@"zh-Hant"]||[self strIsEqual:preferredLang equal:@"zh-Hans-CN"]||[self strIsEqual:preferredLang equal:@"zh-Hant-CN"]||[self strIsEqual:preferredLang equal:@"zh-TW"]||[self strIsEqual:preferredLang equal:@"zh-HK"]) {
        return false;
    }
   
    return YES;
}

- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"didReceiveLocalNotification");
    
    if ([self isEnglish]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: notification.alertBody message: nil delegate: Nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
         [alert show];
    }
    else
    {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: notification.alertBody message: nil delegate: Nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        [alert show];
    }
   
    
    
}

@end
