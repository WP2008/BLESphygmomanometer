//
//  OxyCheck.m
//  ruibaoxueya
//
//  Created by zbf on 14-4-22.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "OxyCheck.h"

@implementation OxyCheck

-(int)check:(AdInfo *)model
{
    if(model.mHighSpO2<120&&model.mMinSpO2<80)
    {
        return 0;
    }
    else if(model.mHighSpO2<130&&model.mMinSpO2<85)
    {
        return 1;
    }
    else if(model.mHighSpO2<140&&model.mMinSpO2<90)
    {
        return 2;
    }else if(model.mHighSpO2<150&&model.mMinSpO2<95)
    {
        return 3;
    }else if(model.mHighSpO2<160&&model.mMinSpO2<100)
    {
        return 4;
    }else if(model.mHighSpO2<180&&model.mMinSpO2<110)
    {
        return 5;
    }
    return 6;
}

-(int)checkHigh:(AdInfo *)model
{
    if(model.mHighSpO2<120)
    {
        return 0;
    }
    else if(model.mHighSpO2<130)
    {
        return 1;
    }
    else if(model.mHighSpO2<140)
    {
        return 2;
    }else if(model.mHighSpO2<150)
    {
        return 3;
    }else if(model.mHighSpO2<160)
    {
        return 4;
    }else if(model.mHighSpO2<180)
    {
        return 5;
    }
    return 6;
}

-(int)checkMin:(AdInfo *)model
{
    if(model.mMinSpO2<80)
    {
        return 0;
    }
    else if(model.mMinSpO2<85)
    {
        return 1;
    }
    else if(model.mMinSpO2<90)
    {
        return 2;
    }else if(model.mMinSpO2<95)
    {
        return 3;
    }else if(model.mMinSpO2<100)
    {
        return 4;
    }else if(model.mMinSpO2<110)
    {
        return 5;
    }
    return 6;
}

-(int)checkHighEx:(AdInfo *)model
{
    if(model.mHighSpO2>=160)
    {
        return 4;
    }else if(model.mHighSpO2>=140)
    {
        return 3;
    }else if(model.mHighSpO2>=120)
    {
        return 2;
    }else if(model.mHighSpO2>=90)
    {
        return 1;
    }		
    return 0;
}

-(int)checkMinEx:(AdInfo *)model
{
    if(model.mMinSpO2>=100)
    {
        return 4;
    }else if(model.mMinSpO2>=90)
    {
        return 3;
    }else if(model.mMinSpO2>=80)
    {
        return 2;
    }else if(model.mHighSpO2>=60)
    {
        return 1;
    }
    
    return 0;
}

-(int)checkPulse:(AdInfo *)model
{
    if(model.mPulse>=130)
    {
        return 4;
    }else if(model.mPulse>=111)
    {
        return 3;
    }else if(model.mPulse>=70)
    {
        return 2;
    }else if(model.mPulse>=50)
    {
        return 1;
    }
    
    return 0;
}

-(int)checkPj:(AdInfo *)model
{
    if(model.mPJSpO2>=130)
    {
        return 4;
    }else if(model.mPJSpO2>=111)
    {
        return 3;
    }else if(model.mPJSpO2>=70)
    {
        return 2;
    }else if(model.mPJSpO2>=50)
    {
        return 1;
    }
    
    return 0;
}

-(int)checkMc:(AdInfo *)model
{
    if(model.mMCPulse>=51)
    {
        return 4;
    }
    else if(model.mMCPulse>=41)
    {
        return 3;
    }else if(model.mMCPulse>=31)
    {
        return 2;
    }else if(model.mMCPulse>=21)
    {
        return 1;
    }
    
    return 0;
}

-(NSString*)getHighInfo:(int)type
{
    switch(type)
    {
        case 1:
            return @"90-119";
        case 2:
            return @"120-139";
        case 3:
            return @"140-159";
        case 4:
            return @"159+";
            
    }
    return @"-90";
    
}



-(NSString*)getMinInfo:(int)type
{
    switch(type)
    {
        case 1:
            return @"60-79";
        case 2:
            return @"80-89";
        case 3:
            return @"90-99";
        case 4:
            return @"99+";
            
    }
    return @"-60";
    
}


-(NSString*)getPulseInfo:(int)type
{
    switch(type)
    {
        case 1:
            return @"50-69";
        case 2:
            return @"70-110";
        case 3:
            return @"111-129";
        case 4:
        return @"130+";
        
    }
    return @"-50";
    
}


-(NSString*)getPjInfo:(int)type
{
    switch(type)
    {
        case 1:
            return @"50-69";
        case 2:
            return @"70-110";
        case 3:
            return @"111-130";
        case 4:
            return @"130+";
            
    }
    return @"-50";

}


-(NSString*)getMCInfo:(int)type
{
    switch(type)
    {
        case 1:
            return @"21-30";
        case 2:
            return @"31-40";
        case 3:
            return @"41-50";
        case 4:
            return @"50+";
            
    }
    return @"-21";
}

@end
