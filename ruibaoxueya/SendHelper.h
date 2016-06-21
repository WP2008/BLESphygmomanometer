//
//  SendHelper.h
//  ruibaoxueya
//
//  Created by zbf on 14-4-28.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SendHelper : NSObject
{
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
}
-(NSData*) getCrt:(Byte*)datas withLend:(int )len;
-(NSData*)getCmd:(Byte*)args with:(int)len withCmd:(Byte)cmd;
-(NSData*)getConnectCmd;
-(void)writeLog:(NSData *)data;
-(void)writeLog:(NSData *)data withTye:(int)type;
-(NSData*)getXiuDaiYaCmd;
-(NSData*)getDevNameCmd;
-(NSData*)getDevIdCmd;
-(NSData*)getRecordCmd;
-(NSData*)getRecordCmd:(Byte)year withMonth:(Byte)month withDay:(Byte)day withHour:(Byte)hour withMinite:(Byte)minite;
-(NSData*)setRtcCmd:(Byte)year withMonth:(Byte)month withDay:(Byte)day withHour:(Byte)hour withMinite:(Byte)minite;
-(NSData*)getRecordInfoCmd;
-(NSData*)getDingLingCmd;
-(NSData*)getStartCmd;
-(NSData*)getStopCmd;
-(NSData*)getCloseCmd;
-(NSData*)getCloseConnectCmd;
-(NSData*)getLoginFinishConnectCmd;
-(NSData*)getSetFinishCmd;
-(NSData *)setDavName:(NSString *)name;
-(NSData *)setDavId:(NSString *)name;
-(NSData *)setMax:(int )max;
-(NSData *)setOpenBaiTian:(Boolean )open;
-(NSData *)setOpenWanShang:(Boolean )open;
-(NSData *)setWanShangTime:(int )startHour withEndHour:(int)endHour withInternel:(int)internel;
-(NSData *)setBaiTianTime:(int )startHour withEndHour:(int)endHour withInternel:(int)internel;
-(NSString *)getChar:(int )num;
@end
