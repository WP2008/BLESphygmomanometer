//
//  BaseNetViewController.m
//  JeffreyPrj
//
//  Created by zhao on 12-3-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import <unistd.h>
#import "BaseNetViewController.h"
#import <QuartzCore/QuartzCore.h>
#define kFileName @"ruibao.sqlite3"
@implementation BaseNetViewController
@synthesize httpTaskRunning;
@synthesize mNetDelegate;
@synthesize mReceiveData;
@synthesize recordSetting;
@synthesize recorderFilePath;
@synthesize imgFilePath;
@synthesize mRecordDelegate;
@synthesize mPaiZhaoDelegate;
@synthesize mSwithRefreshDelegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
        


         //midy=[[UIScreen mainScreen] bounds].size.height/2;
         midy=self.view.center.y;
         midx=self.view.center.x;
         isediting=false;

        isStartRecord=false;
    }
    return self;
}
-(IBAction)btn_bak:(id)sender
{
    [self closeMe];
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

- (NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    
    return destDateString;
    
}

- (NSDate *)dateFromString:(NSString *)dateString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
    
}

- (NSString *)subDateFromDate:(NSString *)date
{
    if (!date) {
        return date;
    }
    NSRange index=[date rangeOfString:@" "];
    if (index.length>0) {
        date= [date substringToIndex:index.location];
        index=[date rangeOfString:@"-"];
        if (index.length>0)
        {
            date=[date substringFromIndex:index.location+1];
            index=[date rangeOfString:@"-"];
            if (index.length>0)
            {
                date=[NSString stringWithFormat:@"%@月%@日",[date substringToIndex:index.location],[date substringFromIndex:index.location+1]];
            }
        }
    }
    else
    {
        index=[date rangeOfString:@"-"];
        if (index.length>0)
        {
            date=[date substringFromIndex:index.location+1];
            index=[date rangeOfString:@"-"];
            if (index.length>0)
            {
                date=[NSString stringWithFormat:@"%@月%@日",[date substringToIndex:index.location],[date substringFromIndex:index.location+1]];
            }
        }
    }
    return date;
}

-(NSString*)dataFilePath:(NSString *)fileName
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if(paths!=nil)
    {
        NSString *documentDir=[paths objectAtIndex:0];
        if(documentDir!=nil)
        {
            return [documentDir stringByAppendingPathComponent:fileName];
        }
    }
    return nil;
}

-(void)deleteFile:(NSString*)fileName
{
    NSFileManager *file_manager = [NSFileManager defaultManager];
    if ([file_manager fileExistsAtPath:fileName]) {
        [file_manager removeItemAtPath:fileName error:nil];
    }
}

-(BOOL)isFileExist:(NSString *)name
{
    NSFileManager *file_manager = [NSFileManager defaultManager];
    return [file_manager fileExistsAtPath:name];
}

- (void) makeCall:(NSString *)phoneNumber

{
    
    /*if ([DeviceDetection isIPodTouch]){
        
        [UIUtils alert:kCallNotSupportOnIPod];
        
        return;
        
    }
    
     
    NSString* numberAfterClear = [UIUtils cleanPhoneNumber:phoneNumber];
    
    */
    phoneNumber=[phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];

    // NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@", phoneNumber]];
    NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phoneNumber]];    NSLog(@"make call, URL=%@", phoneNumberURL);
    
    UIWebView *mCallWebview = [[UIWebView alloc] init] ;
    [self.view addSubview:mCallWebview];
    [mCallWebview loadRequest:[NSURLRequest requestWithURL:phoneNumberURL]];
    
    //[[UIApplication sharedApplication] openURL:phoneNumberURL];
    
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

- (void) sendSms:(NSString *)phoneNumber

{
    /*
    if ([DeviceDetection isIPodTouch]){
        
        [UIUtils alert:kSmsNotSupportOnIPod];
        
        return;
        
    }
    
    
    
    NSString* numberAfterClear = [UIUtils cleanPhoneNumber:phoneNumber];
    
    
    */
    NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"sms:%@", phoneNumber]];
    
    NSLog(@"send sms, URL=%@", phoneNumberURL);
    UIWebView *mCallWebview = [[UIWebView alloc] init] ;
    [self.view addSubview:mCallWebview];
    [mCallWebview loadRequest:[NSURLRequest requestWithURL:phoneNumberURL]];
    //[[UIApplication sharedApplication] openURL:phoneNumberURL];
    
}

- (BOOL) prepareToRecord

{
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    
    NSError *err = nil;
    
    [audioSession setCategory :AVAudioSessionCategoryPlayAndRecord error:&err];
    
    if(err){
        
        NSLog(@"audioSession: %@ %ld %@", [err domain], [err code], [[err userInfo] description]);
        [self showAlertView:[err localizedDescription] ];
        return NO;
        
    }
     err = nil;
    [audioSession setActive:YES error:&err];
    if(err){
        
        NSLog(@"audioSession: %@ %ld %@", [err domain], [err code], [[err userInfo] description]);
        
        return NO;
        
    }
    
    recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    
    [recordSetting setValue :[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    
    [recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
    
    [recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    
    // Create a new dated file
    NSDate *now = [NSDate dateWithTimeIntervalSinceNow:0];
    NSString *caldate =[NSString stringWithFormat:@"%d",(int)[now timeIntervalSince1970]];
    recorderFilePath = [self dataFilePath:caldate];
    recorderFilePath=[NSString stringWithFormat:@"%@.caf",recorderFilePath];
    NSURL *url = [NSURL fileURLWithPath:recorderFilePath];
    err = nil;
    recorder = [[ AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:&err];
    if(!recorder){
        NSLog(@"recorder: %@ %ld %@", [err domain], [err code], [[err userInfo] description]);
        [self showAlertView:[err localizedDescription] ];
        return NO;
    }
    //prepare to record
    [recorder setDelegate:self];
    [recorder prepareToRecord];
    recorder.meteringEnabled = YES;
    BOOL audioHWAvailable = audioSession.isInputAvailable;
    if (! audioHWAvailable) {
        [self showAlertView:@"音频输入不可用" ];
        return NO;
    }
    return YES;
}

-(void)startrecorder
{
    if (!recorder) {
        [self prepareToRecord];
    }
    if (recorder) {
        
         [recorder record];
        isStartRecord=YES;
    }
   
}

-(void) stopRecording{
    if (recorder) {
        [recorder stop];
        isStartRecord=false;
        recorder =Nil;
    }
    
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *) aRecorder successfully:(BOOL)flag
{
    if (flag) {
        NSLog(@"recorder successfully");
        if (mRecordDelegate) {
            [mRecordDelegate receiveRecord:recorderFilePath];
        }
        [self showAlertView:@"录音成功"];
    }
    else
    {
        [self showAlertView:@"录音失败"];
    }
   
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)arecorder error:(NSError *)error
{
    
     [self showAlertView:@"录音发生错误"];
    
}

-(void)paiZhao
{
        UIImagePickerControllerSourceType sourceType=UIImagePickerControllerSourceTypeCamera;
    
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
            sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        
        }
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType =sourceType;
        [self presentViewController:picker animated:YES completion:Nil];
    
}

-(void)photoImg
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:Nil];
}

-(void)saveImage:(UIImage*)image

{
    imgFilePath=image;
    NSLog(@"保存");
    if (mPaiZhaoDelegate) {
        [mPaiZhaoDelegate receiveImg:image];
    }
    
}
-(NSString*)dataFilePath
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if(paths!=nil)
    {
        NSString *documentDir=[paths objectAtIndex:0];
        if(documentDir!=nil)
        {
            return [documentDir stringByAppendingPathComponent:kFileName];
        }
    }
    return nil;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0)
{
    [picker dismissViewControllerAnimated:YES completion:Nil];
    NSLog(@"didFinishPickingImage");
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"imagePickerController");
    [picker dismissViewControllerAnimated:YES completion:Nil];
    UIImage * image=[info objectForKey:UIImagePickerControllerEditedImage];
    
    [self performSelector:@selector(saveImage:) withObject:image afterDelay:0.5];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:Nil];
}

-(void)closeMe
{
    if (isStartRecord) {
        [self showAlertView:@"请先停止录音"];
    }
    else
    {
        if (self.navigationController) {
            if (self.navigationController.viewControllers.count>=2) {
                [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2] animated:YES];
            }
            
        }
    }
}

-(void)openWindow:(UIViewController*)window
{
    if(self.navigationController!=NULL)
    {
        [self.navigationController pushViewController:window animated:YES];
    }
    else
    {
        [self presentViewController:window animated:YES completion:Nil];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isKindOfClass:[UITableView class]]) {
        return;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];


   
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

}

- (void)dealloc {
	//[super dealloc];
   //	[xmlParer release];
}

- (void)waitingTask{
	//just wait until the serial-no was get.
	while (httpTaskRunning) {
		usleep(5);
	}
    NSLog(@"waitingTask stop");
}

- (void)showWaitingBar:(NSString*)disStr{
    if (progressBar==nil) {
        if (self.navigationController.view!=nil) {
            progressBar = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        }else {
            progressBar = [[MBProgressHUD alloc] initWithView:self.view];
        }
        
        // Add progress bar to screen
        [self.navigationController.view addSubview:progressBar];
        
        // Regisete for progressBar callbacks so we can remove it from the window at the right time
        progressBar.delegate = self;
        
        progressBar.labelText = disStr;
        httpTaskRunning=YES;
        // Show the progressBar while the provided method executes in a new thread
        [progressBar showWhileExecuting:@selector(waitingTask) onTarget:self withObject:nil animated:YES];
    }
    
}

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    if (progressBar==nil) {
        return;
    }
	[progressBar removeFromSuperview];
	//[progressBar release];
    progressBar=nil;
}

-(void)pageAnimation
{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.5f ;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.endProgress = 1;
    animation.removedOnCompletion = NO;
    animation.type = @"pageUnCurl";//cube,suckEffect,oglFlip,rippleEffect,pageCurl,pageUnCurl,cameraIrisHollowOpen,cameraIrisHollowClose    
    [self.view.layer addAnimation:animation forKey:@"animation"];
}

-(void)waitAnimation
{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 2.99f ;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.endProgress = 1;
    animation.removedOnCompletion = NO;
    animation.type = @"cube";//cube,suckEffect,oglFlip,rippleEffect,pageCurl,pageUnCurl,cameraIrisHollowOpen,cameraIrisHollowClose    
    [self.view.layer addAnimation:animation forKey:@"animation"];
}

-(void)animation
{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.1f ;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.endProgress = 1;
    animation.removedOnCompletion = NO;
    animation.type = @"cube";//cube,suckEffect,oglFlip,rippleEffect,pageCurl,pageUnCurl,cameraIrisHollowOpen,cameraIrisHollowClose    
    [self.view.layer addAnimation:animation forKey:@"animation"];
}


-(void)maintainVisibityofControl:(UIControl *)control offset:(float) offset
{
     float deviceHeight=[[UIScreen mainScreen] bounds].size.height;
    static const float keyboardHeight=170;
    static const float gab=5;
    CGPoint absolute=[control.superview convertPoint:control.frame.origin toView:nil];
    if(absolute.y>=(keyboardHeight+gab))
    {
         shiftBy=(deviceHeight -absolute.y)-(deviceHeight-keyboardHeight-gab-offset);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.6f];
        CGAffineTransform slideTeansform=CGAffineTransformMakeTranslation(0.0, shiftBy);
        self.view.transform=slideTeansform;
        [UIView commitAnimations];
        
    }

    /*static const float keyboardHeight=170;
    static const float gab=5;
    CGPoint absolute=[control.superview convertPoint:control.frame.origin toView:nil];
    if(absolute.y>=(keyboardHeight+gab))
    {
        shiftBy=(deviceHeight -absolute.y)-(deviceHeight-keyboardHeight-gab-offset);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.6f];
        CGAffineTransform slideTeansform=CGAffineTransformMakeTranslation(0.0, shiftBy);
        self.view.transform=slideTeansform;
        [UIView commitAnimations];
        
        NSTimeInterval animationDuration = 0.30f;
        CGRect frame = self.view.frame;
        frame.origin.y +=shiftBy;//view的X轴上移
        self.view.frame = frame;
        [UIView beginAnimations:@"ResizeView" context:nil];
        [UIView setAnimationDuration:animationDuration];
        self.view.frame = frame;
        [UIView commitAnimations];
        
    }*/
}

-(void) resetViewToIdentityTransfrom
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    
    CGAffineTransform slideTeansform=CGAffineTransformIdentity;
    self.view.transform=slideTeansform;
    [UIView commitAnimations];
     /*
      if (shiftBy==0) {
        return;
    }
    shiftBy=0-shiftBy;
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    frame.origin.y +=shiftBy;//view的X轴上移
    self.view.frame = frame;
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    shiftBy=0;
   
    shiftBy=0-shiftBy;
    CGAffineTransform slideTeansform=CGAffineTransformMakeTranslation(0.0, shiftBy);
    self.view.transform=slideTeansform;
    [UIView commitAnimations];*/
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self maintainVisibityofControl:textField offset:0.0f];
    isediting=true;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (isediting) {
        [self resetViewToIdentityTransfrom];
    }
    isediting=false;
    
}

- (void) onCommonBarTask {
	//just wait
	sleep(2);
}

- (void)showCommonBar:(NSString*)disStr withType:(int)type{
	
}


- (void)setButtonGreenBgImg:(UIButton*)button{
    UIImage *imgNormal = [UIImage imageNamed:@"cell_button_bg_green.png"];
	UIImage *imgFocus = [UIImage imageNamed:@"cell_button_bg_green_p.png"];
    UIImage* strechNormalImg = [imgNormal stretchableImageWithLeftCapWidth:10 topCapHeight:0];
    UIImage* strechFocusImg = [imgFocus stretchableImageWithLeftCapWidth:10 topCapHeight:0];

	[button setBackgroundImage:strechNormalImg forState:UIControlStateNormal];
	[button setBackgroundImage:strechFocusImg forState:UIControlStateHighlighted];
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //UIColor *disableColor = [[UIColor alloc]initWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    //[button setTitleColor:disableColor forState:UIControlStateDisabled];
}

- (void)setButtonRedBgImg:(UIButton*)button{
    UIImage *imgNormal = [UIImage imageNamed:@"cell_button_bg_red.png"];
	UIImage *imgFocus = [UIImage imageNamed:@"cell_button_bg_red_p.png"];
    UIImage* strechNormalImg = [imgNormal stretchableImageWithLeftCapWidth:10 topCapHeight:0];
    UIImage* strechFocusImg = [imgFocus stretchableImageWithLeftCapWidth:10 topCapHeight:0];
    
	[button setBackgroundImage:strechNormalImg forState:UIControlStateNormal];
	[button setBackgroundImage:strechFocusImg forState:UIControlStateHighlighted];
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (void)setButtonGreyBgImg:(UIButton*)button{
	    UIImage *imgNormal = [UIImage imageNamed:@"cell_button_bg_grey.png"];
	UIImage *imgFocus = [UIImage imageNamed:@"cell_button_bg_grey_p.png"];
    UIImage* strechNormalImg = [imgNormal stretchableImageWithLeftCapWidth:10 topCapHeight:0];
    UIImage* strechFocusImg = [imgFocus stretchableImageWithLeftCapWidth:10 topCapHeight:0];
    
	[button setBackgroundImage:strechNormalImg forState:UIControlStateNormal];
	[button setBackgroundImage:strechFocusImg forState:UIControlStateHighlighted];
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (void)setButtonClickable:(UIButton*)button canClick:(bool)clickable{
	button.enabled = clickable;
//	if(clickable){
//		[self setButtonGreenBgImg:button];
//	}
//	else{
//		[self setButtonGreyBgImg:button];
//	}	
}
- (void)showAlertView:(NSString*)lableTxt{
    NSString *btnStr =@"ok" ;
    if (![self isEnglish]) {
        btnStr = @"确定";
    }

    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: lableTxt
                          message: nil
                          delegate: nil
                          cancelButtonTitle:btnStr
                          otherButtonTitles:nil, nil];
    [alert show];
    //[alert release];
}

- (void)showAlertView:(NSString*)lableTxt withDelegate:(id)delegate{
    NSString *btnStr = @"ok";
    if (![self isEnglish]) {
        btnStr = @"确定";
    }
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: lableTxt
                          message: nil
                          delegate: delegate
                          cancelButtonTitle:btnStr
                          otherButtonTitles:nil, nil];
    [alert show];
   // [alert release];
}
-(void)initTextViewStyle:(UITextView*)txtView
{
    txtView.delegate=self;
    txtView.returnKeyType=UIReturnKeyDone;
    
}

-(void)initTextFiledStyle:(UITextField*)textFiled withType:(int)type{    
    textFiled.delegate = self;
    textFiled.textColor = [UIColor blackColor];
    textFiled.font = [UIFont systemFontOfSize:17.0];
    textFiled.autocorrectionType = UITextAutocorrectionTypeNo;
    textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    textFiled.returnKeyType = UIReturnKeyDone|UIReturnKeyDefault;
    if (type == TEXTFILED_NUM) {
        textFiled.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }
    else if(type == TEXTFILED_PWD) {
        textFiled.secureTextEntry = YES;
        textFiled.keyboardType = UIKeyboardTypeASCIICapable;
    }
     else if(type == TEXTFILED_ENG) {
         textFiled.keyboardType = UIKeyboardTypeASCIICapable;
     }
}

- (void)requestHttpPost:(NSString*)postUrl data:(NSString*)postData soapAction:(NSString *)action withDelegate:(id<NetConnectDelegate>)delegate withTye:(int)type
{
   
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             "<soap:Header></soap:Header><soap:Body>"
                             "<%@ xmlns:ns1=\"http://webservice.wsl.lxt.com/\">"
                             "%@"
                              "</%@>"
                             "</soap:Body>"
                             "</soap:Envelope>",action,postData,action];
    NSLog(@"调用webserivce的字符串是:%@",soapMessage);
    //请求发送到的路径
    NSString *msgLength = [NSString stringWithFormat:@"%lu", [soapMessage length]];
    NSURL *url = [NSURL URLWithString:postUrl];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *soap=[NSString stringWithFormat:@"http://webservice.wsl.lxt.com/%@",action];
    //以下对请求信息添加属性前四句是必有的，
    [urlRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [urlRequest addValue: soap forHTTPHeaderField:@"SOAPAction"];
    [urlRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    self.mNetDelegate=delegate;
    self.mReceiveData=[[NSMutableData alloc]init];
    mrequestype=type;
    //请求
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    theConnection = nil;
    if (!httpTaskRunning) {
        httpTaskRunning=YES;
        [self showWaitingBar:@"正在请求服务，请等待..."];
    }
    
}
- (void)requestHttpPost:(NSString*)postUrl data:(NSString*)postData soapAction:(NSString *)action withDelegate:(id<NetConnectDelegate>)delegate
{
    [self requestHttpPost:postUrl data:postData soapAction:action withDelegate:delegate withTye:0];
}

- (NSData*)generateFormDataFromPostDictionary:(NSDictionary*)dict withType:(int)type
{
    id boundary = @"------------0x0x0x0x0x0x0x0x";
    NSArray* keys = [dict allKeys];
    NSMutableData* result = [NSMutableData data];
    
    for (int i = 0; i < [keys count]; i++)
    {
        id value = [dict valueForKey: [keys objectAtIndex:i]];
        [result appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        if ([value isKindOfClass:[NSData class]])
        {
            // handle image data
            if (type==0) {
                NSString *formstring = [NSString stringWithFormat:IMAGE_CONTENT, [keys objectAtIndex:i]];
                [result appendData: DATA(formstring)];
                [result appendData:value];
            }
            else
            {
                NSString *formstring = [NSString stringWithFormat:File_CONTENT, [keys objectAtIndex:i]];
                [result appendData: DATA(formstring)];
                [result appendData:value];
            }
            
        }
        else
        {
            // all non-image fields assumed to be strings
            NSString *formstring = [NSString stringWithFormat:STRING_CONTENT, [keys objectAtIndex:i]];
            [result appendData: DATA(formstring)];
            [result appendData:DATA(value)];
        }
        
        NSString *formstring = @"\r\n";
        [result appendData:DATA(formstring)];
    } 
    
    NSString *formstring =[NSString stringWithFormat:@"--%@--\r\n", boundary]; 
    [result appendData:DATA(formstring)]; 
    return result; 
}

- (NSData*)generateFormDataFromPostDictionary:(NSDictionary*)dict
{
    return [self generateFormDataFromPostDictionary:dict withType:0];
}

- (void)requestHttpPost:(NSString*)postUrl data:(NSData*)postData  withDelegate:(id<NetConnectDelegate>)delegate
{
    NSString *msgLength = [NSString stringWithFormat:@"%lu", postData.length];
    NSURL *url = [NSURL URLWithString:postUrl];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    //[urlRequest addValue: @"multipart/mixed stream" forHTTPHeaderField:@"Content-Type"];
     [urlRequest addValue: @"multipart/form-data; boundary=------------0x0x0x0x0x0x0x0x" forHTTPHeaderField:@"Content-Type"];
    [urlRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [urlRequest addValue: @"application/xml; charset=utf-8, application/octet-stream, image/jpeg" forHTTPHeaderField:@"Accept"];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody: postData];
    
    self.mNetDelegate=delegate;
    self.mReceiveData=[[NSMutableData alloc]init];
    mrequestype=1;
    //请求
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    theConnection = nil;
    if (!httpTaskRunning) {
        httpTaskRunning=YES;
        [self showWaitingBar:@"正在请求服务，请等待..."];
    }

}

//如果调用有错误，则出现此信息
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    httpTaskRunning=NO;
    NSLog(@"ERROR with theConenction");
  /*  if (self.mNetDelegate) {
        [self.mNetDelegate connectFaild];
        self.mNetDelegate=nil;
    }
    else
    {*/
        UIAlertView * alert =
        [[UIAlertView alloc]
         initWithTitle:@"提示"
         message:[error description]
         delegate:nil
         cancelButtonTitle:nil
         otherButtonTitles:@"OK", nil];
        [alert show];
    //}
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    isediting=false;
}

//调用成功，获得soap信息
-(void) connection:(NSURLConnection *) connection didReceiveData:(NSData *)responseData
{
       [self.mReceiveData appendData:responseData];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:
(NSURLResponse*)response
{
    [self.mReceiveData setLength:0];
   
}

-(void)connectionDidFinishLoading:(NSURLConnection*)connection
{
    
    NSString * returnSoapXML = [[NSString alloc] initWithData:self.mReceiveData encoding:NSUTF8StringEncoding];
    NSLog(@"返回的soap信息是：%@",returnSoapXML);
    if (mrequestype==1) {
        if (self.mNetDelegate)
        {
            [self.mNetDelegate receiveMsg:returnSoapXML];
        }
    }
    else
    {
        if (mrequestype==0)
        {
            httpTaskRunning=NO;
        }
        NSRange index=[returnSoapXML rangeOfString:@"<soap:Body>"];
        BOOL isOk=false;
        if (index.location>0&&index.length>0) {
            returnSoapXML=[returnSoapXML substringFromIndex:index.location];
            index=[returnSoapXML rangeOfString:@"<ns1:out>"];
            if (index.location>0&&index.length>0)
            {
                returnSoapXML=[returnSoapXML substringFromIndex:index.location+index.length];
                index=[returnSoapXML rangeOfString:@"</ns1:out>"];
                if (index.location>0&&index.length>0)
                {
                    returnSoapXML=[returnSoapXML substringToIndex:index.location];
                    //NSLog(@"返回的String信息是：%@",returnSoapXML);
                    isOk=YES;
                }
            }
        }
        
        if (self.mNetDelegate&&isOk) {
            [self.mNetDelegate receiveMsg:returnSoapXML];
        }
        else
        {
            NSLog(@"返回的soap信息是：%@",returnSoapXML);
            [self showAlertView:@"服务器访问出现异常，请检查调用是否正常!"];
        }
    }
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	// the user pressed the "Done" button, so dismiss the keyboard
	[textField resignFirstResponder];
	return YES;
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //NSLog(@" word is %@",text);
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
@end
