//
//  BaseNetViewController.h
//  JeffreyPrj
//
//  Created by zhao on 12-3-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MBProgressHUD.h"
#import "SysConfig.h"
#import "EGORefreshTableHeaderView.h"
#define TYPEBAR_INFORMATION 1
#define TYPEBAR_WARNING     2

#define TEXTFILED_COMMON    1
#define TEXTFILED_NUM       2
#define TEXTFILED_PWD       3
#define TEXTFILED_ENG       4


#define DATA(X) [X dataUsingEncoding:NSUTF8StringEncoding]

// Posting constants
#define IMAGE_CONTENT @"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\nContent-Type: image/jpeg\r\n\r\n"
#define File_CONTENT @"Content-Disposition: form-data; name=\"%@\"; filename=\"record.caf\"\r\nContent-Type: audio/mpeg\r\n\r\n"
#define STRING_CONTENT @"Content-Disposition: form-data; name=\"%@\"\r\n\r\n"
#define MULTIPART @"multipart/form-data; boundary=------------0x0x0x0x0x0x0x0x"

@protocol NetConnectDelegate;
@protocol PaiZhaoDelegate;
@protocol RecordDelegate;
@protocol RefreshDelegate;
@protocol SwithRefreshDelegate
-(void)swithRefreshData;
@end

@interface BaseNetViewController : UIViewController<UITextFieldDelegate,AVAudioPlayerDelegate,AVAudioRecorderDelegate, MBProgressHUDDelegate,UITextViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIScrollViewDelegate>{
      	BOOL	httpTaskRunning;
     MBProgressHUD *progressBar;
    id<NetConnectDelegate> mNetDelegate;
    NSMutableData *mReceiveData;
    NSMutableDictionary *recordSetting;
    NSString *recorderFilePath;
    
    

    int midx;
    int midy;
    bool isediting;
    
    AVAudioRecorder *recorder;
    BOOL isStartRecord;
    int mrequestype;
    float shiftBy;    //UIScrollView* mainView ;
}
@property(nonatomic,retain)id<SwithRefreshDelegate> mSwithRefreshDelegate;
@property(nonatomic,retain)id<RefreshDelegate> mRefreshDelegate;
@property(nonatomic, assign)BOOL	httpTaskRunning;
@property(nonatomic,retain)id<NetConnectDelegate> mNetDelegate;
@property(nonatomic,retain)id<PaiZhaoDelegate> mPaiZhaoDelegate;
@property(nonatomic,retain)id<RecordDelegate> mRecordDelegate;
@property(nonatomic,retain)NSMutableData *mReceiveData;
@property(nonatomic,retain)NSMutableDictionary *recordSetting;
@property(nonatomic,retain)NSString *recorderFilePath;
@property(nonatomic,retain)UIImage *imgFilePath;
-(IBAction)btn_bak:(id)sender;
- (void)showWaitingBar:(NSString*)disStr;
- (void)showCommonBar:(NSString*)disStr withType:(int)type;
- (void)setButtonGreenBgImg:(UIButton*)button;
- (void)setButtonRedBgImg:(UIButton*)button;
- (void)setButtonGreyBgImg:(UIButton*)button;
- (void)setButtonClickable:(UIButton*)button canClick: (bool)clickable;
- (void)showAlertView:(NSString*)lableTxt;
- (void)showAlertView:(NSString*)lableTxt withDelegate:(id)delegate;
- (void)requestHttpPost:(NSString*)postUrl data:(NSString*)postData soapAction:(NSString *)action withDelegate:(id<NetConnectDelegate>)delegate;
- (void)requestHttpPost:(NSString*)postUrl data:(NSString*)postData soapAction:(NSString *)action withDelegate:(id<NetConnectDelegate>)delegate withTye:(int)type;
- (void)requestHttpPost:(NSString*)postUrl data:(NSData*)postData  withDelegate:(id<NetConnectDelegate>)delegate;
- (NSData*)generateFormDataFromPostDictionary:(NSDictionary*)dict;
- (NSData*)generateFormDataFromPostDictionary:(NSDictionary*)dict withType:(int)type;
-(void)initTextFiledStyle:(UITextField*)textFiled withType:(int)type;
-(void)maintainVisibityofControl:(UIControl *)control offset:(float) offset;
-(void)animation;
-(void)pageAnimation;
-(void)waitAnimation;
-(void)openWindow:(UIViewController*)window;
-(void)closeMe;
-(void)initTextViewStyle:(UITextView*)txtView;
-(void)paiZhao;
-(void)photoImg;
-(BOOL)prepareToRecord;
-(void)startrecorder;
-(void)stopRecording;
-(BOOL)strIsEqual:(NSString *)str1 equal:(NSString *)str2;
- (void) sendSms:(NSString *)phoneNumber;
- (void) makeCall:(NSString *)phoneNumber;
- (NSString *)stringFromDate:(NSDate *)date;
- (NSDate *)dateFromString:(NSString *)dateString;
-(NSString*)dataFilePath:(NSString *)fileName;
-(void)deleteFile:(NSString*)fileName;
-(BOOL)isFileExist:(NSString *)name;
- (NSString *)subDateFromDate:(NSString *)date;
-(NSString*)dataFilePath;
-(BOOL)isEnglish;
@end
@protocol NetConnectDelegate
-(void)connectFaild;
-(void)receiveMsg:(NSString *)msg;
@end
@protocol PaiZhaoDelegate
-(void)receiveImg:(UIImage*)image;
@end
@protocol RecordDelegate
-(void)receiveRecord:(NSString *)recordFilePath;
@end
@protocol RefreshDelegate
-(void)refreshData;
@end

