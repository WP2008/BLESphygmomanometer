//
//  CheckMainViewController.h
//  ruibaoxueya
//
//  Created by zbf on 14-4-17.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "BaseNetViewController.h"
#import "CoreBluetooth/CoreBluetooth.h"
#import "SendHelper.h"
#import "CheckSetMainViewController.h"
@interface CheckMainViewController : BaseNetViewController<CBCentralManagerDelegate,CBPeripheralDelegate,UIAlertViewDelegate,SendBianDelegate>
{
      BOOL mIsLoad;
    NSMutableArray *peripheralArray ;
     NSMutableArray *peripheralNameArray ;
    CBPeripheral *mperipheral;
    int mstate;
    int mxintiaostate;
    int mtype;
    SendHelper *msHelper;
    CBCharacteristic *mCBCharacteristicR ;
    CBCharacteristic *mCBCharacteristicW ;
    int sendType;
    
    
    Byte cmd_connect;
    Byte cmd_get_devid;
	Byte cmd_set_rtc_time;
	Byte cmd_set_devname;
	Byte cmd_get_recond;
	Byte cmd_dev_close_connect;
	Byte cmd_get_dianliang;
	Byte cmd_get_recond_info;//cmd_get_recond的应答
	Byte cmd_login_finish;
	
	
	Byte cmd_set_devid;
	Byte cmd_set_devmax;
	Byte cmd_set_open_baitian;
	Byte cmd_set_open_baitian_time;
	Byte cmd_set_open_wanshang;
	Byte cmd_set_open_wanshang_time;
	Byte cmd_set_finish;
	
	Byte cmd_get_devname;
	
	Byte cmd_dev_start;
	Byte cmd_dev_stop;
	Byte cmd_dev_close;
    
	Byte cmd_get_XiuDaiYa;
    int mdianliang;
    int misChongDian;

    int mxiudaiya;

    int mstartType;
    BOOL misStop;
    NSData *mSendData;
    BOOL misNew;
    NSTimer   *showTimer ;
    int errcount;
    CheckSetMainViewController* mbianchengview;
    int mdianliangindex;
    BOOL misBianChengIng;
    BOOL misLonginOk;
    BOOL misXiuDaiYa;
    NSString *mDevDisconnect;
    NSString *mIsLogining;
    NSString *mIsMeasing;
    NSString *mIsBianCheng;
    NSString *mNoBPFind;
    int timeIndex;
    int timeIndexEx;
    BOOL isfirst;
    BOOL isCanBianCheng;
}

@property(retain,nonatomic)CBCentralManager *cbCentralMgr;
@property(retain,nonatomic)IBOutlet UIImageView *mBg;
@property(retain,nonatomic)IBOutlet UIImageView *mLink;
@property(retain,nonatomic)IBOutlet UIImageView *mDingLing;
@property(retain,nonatomic)IBOutlet UIImageView *mXinTiao;
@property(retain,nonatomic)IBOutlet UILabel *mXiuDaiYa;
@property(retain,nonatomic)IBOutlet UILabel *mShouSuoYa;
@property(retain,nonatomic)IBOutlet UILabel *mShuZhangYa;
@property(retain,nonatomic)IBOutlet UILabel *mXinLv;
@property(retain,nonatomic)IBOutlet UILabel *mShouSuoYaUnit;
@property(retain,nonatomic)IBOutlet UILabel *mShuZhangYaUint;
@property(retain,nonatomic)IBOutlet UILabel *mXinLvUnit;
@property(retain,nonatomic)IBOutlet UILabel *mLevel;
@property(retain,nonatomic)IBOutlet UIButton *mBtnCheck;
@property(retain,nonatomic)IBOutlet UIImageView *mlunpanbg;
@property(retain,nonatomic)IBOutlet UIImageView *mqiyabg;
@property(retain,nonatomic)IBOutlet UIImageView *mrecordbg;
@property(retain,nonatomic)IBOutlet UIImageView *mchongdianbg;
@property(retain,nonatomic)IBOutlet UIImageView *mDianLingbg;
@property(retain,nonatomic)IBOutlet UILabel *mlink;
@property(retain,nonatomic)IBOutlet UILabel *mconnect;
@property(retain,nonatomic)IBOutlet UILabel *mpercent;
@property(retain,nonatomic) IBOutlet UILabel *mTitle;
-(IBAction)btn_close:(id)sender;
-(IBAction)btn_biancheng:(id)sender;
-(IBAction)btn_check:(id)sender;
-(void)changState:(int)state;
-(void)changeBg:(int)type;
-(void)sendData:(NSData *)valData;
-(void)initSet;
@end
