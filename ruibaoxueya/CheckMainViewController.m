//
//  CheckMainViewController.m
//  ruibaoxueya
//
//  Created by zbf on 14-4-17.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "CheckMainViewController.h"
#import "OxyCheck.h"
#import "DateInfo.h"
#import "AdInfo.h"
#import "AdInfoManager.h"

#import "DevManager.h"
#import "QRHosInfo.h"
//static NSString *const kCharacteristicUUID = @"49535343-ACA3-481C-91EC-D85E28A60318";

//static NSString *const kServiceUUID = @"49535343-FE7D-4AE5-8FA9-9FAFD205E455";

static NSString *const kCharacteristicUUIDR = @"FFF1";
static NSString *const kCharacteristicUUIDW = @"FFF2";
static NSString *const kServiceUUID = @"FFF0";
@interface CheckMainViewController ()

@end

@implementation CheckMainViewController
@synthesize cbCentralMgr;
@synthesize mBtnCheck;
@synthesize mDingLing;
@synthesize mLevel;
@synthesize mLink;
@synthesize mShouSuoYa;
@synthesize mShouSuoYaUnit;
@synthesize mShuZhangYa;
@synthesize mShuZhangYaUint;
@synthesize mXinLv;
@synthesize mXinLvUnit;
@synthesize mXinTiao;
@synthesize mXiuDaiYa;
@synthesize mBg;
@synthesize mrecordbg;
@synthesize mqiyabg;
@synthesize mlunpanbg;
@synthesize mchongdianbg;
@synthesize mpercent;
@synthesize mconnect;
@synthesize mlink;
@synthesize mTitle;
@synthesize mDianLingbg;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        peripheralArray = [[NSMutableArray alloc] init];
        peripheralNameArray= [[NSMutableArray alloc] init];
        self.cbCentralMgr = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        self.cbCentralMgr.delegate = self;
        msHelper=[[SendHelper alloc]init];
        
        cmd_connect=(Byte) 0x10;
        cmd_get_devid=(Byte) 0x11;
        cmd_set_rtc_time=(Byte) 0x12;
        cmd_set_devname=(Byte) 0x13;
        cmd_get_recond=(Byte) 0x14;//发送获取记录命令
        cmd_dev_close_connect=(Byte) 0x1a;
        cmd_get_dianliang=(Byte) 0x31;
        cmd_get_recond_info=(Byte) 0x30;//cmd_get_recond的应答
        cmd_login_finish=(Byte) 0x3a;
        
        
        cmd_set_devid=(Byte) 0x11;
        cmd_set_devmax=(Byte) 0x20;
        cmd_set_open_baitian=(Byte) 0x21;
        cmd_set_open_baitian_time=(Byte) 0x22;
        cmd_set_open_wanshang=(Byte) 0x23;
        cmd_set_open_wanshang_time=(Byte) 0x24;
        cmd_set_finish=(Byte) 0x2a;
        
        cmd_get_devname=(Byte) 0x30;
        
        cmd_dev_start=(Byte) 0x40;
        cmd_dev_stop=(Byte) 0x41;
        cmd_dev_close=(Byte) 0x42;
        
        cmd_get_XiuDaiYa=(Byte) 0x50;
        
        mdianliangindex=0;
        if ([self isEnglish]) {
              mDevDisconnect=@"BP monitor is disconnected ";
        }else
        {
            mDevDisconnect=@"设备未连接";
        }
        
        if ([self isEnglish]) {
            mIsMeasing=@"Measing,please wait a moment ";
        }else
        {
            mIsMeasing=@"正常测量,请稍等";
        }

        if ([self isEnglish]) {
            mIsLogining=@"Loginning, please wait a moment ";
        }else
        {
            mIsLogining=@"正在登录，请稍等";
        }
        if ([self isEnglish]) {
            mIsBianCheng=@"Programming,please wait a moment ";
        }else
        {
            mIsBianCheng=@"正在编程,请稍等";
        }

        if ([self isEnglish]) {
            mNoBPFind=@"Connect BT failed!";
        }else
        {
            mNoBPFind=@"连接设备失败!";
        }
        isCanBianCheng=true;
    }
    return self;
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
        NSLog(@"centralManagerDidUpdateState");
    
        switch (central.state) {
                         //判断状态开始扫瞄周围设备 第一个参数为空则会扫瞄所有的可连接设备  你可以
                         //指定一个CBUUID对象 从而只扫瞄注册用指定服务的设备
                        //scanForPeripheralsWithServices方法调用完后会调用代理CBCentralManagerDelegate的
                        //- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI方法
                     case CBCentralManagerStatePoweredOn:
                        [cbCentralMgr scanForPeripheralsWithServices:Nil options:Nil];
                         break;
            
                    default:
                        if ([self isEnglish]) {
                            [self showAlertView:@"Please Start BP monitor"];
                        }else
                        {
                            [self showAlertView:@"蓝牙未打开，需要开启蓝牙"];
                        }
                
                        break;
           }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI

{
    NSLog(@"didDiscoverPeripheral");
    if (peripheral)
  {
    // peripheral.identifier
      
      NSString * name =  peripheral.name ;
      if(name&&name.length>1)
      {
          DevManager *sql=[[DevManager alloc]init];
          sql.path=[self dataFilePath];
          [ sql createDb];
          QRHosInfo *devinfo=[sql queryInfoByName:name];
          if (devinfo==nil) {
              devinfo=[[QRHosInfo alloc]init];
              devinfo.mUserName=name;
              devinfo.mID=[sql getMaxID];
              devinfo.mID= [sql insert:devinfo];
          }
          
          NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
          NSString *mblueidentifier=[prefs objectForKey:@"bluename"];
          if (mblueidentifier) {
              if ([self strIsEqual:mblueidentifier equal:name]) {
                  //[cbCentralMgr stopScan];
                  
                  [central connectPeripheral:peripheral options:Nil];
                  // mperipheral = peripheral;
                  
                  mperipheral = peripheral;
                  devinfo.mUserSex=1;
                  [sql update:devinfo];
              }
              else
              {
                  /*
                   [prefs setObject:name forKey:@"bluename"];
                   
                   [prefs synchronize];
                   [cbCentralMgr stopScan];
                   if (!peripheral.isConnected) {
                   [central connectPeripheral:peripheral options:Nil];
                   }*/
              }
          }
          else
          {
              [prefs setObject:name forKey:@"bluename"];
              [prefs synchronize];
              devinfo.mUserSex=1;
              [sql update:devinfo];
              // [cbCentralMgr stopScan];
              //if (!peripheral.isConnected) {
              
              
              [central connectPeripheral:peripheral options:Nil];
              //}
              mperipheral = peripheral;
          }
      }
    }
    else
    {
      
        [self showAlertView:mNoBPFind];
        
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral

{
    
    if (mperipheral) {
        NSLog(@"didConnectPeripheral");
        mperipheral.delegate = self;
        
        //此时设备已经连接上了  你要做的就是找到该设备上的指定服务 调用完该方法后会调用代理CBPeripheralDelegate（现在开始调用另一个代理的方法了）的
        //- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
        [mperipheral discoverServices:nil];
    }
    else
    {
        
        [self showAlertView:mNoBPFind];
        
    }
}

-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error

{
    
    NSLog(@"didDiscoverServices");

    if (error==nil) {
                 //在这个方法中我们要查找到我们需要的服务  然后调用discoverCharacteristics方法查找我们需要的特性
                 //该discoverCharacteristics方法调用完后会调用代理CBPeripheralDelegate的
                 //- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
              BOOL isfind=false;
               for (CBService *service in peripheral.services) {
                   
                   NSLog(@"Service found with UUID: %@\n", service.UUID);
                   if ([service.UUID isEqual:[CBUUID UUIDWithString:kServiceUUID]]) {
                       [peripheral discoverCharacteristics:nil forService:service];
                       isfind=YES;
                       break;
                   }
               }
        if (!isfind) {
             [self showAlertView:mNoBPFind];
        }
        
    }
    else
    {
        
        [self showAlertView:mNoBPFind];
        
    }
    
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error

{
     NSLog(@"didDiscoverCharacteristicsForService,serverUIID:%@",service.UUID);
    if (error==nil) {
        
        
        //在这个方法中我们要找到我们所需的服务的特性 然后调用setNotifyValue方法告知我们要监测这个服务特性的状态变化
                 //当setNotifyValue方法调用后调用代理CBPeripheralDelegate的- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
        for (CBCharacteristic *characteristic in service.characteristics) {
            NSString *des= characteristic.description;
            NSLog(@"%@",des);
           if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:kCharacteristicUUIDR]]) {
                [peripheral setNotifyValue:YES forCharacteristic:characteristic];
                 mCBCharacteristicR=characteristic;
           }
           else  if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:kCharacteristicUUIDW]]) {
              // [peripheral setNotifyValue:YES forCharacteristic:characteristic];
               mCBCharacteristicW=characteristic;
               NSData* valData = [msHelper getConnectCmd];
               sendType=1;
               errcount=0;
               [self sendData:valData];
           }
            NSLog(@"didDiscoverCharacteristicsForService,characteristicCBUIID:%@",characteristic.UUID);
        }
        
        if (mCBCharacteristicR==nil||mCBCharacteristicW==nil) {
             [self showAlertView:mNoBPFind];
        }
        else
        {
            mLink.image=[UIImage imageNamed:@"link_on"];
            mDianLingbg.image=[UIImage imageNamed:@"dianliangbg"];
            if ([self isEnglish]) {
                mlink.text=@"Connected";
            }
            else
            {
                mlink.text=@"已连接";
            }
            mlink.textColor=[[UIColor alloc] initWithRed:0.478 green:0.710 blue:0.643 alpha:1.0];
            mpercent.textColor=[[UIColor alloc] initWithRed:0.478 green:0.710 blue:0.643 alpha:1.0];
        }
    }
    else
    {
         [self showAlertView:mNoBPFind];
    }
    
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
     NSLog(@"didUpdateNotificationStateForCharacteristic,characteristicCBUIID:%@",characteristic.UUID);
     if (error==nil) {
            //调用下面的方法后 会调用到代理的- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
       
         if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:kCharacteristicUUIDR]]) {
             //[peripheral readValueForCharacteristic:characteristic];
             mCBCharacteristicR=characteristic;
         }
         else  if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:kCharacteristicUUIDW]]) {
          
             mCBCharacteristicW=characteristic;
            
         }
      
     }
  }

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error

{
   // NSLog(@"didWriteValueForCharacteristic,characteristicCBUIID:%@",characteristic.UUID);
    if (error==nil) {
        errcount=0;
        //[peripheral readValueForCharacteristic:mCBCharacteristicR];
        //[peripheral re]
    }
    else
    {
        if (sendType==53) {
            if ([self isEnglish]) {
                 [self showAlertView:@"DB is Shutting Off!"];
            }
            else
            {
                [self showAlertView:@"设备已关闭"];
            }
            [self.cbCentralMgr cancelPeripheralConnection:mperipheral];
            mperipheral=nil;
            mCBCharacteristicW =nil;
            if (mbianchengview) {
                [mbianchengview sendOk];
                mbianchengview=nil;
                misBianChengIng=NO;
            }
        }
        else
        {
            NSLog(@"%@",error.description);
            if (errcount==0&&mSendData) {
                errcount+=1;
                [self sendData:mSendData withType:1];
            }
            else
            {
              
                if (mbianchengview) {
                    [mbianchengview sendOk];
                    mbianchengview=nil;
                    misBianChengIng=NO;
                }
                if ([self isEnglish]) {
                    [self showAlertView:@"BP monitor is disconnected!"];
                }
                else
                {
                    [self showAlertView:@"通讯出现异常，发送命令失败，请重新启动"];
                }
            }
        }
    }
    
}
-(void)getRecordInfo:(Byte *)data withIndex:(int)index
{
    AdInfoManager *sql=[[AdInfoManager alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *uid=[prefs objectForKey:@"id"];
    sql.path=[self dataFilePath];
       AdInfo *mInfo=[[AdInfo alloc]init];
    int value=data[3+index]&0xff;
    int value1=data[4+index]&0xff;
   
    
    mInfo.mHighSpO2=value*256+value1;
    value=data[5+index]&0xff;
    value1=data[6+index]&0xff;
    mInfo.mMinSpO2=value*256+value1;
    value=data[7+index]&0xff;
    value1=data[8+index]&0xff;
    mInfo.mPulse=value*256+value1;
    int year=data[9+index]&0xff;
    year+=2000;
    int month=data[10+index]&0xff;
    int day=data[11+index]&0xff;
    mInfo.mDate=year*10000+month*100+day;
    int hour=data[12+index]&0xff;
    int minite=data[13+index]&0xff;
    mInfo.mTime=hour*10000+minite*100;
  
    DateInfo *dateinfo=[[DateInfo alloc]init];
    [dateinfo initDate:mInfo.mDate withTime:mInfo.mTime];
    mInfo.mInfo=[dateinfo getDateTimeString];
    mInfo.mUserID=[uid intValue];
    mInfo.mState=1;
    dateinfo=[[DateInfo alloc]init];
    
    //if (dateinfo.mDate>=mInfo.mDate) {
        mInfo.mType=10;
    //}
    //else
   // {
     //   mInfo.mType=0;
    //}
    mInfo.MTiWei=((data[index+15]&0xf0)>>4);
    if ([self isEnglish]) {
        if(mInfo.MTiWei==0x0)
        {
            mInfo.mTiWeiName=@"Lying";
        }
        else  if(mInfo.MTiWei==0x01)
        {
            mInfo.mTiWeiName=@"Stand/Sit";
        }
        else  if(mInfo.MTiWei==0x02)
        {
            mInfo.mTiWeiName=@"Slight Movement";
        }
        else  if(mInfo.MTiWei==0x03)
        {
            mInfo.mTiWeiName=@"Havey Movement";
        }
        mInfo.MTestType=(int)(data[index+15]&0x0f);
        if(mInfo.MTestType==0x00)
        {
            mInfo.mTestName=@"Automatic";
        }
        else  if(mInfo.MTestType==0x01)
        {
            mInfo.mTestName=@"Manual";
        }
        else  if(mInfo.MTestType==0x02)
        {
            mInfo.mTestName=@"Manual";
        }

    }
    else
        
    {
        if(mInfo.MTiWei==0x0)
        {
            mInfo.mTiWeiName=@"平躺";
        }
        else  if(mInfo.MTiWei==0x01)
        {
            mInfo.mTiWeiName=@"静立/坐";
        }
        else  if(mInfo.MTiWei==0x02)
        {
            mInfo.mTiWeiName=@"轻微运动";
        }
        else  if(mInfo.MTiWei==0x03)
        {
            mInfo.mTiWeiName=@"剧烈运动";
        }
        mInfo.MTestType=(int)(data[index+15]&0x0f);
        if(mInfo.MTestType==0x00)
        {
            mInfo.mTestName=@"编程测量";
        }
        else  if(mInfo.MTestType==0x01)
        {
            mInfo.mTestName=@"手动测量";
        }
        else  if(mInfo.MTestType==0x02)
        {
            mInfo.mTestName=@"手动测量";
        }
    
    }
    mInfo.mCreateUserID=(int)(data[index+14]&0xff);
    
    
    mInfo.mState=1;
    
    
    [sql insert:mInfo];
    mShouSuoYa.text=[NSString stringWithFormat:@"%d",mInfo.mHighSpO2];
    mShuZhangYa.text=[NSString stringWithFormat:@"%d",mInfo.mMinSpO2];
    mXinLv.text=[NSString stringWithFormat:@"%d",mInfo.mPulse];
    OxyCheck *mcheck=[[OxyCheck alloc]init];
    int type=[mcheck check:mInfo];
    [self changeBg:type];
    
  
    NSString *mind1=[prefs objectForKey:@"alert_shousuo_value"];
    int shoushu=0;
    int shuzhang=0;
    if (mind1) {
        shoushu=[mind1 intValue]+140;
    }else
    {
        shoushu=140;
    }
    mind1=[prefs objectForKey:@"alert_shuzhang_value"];
    if (mind1) {
        shuzhang=[mind1 intValue]+90;
    }else
    {
        shuzhang=90;
    }
    mind1=[prefs objectForKey:@"alert_state1_value"];
     if ([self isEnglish]) {
         if (mind1) {
             if ([mind1 intValue]==1) {
                 if ( mInfo.mHighSpO2>=shoushu&&mInfo.mMinSpO2>=shuzhang) {
                     [self showAlertView:@"High Sys./Dia.reading."];
                 }else  if ( mInfo.mHighSpO2>=shoushu)
                 {
                     [self showAlertView:@"High Sys.Reading"];
                 }
                 else  if ( mInfo.mMinSpO2>=shuzhang)
                 {
                     [self showAlertView:@"igh Dia.reading"];
                 }
             }
         }
         
         mind1=[prefs objectForKey:@"alert_state_value"];
         if (mind1) {
             if ([mind1 intValue]==1) {
                 if (mInfo.mHighSpO2==0||mInfo.mMinSpO2==0||mInfo.mPulse==0||mInfo.mCreateUserID!=0) {
                     [self showAlertView:[NSString stringWithFormat:@"Measurement failed, EC:%d",mInfo.mCreateUserID]];
                 }
             }
         }

     }
    else
        
    {
        if (mind1) {
            if ([mind1 intValue]==1) {
                if ( mInfo.mHighSpO2>=shoushu&&mInfo.mMinSpO2>=shuzhang) {
                    [self showAlertView:@"血压偏高"];
                }else  if ( mInfo.mHighSpO2>=shoushu)
                {
                    [self showAlertView:@"收缩压偏高"];
                }
                else  if ( mInfo.mMinSpO2>=shuzhang)
                {
                    [self showAlertView:@"舒张压偏高"];
                }
            }
        }
        
        mind1=[prefs objectForKey:@"alert_state_value"];
        if (mind1) {
            if ([mind1 intValue]==1) {
                if (mInfo.mHighSpO2==0||mInfo.mMinSpO2==0||mInfo.mPulse==0||mInfo.mCreateUserID!=0) {
                    [self showAlertView:[NSString stringWithFormat:@"测量失败,错误码:%d",mInfo.mCreateUserID]];
                }
            }
        }
    }
    
}

-(UIImage *)getIcon:(int )dianliang
{
    if(dianliang>100)
    {
        dianliang=100;
    }
    if(dianliang<0)
    {
        dianliang=0;
    }
    
    float scaleFactor = [[UIScreen mainScreen] scale];
    CGSize size = CGSizeMake(100, 28);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef micon=CGBitmapContextCreate(NULL, size.width*scaleFactor, size.height*scaleFactor, 8, size.width*scaleFactor*4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextScaleCTM(micon, scaleFactor, scaleFactor);
    CGContextSetRGBFillColor(micon,0.92, 0.92, 0.92, 0);
   // CGContextSetRGBStrokeColor(micon, 0.0, 1.0, 0.0, 1.0);
    CGContextSetLineWidth(micon, 1);
    CGRect rect=CGRectMake(0, 0, size.width, size.height);
    CGContextAddRect(micon, rect);
    CGContextDrawPath(micon, kCGPathFill);
    
    UIColor *aColor = [UIColor colorWithRed:0.45 green:0.71 blue:0.64 alpha:1];
    CGContextSetFillColorWithColor(micon, aColor.CGColor);//填充颜色
    CGContextSetLineWidth(micon, 1.0);//线的宽度
    
    int width=dianliang;
    rect=CGRectMake(0, 0, width, size.height);
    CGContextAddRect(micon, rect);
    CGContextDrawPath(micon, kCGPathFill);
    
    //kCGPathFill填充非零绕数规则,kCGPathEOFill表示用奇偶规则,kCGPathStroke路径,kCGPathFillStroke路径填充,kCGPathEOFillStroke表示描线，不是填充
   
    CGImageRef img=CGBitmapContextCreateImage(micon);
    UIImage *mImg= [UIImage imageWithCGImage:img ];
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(micon);
    CGImageRelease(img);
    
    UIGraphicsBeginImageContext(CGSizeMake(size.width/2, size.height/2));
    [mImg drawInRect:CGRectMake(0, 0, size.width/2, size.height/2)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
    //return mImg;
}

-(void)sendData:(NSData *)valData withType:(int)type
{
    if (mperipheral&&valData&&mCBCharacteristicW) {
        if (type==0) {
            mSendData=valData;
            misNew=YES;
        }
        [mperipheral writeValue:valData forCharacteristic:mCBCharacteristicW type:CBCharacteristicWriteWithResponse];
    }
    else
    {
        [self initSet];
    }
}

-(void)sendData:(NSData *)valData
{
    [self sendData:valData withType:0];
}
-(void)setMaxQiYa
{
    misBianChengIng=YES;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *max=[prefs objectForKey:@"max"];
    if (max) {
        NSData* valData = [msHelper setMax:[max intValue]];
        sendType=20;
        [self sendData:valData];
    }
    else
    {
        if (mbianchengview) {
            [mbianchengview sendOk];
            mbianchengview=nil;
        }
        misBianChengIng=NO;
        if ([self isEnglish]) {
            [self showAlertView:@"Args is Error!" ];
        }
        else
        {
            [self showAlertView:@"编程设置不正确，未设置充气" ];
        }
    }
}

-(void)setBaiTian
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *value=[prefs objectForKey:@"openbaitian"];
    if (value) {
        if ([value intValue]==1) {
            NSData* valData = [msHelper setOpenBaiTian:YES];
            sendType=21;
            [self sendData:valData];
        }
        else
        {
            NSData* valData = [msHelper setOpenBaiTian:NO];
            sendType=21;
            [self sendData:valData];
        }
    }
    else
    {
        NSData* valData = [msHelper setOpenBaiTian:NO];
        sendType=21;
        [self sendData:valData];
    }
}

-(void)setBaiTianTime
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *value=[prefs objectForKey:@"openbaitiantimes"];
    if (value) {
        int s=[value intValue];
        value=[prefs objectForKey:@"openbaitiantimee"];
        int e=[value intValue];
        value=[prefs objectForKey:@"openbaitiantimeinel"];
        int ine=[value intValue];
        
        NSData* valData = [msHelper setBaiTianTime:s withEndHour:e withInternel:ine];
        sendType=24;
        [self sendData:valData];
       
    }
    else
    {
        if (mbianchengview) {
            [mbianchengview sendOk];
            mbianchengview=nil;
        }
        misBianChengIng=NO;
        if ([self isEnglish]) {
            [self showAlertView:@"Args is Error!" ];
        }
        else
        {
            [self showAlertView:@"编程设置不正确，未设置白天参数" ];
        }
    }
    
}

-(void)setWanShang
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *value=[prefs objectForKey:@"openwanshang"];
    if (value) {
        if ([value intValue]==1) {
            NSData* valData = [msHelper setOpenWanShang:YES];
            sendType=21;
            [self sendData:valData];
        }else
        {
            NSData* valData = [msHelper setOpenWanShang:NO];
            sendType=21;
            [self sendData:valData];
        }
    }
    else
    {
        NSData* valData = [msHelper setOpenWanShang:NO];
        sendType=21;
        [self sendData:valData];
    }
}

-(void)setWanShangTime
{
   
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *value=[prefs objectForKey:@"openwanshangtimes"];
    if (value) {
        int s=[value intValue];
        value=[prefs objectForKey:@"openwanshangtimee"];
        int e=[value intValue];
        value=[prefs objectForKey:@"openwanshangtimeinel"];
        int ine=[value intValue];
        
        NSData* valData = [msHelper setWanShangTime:s withEndHour:e withInternel:ine];
        sendType=24;
        [self sendData:valData];
        
    }
    else
    {
        if (mbianchengview) {
            [mbianchengview sendOk];
            mbianchengview=nil;
        }
        misBianChengIng=NO;
        if ([self isEnglish]) {
            [self showAlertView:@"Args is Error!" ];
        }
        else
        {
            [self showAlertView:@"编程设置不正确，未设置晚上参数" ];
        }
    }
}

-(void)startBianChang
{
    [self setMaxQiYa];
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
   
     if (error)
     {
         NSLog(@"%@",error.description);
         if (errcount==0&&mSendData) {
             errcount+=1;
             [self sendData:mSendData withType:1];
         }
         else
         {
             if (mbianchengview) {
                 [mbianchengview sendOk];
                 mbianchengview=nil;
                  misBianChengIng=NO;
             }
             if ([self isEnglish]) {
                 [self showAlertView:@"Connect is Error，please ReStart"];
             }else
             {
                 [self showAlertView:@"通讯出现异常，无法读取数据，请重新启动"];
             }
              timeIndex=50;
             [self initSet];
         }
     }
     else
     {
          misXiuDaiYa=false;
         NSData *rvalue= characteristic.value;
         if (rvalue&&rvalue.length>=5) {
            
             mSendData=nil;
             [msHelper writeLog:rvalue];
             
              Byte* mdatas=(Byte*)rvalue.bytes;
             if (mdatas[0]==0x5a) {
                 
                 NSData* crc=[msHelper getCrt:mdatas withLend:(rvalue.length-2)];
                 Byte * crcs=(Byte*)crc.bytes;
                 if (crcs[0]!=mdatas[rvalue.length-2]||crcs[1]!=mdatas[rvalue.length-1]) {
                     NSLog(@" Crc is error");
                     return;
                 }
                 if (mdatas[2]==cmd_connect) {
                     NSLog(@" 接收到捂手完成命令，开始发送获取设备id命令");
                     NSData* valData = [msHelper getDevIdCmd];
                     sendType=2;
                     [self sendData:valData];
                 }
                 else  if (mdatas[2]==cmd_get_dianliang)
                 {
                     mdianliang=mdatas[3]&0xff;
                     misChongDian=mdatas[4]&0xff;
                     NSLog(@" 获取到电量:%d",mdianliang);
                     mdianliangindex+=1;
                     if (mdianliangindex%3==1&&!misBianChengIng) {
                         NSData* valData = [msHelper getDingLingCmd];
                         sendType=3;
                         [self sendData:valData withType:1];
                     }
                     
                     mpercent.text=[NSString stringWithFormat:@"%d%@",mdianliang,@"%"];
                     if (misChongDian==1) {
                         mchongdianbg.hidden=NO;
                         mDingLing.hidden=YES;
                     }
                     else
                     {
                         mchongdianbg.hidden=YES;
                         mDingLing.hidden=NO;
                         mDingLing.image=[self getIcon:mdianliang];
                     }
                 }
                 else  if (mdatas[2]==cmd_get_devid)
                 {
                     NSLog(@" 接收到获取设备id命令 开发发送设置设备名称命令");
                     if (rvalue.length==7) {
                         if (mdatas[4]==0x00) {
                             isCanBianCheng=false;
                         }
                     }
                     NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                     NSData* valData = [msHelper setDavName:[prefs objectForKey:@"name"]];
                     sendType=4;
                     [msHelper writeLog:valData withTye:0];
                     [self sendData:valData];
                 }
                 else  if (mdatas[2]==cmd_set_devname)
                 {
                     NSLog(@" 接收到设置设备名称命令,开发发送设置rtc命令");
                     DateInfo *dateinfo=[[DateInfo alloc]init];
                     int year=dateinfo.mYear-2000;
                     
                     NSData* valData = [msHelper setRtcCmd:year withMonth:dateinfo.mMonth withDay:dateinfo.mDay withHour:dateinfo.mHour withMinite:dateinfo.mMinite];
                     sendType=5;
                     [self sendData:valData];
                 }
                 else if (mdatas[2]==cmd_set_rtc_time)
                 {
                     NSLog(@" 接收到设置设置rtc命令,开发发送获取记录命令");
                     AdInfoManager *sql=[[AdInfoManager alloc]init];
                     NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                     NSString *uid=[prefs objectForKey:@"id"];
                     sql.path=[self dataFilePath];
                     NSMutableArray *musrdata= [sql queryInfoByWhere:[NSString stringWithFormat:@" mUserID= %@ and mType=10 order by mDate desc,mTime desc ",uid]];
                     NSData* valData = nil;
                     if (musrdata&&musrdata.count>0) {
                         AdInfo *info=[musrdata objectAtIndex:0] ;
                         
                         valData =[msHelper getRecordCmd:info.mYear-2000 withMonth:info.mMonth withDay:info.mDay withHour:info.mHour withMinite:info.mMinite];
                         //info=[musrdata objectAtIndex:0] ;
                     }
                     
                     if (!valData) {
                         valData = [msHelper getRecordCmd];
                     }
                     
                     sendType=6;
                     [self sendData:valData];
                 }
                 else if (mdatas[2]==cmd_get_recond_info)
                 {
                     NSLog(@" 接收到记录信息命令,开发发送获取到记录命令");
                     NSData* valData = [msHelper getRecordInfoCmd];
                     sendType=7;
                     [self sendData:valData withType:1];
                     
                     
                     [self changState:1];
                     mstartType=0;
                     if ([self isEnglish]) {
                         [mBtnCheck setTitle:@"Start" forState:UIControlStateNormal];
                     }
                     else
                     {
                         [mBtnCheck setTitle:@"启动测量" forState:UIControlStateNormal];
                         
                     }
                     timeIndex=5;
                     [mBtnCheck setBackgroundImage:[UIImage imageNamed:@"btn_start"] forState:UIControlStateNormal];
                     [self changeXinTiao:0];
                     mXiuDaiYa.text=@"0";
                     [mBtnCheck setTitleColor:[[UIColor alloc] initWithRed:0.659 green:0.659 blue:0.659 alpha:1.0] forState:UIControlStateNormal];
                     if (rvalue.length>=15)
                     {
                         [self getRecordInfo: mdatas withIndex:0];
                     }
                     
                 }
                 else if (mdatas[2]==cmd_login_finish)
                 {
                     NSLog(@" 接收到登录完成命令,开发发送登录完成命令");
                     NSData* valData = [msHelper getLoginFinishConnectCmd];
                     sendType=8;
                     [self sendData:valData];
                     misLonginOk=YES;
                     
                 }
                 else if (mdatas[2]==cmd_get_XiuDaiYa)
                 {
                     misXiuDaiYa=YES;
                     NSLog(@" 接收到袖带压信息命令,开发发送获取到袖带压信息命令");
                     NSData* valData = [msHelper getXiuDaiYaCmd ];
                     sendType=9;
                     [self sendData:valData withType:1];
                     mxiudaiya=mdatas[3]&0xff;
                     mxiudaiya=mxiudaiya*256+mdatas[4]&0xff;
                     [self changState:0];
                     mXiuDaiYa.text=[NSString stringWithFormat:@"%d",mxiudaiya];
                     int xintiao=mdatas[5]&0xff;
                     [self changeXinTiao:xintiao];
                     
                     mstartType=1;
                     if ([self isEnglish]) {
                         [mBtnCheck setTitle:@"Stop" forState:UIControlStateNormal];
                     }
                     else
                     {
                         [mBtnCheck setTitle:@"停止测量" forState:UIControlStateNormal];
                         
                     }
                     [mBtnCheck setTitleColor:[[UIColor alloc] initWithRed:0.922 green:0.847 blue:0.847 alpha:1.0] forState:UIControlStateNormal];
                     
                     [mBtnCheck setBackgroundImage:[UIImage imageNamed:@"btn_stop"] forState:UIControlStateNormal];
                 }
                 else if (mdatas[2]==cmd_get_recond)
                 {
                     NSLog(@" 接收到获取记录命令");
                     
                 }
                 else if (mdatas[2]==cmd_dev_start)
                 {
                     NSLog(@" 接收到设备启动命令");
                     if (rvalue.length==6) {
                         int flag=mdatas[3]&0xff;
                         if (flag==1) {
                             mstartType=1;
                             
                             if ([self isEnglish]) {
                                 [mBtnCheck setTitle:@"Stop" forState:UIControlStateNormal];
                             }
                             else
                             {
                                 [mBtnCheck setTitle:@"停止测量" forState:UIControlStateNormal];
                                 
                             }
                             [mBtnCheck setTitleColor:[[UIColor alloc] initWithRed:0.922 green:0.847 blue:0.847 alpha:1.0] forState:UIControlStateNormal];
                             
                             [mBtnCheck setBackgroundImage:[UIImage imageNamed:@"btn_stop"] forState:UIControlStateNormal];
                         }
                         else
                         {
                             if ([self isEnglish]) {
                                 [self showAlertView:@"Please Waiting!"];
                             }
                             else
                             {
                                 [self showAlertView:@"请稍后再启动测量!"];
                             }
                             mstartType=0;
                             timeIndex=5;
                             if ([self isEnglish]) {
                                 [mBtnCheck setTitle:@"Start" forState:UIControlStateNormal];
                             }
                             else
                             {
                                 [mBtnCheck setTitle:@"启动测量" forState:UIControlStateNormal];
                                 
                             }
                             [ mBtnCheck setBackgroundImage:[UIImage imageNamed:@"btn_start"] forState:UIControlStateNormal];
                             [mBtnCheck setTitleColor:[[UIColor alloc] initWithRed:0.659 green:0.659 blue:0.659 alpha:1.0] forState:UIControlStateNormal];
                         }
                     }
                     else
                     {
                         mstartType=1;
                         if ([self isEnglish]) {
                             [mBtnCheck setTitle:@"Stop" forState:UIControlStateNormal];
                         }
                         else
                         {
                             [mBtnCheck setTitle:@"停止测量" forState:UIControlStateNormal];
                             
                         }
                         [mBtnCheck setTitleColor:[[UIColor alloc] initWithRed:0.922 green:0.847 blue:0.847 alpha:1.0] forState:UIControlStateNormal];
                         
                         [mBtnCheck setBackgroundImage:[UIImage imageNamed:@"btn_stop"] forState:UIControlStateNormal];
                     }
                     
                 }
                 else if (mdatas[2]==cmd_dev_stop)
                 {
                     NSLog(@" 接收到设备停止命令");
                     timeIndex=5;
                     mstartType=0;
                     if ([self isEnglish]) {
                         [mBtnCheck setTitle:@"Start" forState:UIControlStateNormal];
                     }
                     else
                     {
                         [mBtnCheck setTitle:@"启动测量" forState:UIControlStateNormal];
                         
                     }
                     [ mBtnCheck setBackgroundImage:[UIImage imageNamed:@"btn_start"] forState:UIControlStateNormal];
                     [mBtnCheck setTitleColor:[[UIColor alloc] initWithRed:0.659 green:0.659 blue:0.659 alpha:1.0] forState:UIControlStateNormal];
                     
                 }
                 else if (mdatas[2]==cmd_dev_close)
                 {
                     timeIndex=50;
                     NSLog(@" 接收到设备关机命令");
                     if ([self isEnglish]) {
                         [self showAlertView:@"BP is Closing..."];
                     }
                     else
                     {
                         
                         [self showAlertView:@"设备正在关闭中"];
                     }
                     [self.cbCentralMgr cancelPeripheralConnection:mperipheral];
                     mperipheral=nil;
                     mCBCharacteristicW =nil;
                     mLink.image=[UIImage imageNamed:@"link_off"];
                     mDianLingbg.image=[UIImage imageNamed:@"dianliangbg_off"];
                     if ([self isEnglish]) {
                         mlink.text=@"Disconnected";
                     }
                     else
                     {
                         mlink.text=@"未连接";
                     }
                     mlink.textColor=[[UIColor alloc] initWithRed:0.757 green:0.757 blue:0.757 alpha:1.0];
                     mpercent.textColor=[[UIColor alloc] initWithRed:0.757 green:0.757 blue:0.757 alpha:1.0];
                     mpercent.text=@"0%";
                     mDingLing.image=[self getIcon:0];
                     [self initSet];
                 }
                 else if (mdatas[2]==cmd_dev_close_connect)
                 {
                     timeIndex=50;
                     NSLog(@" 接收到设备断开命令");
                     if ([self isEnglish]) {
                         [self showAlertView:@"BP monitor is disconnectedt"];
                     }
                     else
                     {
                         [self showAlertView:@"设备连接已经断开"];
                     }
                     mLink.image=[UIImage imageNamed:@"link_off"];
                     [self.cbCentralMgr cancelPeripheralConnection:mperipheral];
                     mperipheral=nil;
                     mCBCharacteristicW =nil;
                     mLink.image=[UIImage imageNamed:@"link_off"];
                     mDianLingbg.image=[UIImage imageNamed:@"dianliangbg_off"];
                     if ([self isEnglish]) {
                         mlink.text=@"Disconnected";
                     }
                     else
                     {
                         mlink.text=@"未连接";
                     }
                     mlink.textColor=[[UIColor alloc] initWithRed:0.757 green:0.757 blue:0.757 alpha:1.0];
                     mpercent.textColor=[[UIColor alloc] initWithRed:0.757 green:0.757 blue:0.757 alpha:1.0];
                     mpercent.text=@"0%";
                     mDingLing.image=[self getIcon:0];
                     [self initSet];
                 }
                 else if (mdatas[2]==cmd_set_finish)
                 {
                     NSLog(@" 接收编程设置完毕命令");
                     if (mbianchengview) {
                         [mbianchengview sendOk];
                         mbianchengview=nil;
                     }
                     misBianChengIng=NO;
                     [self showAlertView:@"编程设置完毕" ];
                     
                 }
                 else if (mdatas[2]==cmd_set_devmax)
                 {
                     NSLog(@" 接收到充气压设置完毕");
                     [self setBaiTian];
                     
                 }
                 else if (mdatas[2]==cmd_set_open_baitian)
                 {
                     NSLog(@" 接收到设置白天模式完毕");
                     NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                     NSString *value=[prefs objectForKey:@"openbaitian"];
                     if (value) {
                         if ([value intValue]==1) {
                             [self setBaiTianTime];
                         }
                         else
                         {
                             [self setWanShang];
                         }
                     }
                     else
                     {
                         [self setWanShang];
                     }
                 }
                 else if (mdatas[2]==cmd_set_open_baitian_time)
                 {
                     NSLog(@" 接收到设置白天时间完毕");
                     [self setWanShang];
                     
                 }
                 else if (mdatas[2]==cmd_set_open_wanshang)
                 {
                     NSLog(@" 接收到设置晚上模式完毕");
                     NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                     NSString *value=[prefs objectForKey:@"openwanshang"];
                     if (value) {
                         if ([value intValue]==1) {
                             [self setWanShangTime];
                         }
                         else
                         {
                             NSData* valData = [msHelper getSetFinishCmd];
                             sendType=28;
                             [self sendData:valData];
                         }
                     }
                     else
                     {
                         NSData* valData = [msHelper getSetFinishCmd];
                         sendType=28;
                         [self sendData:valData];
                     }
                 }
                 else if (mdatas[2]==cmd_set_open_wanshang_time)
                 {
                     NSLog(@" 接收到设置晚上时间完毕");
                     NSData* valData = [msHelper getSetFinishCmd];
                     sendType=28;
                     [self sendData:valData];
                     
                 }
             }
         }
     }
    
   
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.navigationController!=Nil) {
        [self.navigationController setNavigationBarHidden:YES];
        
    }
    if (!mIsLoad) {
        mIsLoad=YES;
        if ([self isEnglish]) {
            mTitle.text=@"Meas";
            mXinLvUnit.text=@"HR";
            mShouSuoYaUnit.text=@"Sys.";
            mShuZhangYaUint.text=@"Dia.";
            mlink.text=@"Disconnect";
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        NSData* valData = [msHelper getCloseCmd];
        sendType=53;
        [self sendData:valData];
        [self initSet];
    }
   

}

-(IBAction)btn_close:(id)sender
{
    
    if (mCBCharacteristicW&&mperipheral){
        if (!misLonginOk) {
            [self showAlertView:mIsLogining];
            return;
        }
        if (misBianChengIng) {
            [self showAlertView:mIsBianCheng];
            return;
        }

        if (mstartType==1||misXiuDaiYa) {
            [self showAlertView:mIsMeasing];
        }
        else
        {
            NSString *btnStr = @"ok";
            if ([self isEnglish]) {
                
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"Shutting off?"
                                      message: nil
                                      delegate: self
                                      cancelButtonTitle:btnStr
                                      otherButtonTitles:@"cancel", nil];
                [alert show];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"你确定关闭设备"
                                      message: nil
                                      delegate: self
                                      cancelButtonTitle:@"确定"
                                      otherButtonTitles:@"取消", nil];
                [alert show];
            }
        }
        
    }
    else
    {
        [self showAlertView:mDevDisconnect];
    }
}

-(IBAction)btn_biancheng:(id)sender
{
    
    if (!isCanBianCheng) {
        
        if ([self isEnglish]) {
            [self showAlertView:@"BP monitor no Programming "];
        }else
        {
            [self showAlertView:@"该血压计没有编程功能"];
        }
        return;
    }

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *uid=[prefs objectForKey:@"id"];
    if ([self strIsEqual:@"0" equal:[NSString stringWithFormat:@"%@",uid]]) {
        if ([self isEnglish]) {
            [self showAlertView:@"visitor can't use this."];
        }else
        {
            [self showAlertView:@"访客不能使用编程功能"];
        }
        return;
    }else
    {
        uid=[prefs objectForKey:@"name"];
        if ([self strIsEqual:@"visitor" equal:[NSString stringWithFormat:@"%@",uid]]) {
            if ([self isEnglish]) {
                [self showAlertView:@"visitor can't use this."];
            }else
            {
                [self showAlertView:@"访客不能使用编程功能"];
            }
            return;
        }
    }
    
    //[self changState:1];
    if (mCBCharacteristicW&&mperipheral)
    {
        if (!misLonginOk) {
            [self showAlertView:mIsLogining];
            return;
        }
        if (mstartType==1||misXiuDaiYa) {
            [self showAlertView:mIsMeasing];
        }
        else
        {
            mbianchengview=[[CheckSetMainViewController alloc]initWithNibName:@"CheckSetMainViewController" bundle:nil];
            mbianchengview.delegate=self;
            [self openWindow:mbianchengview];
        }
    }
    else
    {
        [self showAlertView:mDevDisconnect];
    }
}


-(IBAction)btn_check:(id)sender
{
    [self changState:0];
    if (mCBCharacteristicW&&mperipheral)
    {
        if (!misLonginOk) {
             [self showAlertView:mIsLogining];
            return;
        }
        
        if (misBianChengIng) {
            [self showAlertView:mIsBianCheng];
            return;
        }
        
        if (timeIndex<4) {
            if ([self isEnglish]) {
                [self showAlertView:@"Wait a moment!"];
            }
            else
            {
                [self showAlertView:@"还有命令未执行完毕，请等待!"];
                
            }
            timeIndex=5;
            return;
        }
       
        if(mstartType==0 )
        {
             if (misChongDian==0&&mdianliang>5)
             {
                 if (misChongDian==0&&mdianliang>5)
                 {
                     if (misXiuDaiYa) {
                         [self showAlertView:@"袖带压还为降为0,请稍等!"];
                         return;
                     }
                     mstartType=1;
                     NSData* valData = [msHelper getStartCmd];
                     sendType=10;
                     [self sendData:valData];
                     if ([self isEnglish]) {
                         [mBtnCheck setTitle:@"Stop" forState:UIControlStateNormal];
                     }
                     else
                     {
                         [mBtnCheck setTitle:@"停止测量" forState:UIControlStateNormal];
                         
                     }
                      timeIndex=0;
                     [ mBtnCheck setBackgroundImage:[UIImage imageNamed:@"btn_stop"] forState:UIControlStateNormal];
                     [mBtnCheck setTitleColor:[[UIColor alloc] initWithRed:0.922 green:0.847 blue:0.847 alpha:1.0] forState:UIControlStateNormal];
                      
                 }
                 else
                 {
                      if ([self isEnglish]) {
                          [self showAlertView:@"Low battery"];
                      }
                     else
                     {
                         
                         [self showAlertView:@"电量偏低，请充电"];
                     }
                 
                 }
             }
             else
             {
                  if ([self isEnglish]) {
                      [self showAlertView:@"Charging, No measurement!"];
                  }
                 else
                 {
                     [self showAlertView:@"充电不能启动测量"];
                 }
             }
            
        }
        else
        {
            mstartType=0;
            NSData* valData = [msHelper getStopCmd];
            sendType=11;
            [self sendData:valData];
            if ([self isEnglish]) {
                [mBtnCheck setTitle:@"Start" forState:UIControlStateNormal];
            }
            else
            {
                [mBtnCheck setTitle:@"启动测量" forState:UIControlStateNormal];
                
            }
             timeIndex=0;
            [ mBtnCheck setBackgroundImage:[UIImage imageNamed:@"btn_start"] forState:UIControlStateNormal];
             [mBtnCheck setTitleColor:[[UIColor alloc] initWithRed:0.659 green:0.659 blue:0.659 alpha:1.0] forState:UIControlStateNormal];
            mXiuDaiYa.text=@"0";
            [self changeXinTiao:0];
        }
    }
    else
    {
        [self showAlertView:mDevDisconnect];
    }
    
}

-(void)changeXinTiao:(int)state
{
    if (state==mxintiaostate) {
        return;
    }
    mxintiaostate=state;
    if (state==0) {
         mXinTiao.image=[UIImage imageNamed:@"xsxxno"];
    }
    else
    {
         mXinTiao.image=[UIImage imageNamed:@"xsxx"];
    }
}



-(void)changState:(int)state
{
    mstate=state;
    mShuZhangYa.text=@"0";
    mShouSuoYa.text=@"0";
    mXinLv.text=@"0";
    mXiuDaiYa.text=@"0";
    mXinTiao.image=[UIImage imageNamed:@"xsxxno"];
    mxintiaostate=0;
    if (state==0) {
        mXinLv.hidden=YES;
        mXinLvUnit.hidden=YES;
        mShuZhangYaUint.hidden=YES;
        mShuZhangYa.hidden=YES;
        mShouSuoYaUnit.hidden=YES;
        mShouSuoYa.hidden=YES;
        mLevel.hidden=YES;
        mqiyabg.hidden=false;
        mrecordbg.hidden=YES;
        mlunpanbg.hidden=YES;
      
        mLevel.text=@"";
        
        mXinTiao.hidden=NO;
        mXiuDaiYa.hidden=NO;
    }
    else
    {
        mXinLv.hidden=NO;
        mXinLvUnit.hidden=NO;
        mShuZhangYaUint.hidden=NO;
        mShuZhangYa.hidden=NO;
        mShouSuoYaUnit.hidden=NO;
        mShouSuoYa.hidden=NO;
        mLevel.hidden=NO;
        mlunpanbg.image=[UIImage imageNamed:@"lunpan0"];
        mLevel.text=@"";
        mXinTiao.hidden=YES;
        mXiuDaiYa.hidden=YES;
        mqiyabg.hidden=YES;
        mrecordbg.hidden=false;
        mlunpanbg.hidden=false;

        mtype=0;
    }
}

-(void)changeBg:(int)type
{
    if (mstate==0) {
        return;
    }
    mtype=type;
    if ([self isEnglish]) {
        if (type==0) {
            mlunpanbg.image=[UIImage imageNamed:@"lunpan0"];
            mLevel.text=@"Ideal";
            mLevel.textColor=[[UIColor alloc] initWithRed:0.275 green:0.845 blue:0.682 alpha:1.0];
            return;
        }
        else  if (type==1) {
            mlunpanbg.image=[UIImage imageNamed:@"lunpan0"];
            mLevel.text=@"Ideal";
            mLevel.textColor=[[UIColor alloc] initWithRed:0.459 green:0.845 blue:0.56 alpha:1.0];
            return;
        }else  if (type==2) {
            mlunpanbg.image=[UIImage imageNamed:@"lunpan1"];
            mLevel.text=@"Normal";
            mLevel.textColor=[[UIColor alloc] initWithRed:0.733 green:0.845 blue:0.365 alpha:1.0];
            return;
        }
        else  if (type==3) {
            mlunpanbg.image=[UIImage imageNamed:@"lunpan2"];
            mLevel.text=@"Nor. High";
            mLevel.textColor=[[UIColor alloc] initWithRed:0.733 green:0.845 blue:0.365 alpha:1.0];
            
            return;
        }else  if (type==4) {
            mlunpanbg.image=[UIImage imageNamed:@"lunpan3"];
            mLevel.text=@"Marginalh";
            mLevel.textColor=[[UIColor alloc] initWithRed:0.8433 green:0.845 blue:0.286 alpha:1.0];
            return;
        }
        else  if (type==5) {
            mlunpanbg.image=[UIImage imageNamed:@"lunpan4"];
            mLevel.text=@"Mild";
            mLevel.textColor=[[UIColor alloc] initWithRed:0.929 green:0.845 blue:0.20 alpha:1.0];
            return;
        }
        else  if (type==6) {
            mlunpanbg.image=[UIImage imageNamed:@"lunpan5"];
            mLevel.text=@"Moderate";
            mLevel.textColor=[[UIColor alloc] initWithRed:0.929 green:0.560 blue:0.24 alpha:1.0];
            return;
        }
        else  if (type==7) {
            mlunpanbg.image=[UIImage imageNamed:@"Severe"];
            mLevel.text=@"Severe";
            mLevel.textColor=[[UIColor alloc] initWithRed:0.902 green:0.439 blue:0.20 alpha:1.0];
            return;
        }
    }
    else
    {
        
        if (type==0) {
            mlunpanbg.image=[UIImage imageNamed:@"lunpan0"];
            mLevel.text=@"理想";
            mLevel.textColor=[[UIColor alloc] initWithRed:0.275 green:0.845 blue:0.682 alpha:1.0];
            return;
        }
        else  if (type==1) {
            mlunpanbg.image=[UIImage imageNamed:@"lunpan0"];
            mLevel.text=@"理想";
            mLevel.textColor=[[UIColor alloc] initWithRed:0.459 green:0.845 blue:0.56 alpha:1.0];
            return;
        }else  if (type==2) {
            mlunpanbg.image=[UIImage imageNamed:@"lunpan1"];
            mLevel.text=@"正常";
            mLevel.textColor=[[UIColor alloc] initWithRed:0.733 green:0.845 blue:0.365 alpha:1.0];
            return;
        }
        else  if (type==3) {
            mlunpanbg.image=[UIImage imageNamed:@"lunpan2"];
            mLevel.text=@"偏高";
            mLevel.textColor=[[UIColor alloc] initWithRed:0.733 green:0.845 blue:0.365 alpha:1.0];
            
            return;
        }else  if (type==4) {
            mlunpanbg.image=[UIImage imageNamed:@"lunpan3"];
            mLevel.text=@"亚组";
            mLevel.textColor=[[UIColor alloc] initWithRed:0.8433 green:0.845 blue:0.286 alpha:1.0];
            return;
        }
        else  if (type==5) {
            mlunpanbg.image=[UIImage imageNamed:@"lunpan4"];
            mLevel.text=@"轻度";
            mLevel.textColor=[[UIColor alloc] initWithRed:0.929 green:0.845 blue:0.20 alpha:1.0];
            return;
        }
        else  if (type==6) {
            mlunpanbg.image=[UIImage imageNamed:@"lunpan5"];
            mLevel.text=@"中度";
            mLevel.textColor=[[UIColor alloc] initWithRed:0.929 green:0.560 blue:0.24 alpha:1.0];
            return;
        }
        else  if (type==7) {
            mlunpanbg.image=[UIImage imageNamed:@"lunpan6"];
            mLevel.text=@"重度";
            mLevel.textColor=[[UIColor alloc] initWithRed:0.902 green:0.439 blue:0.20 alpha:1.0];
            return;
        }
    }
}

-(void)reSendCmd
{
    
    timeIndex+=1;
    //NSLog(@"reSendCheck");
    if (mperipheral&&mCBCharacteristicW)
    {
        timeIndexEx=0;
        mLink.image=[UIImage imageNamed:@"link_on"];
        mDianLingbg.image=[UIImage imageNamed:@"dianliangbg"];
        if ([self isEnglish]) {
            mlink.text=@"Connected";
        }
        else
        {
            mlink.text=@"已连接";
        }
        mlink.textColor=[[UIColor alloc] initWithRed:0.478 green:0.710 blue:0.643 alpha:1.0];
        mpercent.textColor=[[UIColor alloc] initWithRed:0.478 green:0.710 blue:0.643 alpha:1.0];
        if (mSendData)
        {
            if (misNew) {
                misNew=false;
            }
            else
            {
                NSLog(@"reSendCmd now");
                [self sendData:mSendData withType:1];
                mSendData=nil;
            }
        }
        else
        {
           // NSLog(@"reSendCmd is null");
        }
    }
    else
    {
        //timeIndexEx+=1;
        //if (timeIndexEx>2) {
             [self initSet];
        //}
       
        if (timeIndex==30&&!isfirst) {
            isfirst=YES;
            [self showAlertView:mNoBPFind];
        }
    }
    
}
-(void)initSet
{
    mDingLing.image=[self getIcon:0];
    mchongdianbg.hidden=YES;
    misStop=false;
    if ([self isEnglish]) {
         mlink.text=@"Disconnected";
    }
    else
    {
        mlink.text=@"未连接";
    }   //时间间隔
    mlink.textColor=[[UIColor alloc] initWithRed:0.757 green:0.757 blue:0.757 alpha:1.0];
    mXinLvUnit.textColor=[[UIColor alloc] initWithRed:0.404 green:0.404 blue:0.404 alpha:1.0];
    mShouSuoYaUnit.textColor=[[UIColor alloc] initWithRed:0.404 green:0.404 blue:0.404 alpha:1.0];
    mShuZhangYaUint.textColor=[[UIColor alloc] initWithRed:0.404 green:0.404 blue:0.404 alpha:1.0];
    mpercent.textColor=[[UIColor alloc] initWithRed:0.757 green:0.757 blue:0.757 alpha:1.0];
    mDingLing.image=[self getIcon:0];
    if ([self isEnglish]) {
        [mBtnCheck setTitle:@"Start" forState:UIControlStateNormal];
    }
    else
    {
        [mBtnCheck setTitle:@"启动测量" forState:UIControlStateNormal];
        
    }
    [mBtnCheck setBackgroundImage:[UIImage imageNamed:@"btn_start"] forState:UIControlStateNormal];
    [mBtnCheck setTitleColor:[[UIColor alloc] initWithRed:0.659 green:0.659 blue:0.659 alpha:1.0] forState:UIControlStateNormal];
    mLink.image=[UIImage imageNamed:@"link_off"];
    mDianLingbg.image=[UIImage imageNamed:@"dianliangbg_off"];
    mlink.textColor=[[UIColor alloc] initWithRed:0.757 green:0.757 blue:0.757 alpha:1.0];
    mpercent.textColor=[[UIColor alloc] initWithRed:0.757 green:0.757 blue:0.757 alpha:1.0];
    mpercent.text=@"0%";

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self changState:0];
    [self initSet];
    NSTimeInterval timeInterval =1.0;
    //定时器
    showTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval                                                           target:self  selector:@selector(reSendCmd) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
