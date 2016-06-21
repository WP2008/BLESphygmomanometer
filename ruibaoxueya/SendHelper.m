//
//  SendHelper.m
//  ruibaoxueya
//
//  Created by zbf on 14-4-28.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "SendHelper.h"

@implementation SendHelper
-(id)init
{
    self=[super init];
    if (self) {
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
    }
   
   
    return self;
}
-(NSData*)getConnectCmd
{
    return [self getCmd:nil with:0 withCmd:cmd_connect];
}
-(NSData*)getXiuDaiYaCmd
{
    return [self getCmd:nil with:0 withCmd:cmd_get_XiuDaiYa];
}
-(NSData*)getDevNameCmd
{
    return [self getCmd:nil with:0 withCmd:cmd_get_devname];
}

-(NSData*)getDevIdCmd
{
    return [self getCmd:nil with:0 withCmd:cmd_get_devid];
}

-(NSData*)getRecordCmd
{
    Byte info=0x00;
    return [self getCmd:&info with:1 withCmd:cmd_get_recond];
}

-(NSData*)getRecordCmd:(Byte)year withMonth:(Byte)month withDay:(Byte)day withHour:(Byte)hour withMinite:(Byte)minite
{
    NSMutableData *info=[[NSMutableData alloc]init];
    Byte infos[5];
    infos[0]=year;
    infos[1]=month;
    infos[2]=day;
    infos[3]=hour;
    infos[4]=minite;
    [info appendBytes:infos length:5];
    return [self getCmd:(Byte*)info.bytes with:5 withCmd:cmd_get_recond];
}

-(NSData*)setRtcCmd:(Byte)year withMonth:(Byte)month withDay:(Byte)day withHour:(Byte)hour withMinite:(Byte)minite
{
    NSMutableData *info=[[NSMutableData alloc]init];
    Byte infos[5];
    infos[0]=year;
    infos[1]=month;
    infos[2]=day;
    infos[3]=hour;
    infos[4]=minite;
    [info appendBytes:infos length:5];
    return [self getCmd:(Byte*)info.bytes with:5 withCmd:cmd_set_rtc_time];
}


-(NSData*)getRecordInfoCmd
{
    return [self getCmd:nil with:0 withCmd:cmd_get_recond_info];
}

-(NSData*)getDingLingCmd
{
    return [self getCmd:nil with:0 withCmd:cmd_get_dianliang];
}

-(NSData*)getStartCmd
{
    return [self getCmd:nil with:0 withCmd:cmd_dev_start];
}

-(NSData*)getStopCmd
{
    return [self getCmd:nil with:0 withCmd:cmd_dev_stop];
}

-(NSData*)getCloseCmd
{
    return [self getCmd:nil with:0 withCmd:cmd_dev_close];
}

-(NSData*)getCloseConnectCmd
{
    return [self getCmd:nil with:0 withCmd:cmd_dev_close_connect];
}


-(NSData*)getLoginFinishConnectCmd
{
    return [self getCmd:nil with:0 withCmd:cmd_login_finish];
}

-(NSData*)getSetFinishCmd
{
    return [self getCmd:nil with:0 withCmd:cmd_set_finish];
}

-(NSData *)setDavName:(NSString *)name
{
    if (name) {
       NSData* data= [name dataUsingEncoding:NSUTF8StringEncoding];
        Byte* datas=(Byte*)data.bytes;
        data=[self getCrt:datas withLend:(int)data.length];
        datas=(Byte*)data.bytes;
        Byte temdata[4];
        temdata[0]=0x00;
        temdata[1]=0x00;
        temdata[2]=datas[0];
        temdata[3]=datas[1];
        return [self getCmd:temdata with:4 withCmd:cmd_set_devname];
    }
    return  nil;
}

-(NSData *)setDavId:(NSString *)name
{
    if (name) {
        NSData* data= [name dataUsingEncoding:NSUTF8StringEncoding];
        Byte* datas=(Byte*)data.bytes;
        data=[self getCrt:datas withLend:(int)data.length];
        datas=(Byte*)data.bytes;
        Byte temdata[4];
        temdata[0]=0x00;
        temdata[1]=0x00;
        temdata[2]=datas[0];
        temdata[3]=datas[1];
        
        return [self getCmd:temdata with:4 withCmd:cmd_set_devid];
    }
    return  nil;
}

-(NSData *)setMax:(int )max
{
    Byte data[2];
    data[0]=(Byte)(max>>8&0xff);
    data[1]=(Byte)(max&0xff);
     return [self getCmd:data with:2 withCmd:cmd_set_devmax];
}

-(NSData *)setOpenBaiTian:(Boolean )open
{
    Byte data[1];
    if (open) {
        data[0]=0x01;
    }
    else
    {
         data[0]=0x00;
    }

    return [self getCmd:data with:1 withCmd:cmd_set_open_baitian];
}

-(NSData *)setOpenWanShang:(Boolean )open
{
    Byte data[1];
    if (open) {
        data[0]=0x01;
    }
    else
    {
        data[0]=0x00;
    }
    
    return [self getCmd:data with:1 withCmd:cmd_set_open_wanshang];
}

-(NSData *)setWanShangTime:(int )startHour withEndHour:(int)endHour withInternel:(int)internel
{
    Byte data[6];
    data[0]=(Byte)((startHour/100)&0xff);
    data[1]=(Byte)((startHour%100)&0xff);
    data[2]=(Byte)((endHour/100)&0xff);
    data[3]=(Byte)((endHour%100)&0xff);
    data[4]=(Byte)(internel>>8&0xff);
    data[5]=(Byte)(internel&0xff);
    return [self getCmd:data with:6 withCmd:cmd_set_open_wanshang_time];
}

-(NSData *)setBaiTianTime:(int )startHour withEndHour:(int)endHour withInternel:(int)internel
{
    Byte data[6];
    data[0]=(Byte)((startHour/100)&0xff);
    data[1]=(Byte)((startHour%100)&0xff);
    data[2]=(Byte)((endHour/100)&0xff);
    data[3]=(Byte)((endHour%100)&0xff);
    data[4]=(Byte)(internel>>8&0xff);
    data[5]=(Byte)(internel&0xff);
    return [self getCmd:data with:6 withCmd:cmd_set_open_baitian_time];
}


-(NSString *)getChar:(int )num
{
    if (num<10) {
        return [NSString stringWithFormat:@"%d",num];
    }else
    {
        if (num==10) {
            return @"A";
        }
        else if (num==11)
        {
             return @"B";
        }else if (num==12)
        {
            return @"C";
        }
        else if (num==13)
        {
            return @"D";
        }else if (num==14)
        {
            return @"E";
        }
        else
        {
            return @"F";
        }
    }
}

-(NSData*)getCmd:(Byte*)args with:(int)len withCmd:(Byte)cmd
{
    Byte blen=0x05;
    if(args)
    {
       
        blen=len+5;
        blen=(Byte) (0xff&blen);
    }
    NSMutableData *data=[[NSMutableData alloc]init];
    Byte head[3];
    head[0]=0x5a;
    head[1]=blen;
    head[2]=cmd;
    
    [data appendBytes:head length:3];
    if (args) {
        [data appendBytes:args length:len];
    }
    
    
    Byte* mdatas=(Byte*)data.bytes;
    NSData *crc=[self getCrt:mdatas withLend:(int)data.length];
    
    [data appendData:crc];
    [self writeLog:data withTye:0];
    return data;
}

-(void)writeLog:(NSData *)data withTye:(int)type;
{
    NSMutableString *sb=[[NSMutableString alloc] init];
    Byte* mdatas=(Byte*)data.bytes;
    for (int i=0;i<data.length; i++) {
        int inum=mdatas[i];
        int h=inum/16;
        int l=inum%16;
        [sb appendFormat:@"%@%@",[self getChar:h],[self getChar:l]];
    }
    if (type==0) {
         NSLog(@"发送%@",sb);
    }
    else
    {
         NSLog(@"接收%@",sb);    }
   
}
-(void)writeLog:(NSData *)data
{
    [self writeLog:data withTye:1];
}

-(NSData*) getCrt:(Byte*)datas withLend:(int )len
{
    Byte temdata[2];
    Byte CL = 0x01;
    Byte CH = 0xA0;
    Byte SaveHi;
    Byte SaveLo;
    Byte  i;
    Byte Flag;
    Byte CRC16Lo = 0xff;
    Byte CRC16Hi = 0xff;
    int num=len;
    for(i = 0; i < num; i++){
       
        int ip=(datas[i]&0xff);
        
        CRC16Lo = (Byte)((CRC16Lo ^ ip)&0xff);
        
        for(Flag = 0; Flag < 8; Flag++){
            SaveHi = CRC16Hi;
            SaveLo = CRC16Lo;
            CRC16Hi = (Byte)((CRC16Hi / 2)&0xff);
            CRC16Lo = (Byte)((CRC16Lo / 2)&0xff);
            if((SaveHi & 0x01) == 1){
                CRC16Lo = ( Byte)((CRC16Lo | 0x80)&0xff);
            }
            if((SaveLo & 0x01) == 1){
	            CRC16Hi = ( Byte)((CRC16Hi ^ CH)&0xff);
	            CRC16Lo = ( Byte)((CRC16Lo ^ CL)&0xff);
            }
        }
    }
    temdata[0] = (Byte)(CRC16Hi& 0xFF) ;
    temdata[1] = (Byte)(CRC16Lo& 0xFF) ;
    
    NSMutableData *data=[[NSMutableData alloc]init];
    [data appendBytes:temdata length:2];
    return data;
}


@end
