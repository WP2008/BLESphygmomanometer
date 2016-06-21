//
//  SqlHelper.m
//  JeffreyPrj
//
//  Created by taiheiot on 12-6-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SqlHelper.h"
#import "sqlite3.h"
#import "QRHosInfo.h"

@implementation SqlHelper
@synthesize path;

-(BOOL) createDb{
    
    if (path==Nil) {
        return  NO;
    }
    sqlite3 *database;
    int result=sqlite3_open([path UTF8String], &database);
    if(result==SQLITE_OK)
    {
        char* errorMsg;
        const char *createSql=" create table if not exists u_UserInfo (Id integer,mUserCode text,mUserName text,mUserPwd text,mUserSex integer,mUserAge integer,mUserKg integer, mUserHigh integer,primary key('Id'));";
        result=sqlite3_exec(database, createSql, NULL, NULL, &errorMsg);
        
        
    }
    sqlite3_close(database);
    database=Nil;   
    if (result==SQLITE_OK) {
        return YES;
    }
    return NO;
}



-(NSString*)GetTime  
{  
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];  
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];  
    NSString*timeString=[formatter stringFromDate: [NSDate date]];  
    //[formatter release];
    return timeString;  
} 





-(BOOL)insert:(QRHosInfo*)info
{ 
    info.mID=[self getMaxID];
    int result=-1;
    if(path!=Nil&&info!=Nil)
    {
        sqlite3 *database;
        result=sqlite3_open([path UTF8String], &database);
        if(result==SQLITE_OK)
        {
            const char* insertSql=" insert or replace into u_UserInfo(Id ,mUserCode ,mUserName ,mUserPwd ,mUserSex ,mUserAge ,mUserKg , mUserHigh ) values (?,?,?,?,?,?,?,?);";
            sqlite3_stmt *stmt;
            if(sqlite3_prepare_v2(database, insertSql, -1, &stmt, nil)==SQLITE_OK)
            {
                sqlite3_bind_int(stmt, 1,info.mID);
                sqlite3_bind_text(stmt,2, [info.mUserCode UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 3, [info.mUserName UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 4, [info.mUserPwd UTF8String], -1, NULL);
                sqlite3_bind_int(stmt, 5, info.mUserSex);
                sqlite3_bind_int(stmt, 6, info.mUserAge);
                sqlite3_bind_int(stmt, 7, info.mUserKg);
                 sqlite3_bind_int(stmt, 8, info.mUserHigh);
            }
            result=sqlite3_step(stmt);
            if(result==SQLITE_DONE)
            {
                result=1;
            }
            else {
                NSLog(@" insert is error ");
                result=-1;
            }
            sqlite3_finalize(stmt);
        }
        else {
            result=-1;
        }
        sqlite3_close(database);
        database=Nil;
    }
    if (result==1) {
        return YES;
    }else {
        return NO;
    }
}

-(BOOL)update:(QRHosInfo*)info
{ 
  
    int result=-1;
    if(path!=Nil&&info!=Nil)
    {
        sqlite3 *database;
        result=sqlite3_open([path UTF8String], &database);
        if(result==SQLITE_OK)
        {
            const char* insertSql=" update u_UserInfo set  mUserCode=? ,mUserName=? ,mUserPwd=? ,mUserSex=? ,mUserAge=? ,mUserKg=? , mUserHigh=?  where Id=? ;";
            sqlite3_stmt *stmt;
            if(sqlite3_prepare_v2(database, insertSql, -1, &stmt, nil)==SQLITE_OK)
            {
                
                
                sqlite3_bind_text(stmt,1, [info.mUserCode UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 2, [info.mUserName UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 3, [info.mUserPwd UTF8String], -1, NULL);
                sqlite3_bind_int(stmt, 4, info.mUserSex);
                sqlite3_bind_int(stmt, 5, info.mUserAge);
                sqlite3_bind_int(stmt, 6, info.mUserKg);
                sqlite3_bind_int(stmt, 7, info.mUserHigh);
                sqlite3_bind_int(stmt, 8,info.mID);
            }
            result=sqlite3_step(stmt);
            if(result==SQLITE_DONE)
            {
                result=1;
            }
            else {
                result=-1;
            }
            sqlite3_finalize(stmt);
        }
        else {
            result=-1;
        }
        sqlite3_close(database);
        database=Nil;
    }
    if (result==1) {
        return YES;
    }else {
        return NO;
    }
}

-(BOOL)deleteById:(int)mid
{
   
    int result=-1;
    if(path!=Nil&&mid>0)
    {
        sqlite3 *database;
        result=sqlite3_open([path UTF8String], &database);
        if(result==SQLITE_OK)
        {
            const char* insertSql=" delete from  u_UserInfo where Id=?;";
            sqlite3_stmt *stmt;
            if(sqlite3_prepare_v2(database, insertSql, -1, &stmt, nil)==SQLITE_OK)
            {
                sqlite3_bind_int(stmt,1,mid);
            }
            result=sqlite3_step(stmt);
            if(result==SQLITE_DONE)
            {
                result=1;
            }
            else {
                result=-1;
            }
            sqlite3_finalize(stmt);
        }
        else {
            result=-1;
        }
        sqlite3_close(database);
        database=Nil;
    }
    if (result==1) {
        return YES;
    }else {
        return NO;
    }
}

-(BOOL)deleteAll
{
   
    if (path==Nil) {
        return  NO;
    }
    sqlite3 *database;
    int result=sqlite3_open([path UTF8String], &database);
    if(result==SQLITE_OK)
    {
        char* errorMsg;
        const char *deleteSql=" delete from u_UserInfo where Id>0;";
        result=sqlite3_exec(database, deleteSql, NULL, NULL, &errorMsg);
    }
    sqlite3_close(database);
    database=Nil;   
    if (result==SQLITE_OK) {
        return YES;
    }
    return NO;
};

-(QRHosInfo*)getInfo:(sqlite3_stmt *)statement
{

     char *remark=(char*)sqlite3_column_text(statement, 1);
    QRHosInfo *info=[[QRHosInfo alloc] init];
    info.mID=sqlite3_column_int(statement, 0);
    info.mUserSex=sqlite3_column_int(statement, 4);
    info.mUserHigh=sqlite3_column_int(statement, 7);
    info.mUserAge=sqlite3_column_int(statement, 5);
    info.mUserKg=sqlite3_column_int(statement, 6);
    NSString *str=Nil;
    if (remark) {
         str=[[NSString alloc]initWithUTF8String:remark];
        info.mUserCode=str;
    }
    remark=(char*)sqlite3_column_text(statement, 2);
    // [str release];
    if (remark) {
        str=[[NSString alloc]initWithUTF8String:remark];
        info.mUserName=str;
    }
    remark=(char*)sqlite3_column_text(statement, 3);
    if (remark) {
         str=[[NSString alloc]initWithUTF8String:remark];
         info.mUserPwd=str;
    }
    return info;
}


-(NSMutableArray*)queryInfo
{
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    if (path!=Nil) {
        sqlite3 *database;
        int result=sqlite3_open([path UTF8String], &database);
        if(result==SQLITE_OK)
        {
             NSString* selectStr=[[NSString alloc]initWithFormat:@"select Id ,mUserCode ,mUserName ,mUserPwd ,mUserSex ,mUserAge ,mUserKg , mUserHigh from u_UserInfo  where 1=1 ;"];
            sqlite3_stmt *statement;
            if (sqlite3_prepare_v2(database, [selectStr UTF8String], -1, &statement, nil)==SQLITE_OK) {
                while (sqlite3_step(statement)==SQLITE_ROW) {
                    QRHosInfo *info=[self getInfo:statement];
                    [arr addObject:info];
                }
               
            }
             sqlite3_finalize(statement);
        }
        sqlite3_close(database);
    }
    return arr;
}

-(QRHosInfo*)queryInfo:(int)mid
{
    QRHosInfo *info=nil;
  
    if (path!=Nil) {
        sqlite3 *database;
        int result=sqlite3_open([path UTF8String], &database);
        if(result==SQLITE_OK)
        {
            NSString* selectStr=[[NSString alloc]initWithFormat:@"select Id ,mUserCode ,mUserName ,mUserPwd ,mUserSex ,mUserAge ,mUserKg , mUserHigh from u_UserInfo where Id=%d  ;",mid];
            sqlite3_stmt *statement;
            if (sqlite3_prepare_v2(database, [selectStr UTF8String], -1, &statement, nil)==SQLITE_OK) {
                if (sqlite3_step(statement)==SQLITE_ROW) {
                    info=[self getInfo:statement];
                    
                }
            }
            sqlite3_finalize(statement);
            //[selectStr release];
        }
        sqlite3_close(database);
    }
    return info;
}

-(QRHosInfo*)queryInfoByName:(NSString*)mName{
    QRHosInfo *info=nil;
    
    if (path!=Nil) {
        sqlite3 *database;
        int result=sqlite3_open([path UTF8String], &database);
        if(result==SQLITE_OK)
        {
            NSString* selectStr=[[NSString alloc]initWithFormat:@"select Id ,mUserCode ,mUserName ,mUserPwd ,mUserSex ,mUserAge ,mUserKg , mUserHigh from u_UserInfo where mUserName='%@'  ;",mName];
            sqlite3_stmt *statement;
            if (sqlite3_prepare_v2(database, [selectStr UTF8String], -1, &statement, nil)==SQLITE_OK) {
                if (sqlite3_step(statement)==SQLITE_ROW) {
                    info=[self getInfo:statement];
                    
                }
            }
            sqlite3_finalize(statement);
            //[selectStr release];
        }
        sqlite3_close(database);
    }
    return info;
}

-(int)getMaxID
{
    int id=1;
  
    if (path!=Nil) {
        sqlite3 *database;
        int result=sqlite3_open([path UTF8String], &database);
        if(result==SQLITE_OK)
        {
            NSString* selectStr=[[NSString alloc]initWithFormat:@"select max(Id) from u_UserInfo where Id>0  ;"];
            sqlite3_stmt *statement;
            if (sqlite3_prepare_v2(database, [selectStr UTF8String] , -1, &statement, nil)==SQLITE_OK) {
                if (sqlite3_step(statement)==SQLITE_ROW) {
                    id=sqlite3_column_int(statement, 0);
                    id=id+1;
                }
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(database);
    }
     return id;  
}

-(void)dealloc
{
    //[super dealloc];
    //[self.path release];
}


@end
