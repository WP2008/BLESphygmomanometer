//
//  AdInfoManager.m
//  JeffreyPrj
//
//  Created by taiheiot on 12-7-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AdInfoManager.h"
#import "AdInfo.h"
#import "sqlite3.h"
#import "OxyCheck.h"
#import "StatInfo.h"
@implementation AdInfoManager
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
        const char *createSql="create table if not exists u_OxyInfo (mId integer ,mDate integer, mTime integer, mState integer, mUserID integer, mType integer,  mRemark text,mHighSpO2 integer,mMinSpO2 integer, mPulse integer, mCreateUserID integer,mYear integer,mMonth integer,mDay integer,mWk integer,mHour integer,mMinite integer,mSecond integer,mTimeCount integer, mMCPulse integer,mPJSpO2 integer,mMCPulseType integer,mDelete integer,mInfo text ,mDes text ,mTiWeiName text,mHighSpO2Type integer , mMinSpO2Type integer , mPulseType integer , mPJSpO2Type integer,MTiWei integer,MTestType integer ,mTestName text, primary key('mId'));";
        result=sqlite3_exec(database, createSql, NULL, NULL, &errorMsg);
    }
    sqlite3_close(database);
    database=Nil;   
    if (result==SQLITE_OK) {
        return YES;
    }
    return NO;
}


-(BOOL)insert:(AdInfo*)info
{ 
    info.mId=[self getMaxID];
    info.mPJSpO2=info.mHighSpO2*2/3+info.mMinSpO2/3;
    info.mMCPulse=info.mHighSpO2-info.mMinSpO2;
    info.mHour=info.mTime/10000;
    info.mMinite=info.mTime%10000/100;
    info.mSecond=info.mTime%10000%100;
    info.mYear=info.mDate/10000;
    info.mMonth=info.mDate%10000/100;
    info.mDay=info.mDate%10000%100;
    info.mTimeCount=info.mHour*60+info.mMinite;
    OxyCheck *mcheck=[[OxyCheck alloc]init];
    info.mHighSpO2Type=[mcheck checkHighEx:info];
    info.mMinSpO2Type=[mcheck checkMinEx:info];;
    info.mPulseType=[mcheck checkPulse:info];;
    info.mPJSpO2Type=[mcheck checkPj:info];;
    info.mMCPulseType=[mcheck checkMc:info];;
    
    int result=-1;
    if(path!=Nil&&info!=Nil)
    {
        sqlite3 *database;
        result=sqlite3_open([path UTF8String], &database);
        if(result==SQLITE_OK)
        {
            const char* insertSql=" insert or replace into u_OxyInfo(mId ,mDate , mTime , mState , mUserID , mType ,  mRemark ,mHighSpO2 ,mMinSpO2 , mPulse , mCreateUserID,mYear ,mMonth ,mDay ,mWk ,mHour ,mMinite ,mSecond ,mTimeCount ,mMCPulse ,mPJSpO2 ,mMCPulseType ,mDelete ,mInfo  ,mDes  ,mTiWeiName ,mHighSpO2Type  , mMinSpO2Type  , mPulseType  , mPJSpO2Type,MTiWei ,MTestType  ,mTestName ) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
            sqlite3_stmt *stmt;
            if(sqlite3_prepare_v2(database, insertSql, -1, &stmt, nil)==SQLITE_OK)
            {
                sqlite3_bind_int(stmt, 1,info.mId);
                sqlite3_bind_int(stmt,2,info.mDate);
                sqlite3_bind_int(stmt,3,info.mTime);
                sqlite3_bind_int(stmt,4,info.mState);
                sqlite3_bind_int(stmt,5,info.mUserID);
                sqlite3_bind_int(stmt,6,info.mType);
                 sqlite3_bind_text(stmt, 7, [info.mRemark UTF8String], -1, NULL);
                
                sqlite3_bind_int(stmt,8,info.mHighSpO2);
                sqlite3_bind_int(stmt, 9,info.mMinSpO2);
                sqlite3_bind_int(stmt,10,info.mPulse);
                sqlite3_bind_int(stmt,11,info.mCreateUserID);
                sqlite3_bind_int(stmt,12,info.mYear);
                sqlite3_bind_int(stmt,13,info.mMonth);
                sqlite3_bind_int(stmt,14,info.mDay);
                sqlite3_bind_int(stmt,15,info.mWk);
                
                sqlite3_bind_int(stmt,16,info.mHour);
                sqlite3_bind_int(stmt, 17,info.mMinite);
                sqlite3_bind_int(stmt,18,info.mSecond);
                sqlite3_bind_int(stmt,19,info.mTimeCount);
                sqlite3_bind_int(stmt,20,info.mMCPulse);
                sqlite3_bind_int(stmt,21,info.mPJSpO2);
                sqlite3_bind_int(stmt,22,info.mMCPulseType);
                sqlite3_bind_int(stmt,23,info.mDelete);

                
                
                sqlite3_bind_text(stmt, 24, [info.mInfo UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 25, [info.mDes UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 26, [info.mTiWeiName UTF8String], -1, NULL);
                
                sqlite3_bind_int(stmt,27,info.mHighSpO2Type);
                sqlite3_bind_int(stmt, 28,info.mMinSpO2Type);
                sqlite3_bind_int(stmt,29,info.mPulseType);
                sqlite3_bind_int(stmt,30,info.mPJSpO2Type);
                sqlite3_bind_int(stmt,31,info.MTiWei);
                sqlite3_bind_int(stmt,32,info.MTestType);

                sqlite3_bind_text(stmt, 33, [info.mTestName UTF8String], -1, NULL);
                
                
               
                
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

-(BOOL)update:(AdInfo*)info
{ 
    info.mPJSpO2=info.mHighSpO2*2/3+info.mMinSpO2/3;
    info.mMCPulse=info.mHighSpO2-info.mMinSpO2;
    info.mHour=info.mTime/10000;
    info.mMinite=info.mTime%10000/100;
    info.mSecond=info.mTime%10000%100;
    info.mYear=info.mDate/10000;
    info.mMonth=info.mDate%10000/100;
    info.mDay=info.mDate%10000%100;
    info.mTimeCount=info.mHour*60+info.mMinite;
    OxyCheck *mcheck=[[OxyCheck alloc]init];
    info.mHighSpO2Type=[mcheck checkHighEx:info];
    info.mMinSpO2Type=[mcheck checkMinEx:info];;
    info.mPulseType=[mcheck checkPulse:info];;
    info.mPJSpO2Type=[mcheck checkPj:info];;
    info.mMCPulseType=[mcheck checkMc:info];;

    int result=-1;
    if(path!=Nil&&info!=Nil)
    {
        sqlite3 *database;
        result=sqlite3_open([path UTF8String], &database);
        if(result==SQLITE_OK)
        {
            const char* insertSql=" update u_OxyInfo set mId=?, mDate =?, mTime=? , mState =?, mUserID =?, mType=? ,  mRemark=? ,mHighSpO2=? ,mMinSpO2=? , mPulse=? , mCreateUserID=?,mYear=? ,mMonth=? ,mDay=? ,mWk=? ,mHour=? ,mMinite=? ,mSecond=? ,mTimeCount=? ,mMCPulse=? ,mPJSpO2=? ,mMCPulseType=? ,mDelete=? ,mInfo=?  ,mDes=?,mHighSpO2Type =?  , mMinSpO2Type =? , mPulseType =? , mPJSpO2Type =?,MTiWei=? ,MTestType=?  ,mTestName=?,mTiWeiName=? where mId=?;";
            sqlite3_stmt *stmt;
            if(sqlite3_prepare_v2(database, insertSql, -1, &stmt, nil)==SQLITE_OK)
            {
                
                sqlite3_bind_int(stmt, 1,info.mId);
                sqlite3_bind_int(stmt,2,info.mDate);
                sqlite3_bind_int(stmt,3,info.mTime);
                sqlite3_bind_int(stmt,4,info.mState);
                sqlite3_bind_int(stmt,5,info.mUserID);
                sqlite3_bind_int(stmt,6,info.mType);
                sqlite3_bind_text(stmt, 7, [info.mRemark UTF8String], -1, NULL);
                
                sqlite3_bind_int(stmt,8,info.mHighSpO2);
                sqlite3_bind_int(stmt, 9,info.mMinSpO2);
                sqlite3_bind_int(stmt,10,info.mPulse);
                sqlite3_bind_int(stmt,11,info.mCreateUserID);
                sqlite3_bind_int(stmt,12,info.mYear);
                sqlite3_bind_int(stmt,13,info.mMonth);
                sqlite3_bind_int(stmt,14,info.mDay);
                sqlite3_bind_int(stmt,15,info.mWk);
                
                sqlite3_bind_int(stmt,16,info.mHour);
                sqlite3_bind_int(stmt, 17,info.mMinite);
                sqlite3_bind_int(stmt,18,info.mSecond);
                sqlite3_bind_int(stmt,19,info.mTimeCount);
                sqlite3_bind_int(stmt,20,info.mMCPulse);
                sqlite3_bind_int(stmt,21,info.mPJSpO2);
                sqlite3_bind_int(stmt,22,info.mMCPulseType);
                sqlite3_bind_int(stmt,23,info.mDelete);
                
                
                
                sqlite3_bind_text(stmt, 24, [info.mInfo UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 25, [info.mDes UTF8String], -1, NULL);
                
                sqlite3_bind_int(stmt,26,info.mHighSpO2Type);
                sqlite3_bind_int(stmt, 27,info.mMinSpO2Type);
                sqlite3_bind_int(stmt,28,info.mPulseType);
                sqlite3_bind_int(stmt,29,info.mPJSpO2Type);
                sqlite3_bind_int(stmt,30,info.MTiWei);
                sqlite3_bind_int(stmt,31,info.MTestType);
                
                sqlite3_bind_text(stmt, 32, [info.mTestName UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 33, [info.mTiWeiName UTF8String], -1, NULL);
                sqlite3_bind_int(stmt, 34,info.mId);
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
            const char* insertSql=" delete from  u_OxyInfo where mId=?;";
            sqlite3_stmt *stmt;
            if(sqlite3_prepare_v2(database, insertSql, -1, &stmt, nil)==SQLITE_OK)
            {
                sqlite3_bind_int(stmt,1,mid);
                result=sqlite3_step(stmt);
                if(result==SQLITE_DONE)
                {
                    result=1;
                }
            }            
            sqlite3_finalize(stmt);
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
        const char *deleteSql=" delete from u_OxyInfo where mId>0;";
        result=sqlite3_exec(database, deleteSql, NULL, NULL, &errorMsg);
    }
    sqlite3_close(database);
    database=Nil;   
    if (result==SQLITE_OK) {
        return YES;
    }
    return NO;
};

-(AdInfo*)getAd:(sqlite3_stmt *)statement
{
    char *qrcode=(char*)sqlite3_column_text(statement, 21);
    char *remark=(char*)sqlite3_column_text(statement, 6);
    char *imgUrl=(char*)sqlite3_column_text(statement, 22);
    char *imgFileUrl=(char*)sqlite3_column_text(statement, 32);
    char *soundUrl=(char*)sqlite3_column_text(statement, 23);
    
    
    AdInfo *info=[[AdInfo alloc] init];
    info.mId=sqlite3_column_int(statement, 0);
    info.mDate=sqlite3_column_int(statement, 1);
    info.mTime=sqlite3_column_int(statement, 2);
    info.mState=sqlite3_column_int(statement, 3);
     info.mUserID=sqlite3_column_int(statement, 4);
    info.mType=sqlite3_column_int(statement, 5);
    info.mHighSpO2=sqlite3_column_int(statement, 7);
      info.mMinSpO2=sqlite3_column_int(statement, 8);
    info.mPulse=sqlite3_column_int(statement, 9);
    info.mCreateUserID=sqlite3_column_int(statement, 10);
    
    info.mYear=sqlite3_column_int(statement, 11);
    
    info.mWk=sqlite3_column_int(statement, 28);
   
    info.MTiWei=sqlite3_column_int(statement, 30);
    info.mTimeCount=sqlite3_column_int(statement, 15);
    info.MTestType=sqlite3_column_int(statement, 31);
    
    info.mSecond=sqlite3_column_int(statement, 14);
    info.mPulseType=sqlite3_column_int(statement, 26);
  
    info.mPJSpO2Type=sqlite3_column_int(statement, 19);
    info.mPJSpO2=sqlite3_column_int(statement, 17);
    info.mMonth=sqlite3_column_int(statement, 12);
    info.mMinSpO2Type=sqlite3_column_int(statement, 25);
  
    info.mMinite=sqlite3_column_int(statement, 13);
    info.mMCPulseType=sqlite3_column_int(statement, 18);
    info.mMCPulse=sqlite3_column_int(statement, 16);
    info.mHighSpO2Type=sqlite3_column_int(statement, 24);
    info.mHour=sqlite3_column_int(statement, 29);
    
    info.mDelete=sqlite3_column_int(statement, 20);
    info.mDay=sqlite3_column_int(statement, 27);
    
    
    if (qrcode!=nil) {
        NSString *str=[[NSString alloc]initWithUTF8String:qrcode];
        info.mInfo=str;
        //[str release];
    }
    if (remark!=nil) {
        NSString *rstr=[[NSString alloc]initWithUTF8String:remark];
        info.mRemark=rstr;
        //[rstr release];
    }
    if (imgUrl!=nil) {
        NSString *imgstr=[[NSString alloc]initWithUTF8String:imgUrl];
        info.mDes=imgstr;
        //[imgstr release];
    }
    if (imgFileUrl!=nil) {
        NSString *imgFilestr=[[NSString alloc]initWithUTF8String:imgFileUrl];
        info.mTestName=imgFilestr;
       // [imgFilestr release];
    }
    if (soundUrl!=nil) {
        NSString *sstr=[[NSString alloc]initWithUTF8String:soundUrl];
        info.mTiWeiName=sstr;
        //[sstr release];
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
             NSString* selectStr=[[NSString alloc]initWithFormat:@"select mId ,mDate , mTime , mState , mUserID , mType ,  mRemark ,mHighSpO2 ,mMinSpO2 , mPulse , mCreateUserID,mYear ,mMonth ,mMinite ,mSecond ,mTimeCount ,mMCPulse ,mPJSpO2 ,mMCPulseType , mPJSpO2Type,mDelete ,mInfo  ,mDes  ,mTiWeiName ,mHighSpO2Type  , mMinSpO2Type  , mPulseType ,mDay ,mWk ,mHour  ,MTiWei ,MTestType  ,mTestName  from u_OxyInfo where mId>0 order by mId desc ;"];
            sqlite3_stmt *statement;
            if (sqlite3_prepare_v2(database, [selectStr UTF8String], -1, &statement, nil)==SQLITE_OK) {
                while (sqlite3_step(statement)==SQLITE_ROW) {
                    AdInfo *info=[self getAd:statement];
                    [arr addObject:info];
                }
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(database);
    }
    return arr;
}


-(AdInfo*)queryInfo:(int)mid
{
    AdInfo *info=nil;
    
    if (path!=Nil) {
        sqlite3 *database;
        int result=sqlite3_open([path UTF8String], &database);
        if(result==SQLITE_OK)
        {
            NSString* selectStr=[[NSString alloc]initWithFormat:@"select mId ,mDate , mTime , mState , mUserID , mType ,  mRemark ,mHighSpO2 ,mMinSpO2 , mPulse , mCreateUserID,mYear ,mMonth ,mMinite ,mSecond ,mTimeCount ,mMCPulse ,mPJSpO2 ,mMCPulseType , mPJSpO2Type,mDelete ,mInfo  ,mDes  ,mTiWeiName ,mHighSpO2Type  , mMinSpO2Type  , mPulseType ,mDay ,mWk ,mHour  , MTiWei ,MTestType  ,mTestName   from u_OxyInfo where ID=%d  ;",mid];
            sqlite3_stmt *statement;
            if (sqlite3_prepare_v2(database, [selectStr UTF8String], -1, &statement, nil)==SQLITE_OK) {
                if (sqlite3_step(statement)==SQLITE_ROW) {
                    info=[self getAd:statement];
                }
            }
            sqlite3_finalize(statement);
            //[selectStr release];
        }
        sqlite3_close(database);
    }
    return info;
}

-(NSMutableArray*)queryInfoByWhere:(NSString *)strWhere
{
     NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    if (path!=Nil) {
        sqlite3 *database;
        int result=sqlite3_open([path UTF8String], &database);
        if(result==SQLITE_OK)
        {
            NSString* selectStr=[[NSString alloc]initWithFormat:@"select mId ,mDate , mTime , mState , mUserID , mType ,  mRemark ,mHighSpO2 ,mMinSpO2 , mPulse , mCreateUserID,mYear ,mMonth  ,mMinite ,mSecond ,mTimeCount ,mMCPulse ,mPJSpO2 ,mMCPulseType , mPJSpO2Type,mDelete ,mInfo  ,mDes  ,mTiWeiName ,mHighSpO2Type  , mMinSpO2Type  , mPulseType  ,mDay ,mWk ,mHour , MTiWei ,MTestType  ,mTestName   from u_OxyInfo where %@  ;",strWhere];
            sqlite3_stmt *statement;
            if (sqlite3_prepare_v2(database, [selectStr UTF8String], -1, &statement, nil)==SQLITE_OK) {
                while (sqlite3_step(statement)==SQLITE_ROW) {
                    AdInfo *info=[self getAd:statement];
                    [arr addObject:info];
                }
            }
            sqlite3_finalize(statement);
            //[selectStr release];
        }
        sqlite3_close(database);
    }
    return arr;
}

-(NSMutableArray*)queryHighStatInfoByWhere:(NSString *)strWhere
{
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    if (path!=Nil) {
        sqlite3 *database;
        int result=sqlite3_open([path UTF8String], &database);
        if(result==SQLITE_OK)
        {
            NSString* selectStr=[[NSString alloc]initWithFormat:@"select mHighSpO2Type,count(*)   from u_OxyInfo where %@  group by mHighSpO2Type order by mHighSpO2Type ;",strWhere];
            sqlite3_stmt *statement;
            if (sqlite3_prepare_v2(database, [selectStr UTF8String], -1, &statement, nil)==SQLITE_OK) {
                while (sqlite3_step(statement)==SQLITE_ROW) {
                    StatInfo *info=[[StatInfo alloc]init];
                    info.mType=sqlite3_column_int(statement, 0);
                    info.mCount=sqlite3_column_int(statement, 1);
                    [arr addObject:info];
                }
            }
            sqlite3_finalize(statement);
            //[selectStr release];
        }
        sqlite3_close(database);
    }
    return arr;
}



-(NSMutableArray*)queryMinStatInfoByWhere:(NSString *)strWhere
{
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    if (path!=Nil) {
        sqlite3 *database;
        int result=sqlite3_open([path UTF8String], &database);
        if(result==SQLITE_OK)
        {
            NSString* selectStr=[[NSString alloc]initWithFormat:@"select mMinSpO2Type,count(*)   from u_OxyInfo where %@  group by mMinSpO2Type order by mMinSpO2Type ;",strWhere];
            sqlite3_stmt *statement;
            if (sqlite3_prepare_v2(database, [selectStr UTF8String], -1, &statement, nil)==SQLITE_OK) {
                while (sqlite3_step(statement)==SQLITE_ROW) {
                    StatInfo *info=[[StatInfo alloc]init];
                    info.mType=sqlite3_column_int(statement, 0);
                    info.mCount=sqlite3_column_int(statement, 1);
                    [arr addObject:info];
                }
            }
            sqlite3_finalize(statement);
            //[selectStr release];
        }
        sqlite3_close(database);
    }
    return arr;
}

-(NSMutableArray*)queryPulseStatInfoByWhere:(NSString *)strWhere
{
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    if (path!=Nil) {
        sqlite3 *database;
        int result=sqlite3_open([path UTF8String], &database);
        if(result==SQLITE_OK)
        {
            NSString* selectStr=[[NSString alloc]initWithFormat:@"select mPulseType,count(*)   from u_OxyInfo where %@  group by mPulseType order by mPulseType ;",strWhere];
            sqlite3_stmt *statement;
            if (sqlite3_prepare_v2(database, [selectStr UTF8String], -1, &statement, nil)==SQLITE_OK) {
                while (sqlite3_step(statement)==SQLITE_ROW) {
                    StatInfo *info=[[StatInfo alloc]init];
                    info.mType=sqlite3_column_int(statement, 0);
                    info.mCount=sqlite3_column_int(statement, 1);
                    [arr addObject:info];
                }
            }
            sqlite3_finalize(statement);
            //[selectStr release];
        }
        sqlite3_close(database);
    }
    return arr;
}


-(NSMutableArray*)queryPjStatInfoByWhere:(NSString *)strWhere
{
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    if (path!=Nil) {
        sqlite3 *database;
        int result=sqlite3_open([path UTF8String], &database);
        if(result==SQLITE_OK)
        {
            NSString* selectStr=[[NSString alloc]initWithFormat:@"select mPJSpO2Type,count(*)   from u_OxyInfo where %@  group by mPJSpO2Type order by mPJSpO2Type ;",strWhere];
            sqlite3_stmt *statement;
            if (sqlite3_prepare_v2(database, [selectStr UTF8String], -1, &statement, nil)==SQLITE_OK) {
                while (sqlite3_step(statement)==SQLITE_ROW) {
                    StatInfo *info=[[StatInfo alloc]init];
                    info.mType=sqlite3_column_int(statement, 0);
                    info.mCount=sqlite3_column_int(statement, 1);
                    [arr addObject:info];
                }
            }
            sqlite3_finalize(statement);
            //[selectStr release];
        }
        sqlite3_close(database);
    }
    return arr;
}


-(NSMutableArray*)queryMcStatInfoByWhere:(NSString *)strWhere
{
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    if (path!=Nil) {
        sqlite3 *database;
        int result=sqlite3_open([path UTF8String], &database);
        if(result==SQLITE_OK)
        {
            NSString* selectStr=[[NSString alloc]initWithFormat:@"select mMCPulseType,count(*)   from u_OxyInfo where %@  group by mMCPulseType order by mMCPulseType ;",strWhere];
            sqlite3_stmt *statement;
            if (sqlite3_prepare_v2(database, [selectStr UTF8String], -1, &statement, nil)==SQLITE_OK) {
                while (sqlite3_step(statement)==SQLITE_ROW) {
                    StatInfo *info=[[StatInfo alloc]init];
                    info.mType=sqlite3_column_int(statement, 0);
                    info.mCount=sqlite3_column_int(statement, 1);
                    [arr addObject:info];
                }
            }
            sqlite3_finalize(statement);
            //[selectStr release];
        }
        sqlite3_close(database);
    }
    return arr;
}

-(int)getMaxID
{
    int id=1;
    
    if (path!=Nil) {
        sqlite3 *database;
        int result=sqlite3_open([path UTF8String], &database);
        if(result==SQLITE_OK)
        {
             NSString* selectStr=[[NSString alloc]initWithFormat:@"select max(mId) from u_OxyInfo where mId>0  ;"];
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
