//
//  SysConfig.h
//  haihuang
//
//  Created by zbf on 14-2-22.
//  Copyright (c) 2014年 zbf. All rights reserved.
//60.191.113.178

#import <Foundation/Foundation.h>
#define Http_upData_Url @"http://115.29.168.155/WSL/upload.do?dir="
#define Http_WebServer_Url @"http://115.29.168.155/WSL/WslWebService.ws"
#define Http_Company_Url @"http://115.29.168.155/WSL/com_company.jsp"
#define Http_Product_Url @"http://115.29.168.155/WSL/com_product.jsp"
#define Http_Link_Url @"http://115.29.168.155/WSL/com_link.jsp"
#define WebServer_NameSpace @"http://webservice.wsl.lxt.com/"

@interface SysConfig : NSObject
{}
-(NSString *)getLoginJson:(NSString *)userName withPwd:(NSString *)userPwd;
-(NSString *)getQueryActiveJson:(NSString*)mid;
-(NSString *)getQueryActiveListJson:(NSString *)psgeNum withTitle:(NSString *)title;

@end
