//
//  XinLvStat.m
//  ruibaoxueya
//
//  Created by zbf on 14-4-21.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "XinLvStat.h"
#import "AdInfo.h"
#import "DateInfo.h"
@implementation XinLvStat
@synthesize mData;
@synthesize mEndDate;
@synthesize mMin;
@synthesize mStartDate;
@synthesize mType;

-(id)init
{
    self=[super init];
    if (self) {
        mwidth=290*4;
        mheight=70*4;
        mw=80;
        mh=20;
        nheight=3;
        nwidth=7;
    }
    return self;
}

-(void)setMax
{
    
    int max=120;
    for(int i=0;i<mData.count;i++)
    {
        
        AdInfo *info=[mData objectAtIndex:i];
        if (mStartDate<=0) {
            [self initSDate:info.mDate withstime:0];
        }
        if (info.mDayIndex==0) {
            info.mDayIndex=[self getDayIndex:info];
            info.mDayIndex=info.mDayIndex*1440+info.mTimeCount-mstime;
        }
       
        if(info.mPulse>max)
        {
            max=info.mPulse;
        }
    }
    
    mValues=[[NSMutableArray alloc]init];
    if(max>=120)
    {
        int wd[]={55,80,105,130};
        for (int i=0; i<4; i++) {
            [mValues addObject:[NSString stringWithFormat:@"%d",wd[i]]];
        }
        mmin=wd[0];
        mmax=wd[3];
        
    }
    else if(max>=110)
    {
        int wd[]={60,80,100,120};
        for (int i=0; i<4; i++) {
            [mValues addObject:[NSString stringWithFormat:@"%d",wd[i]]];
        }
        mmin=wd[0];
        mmax=wd[3];
    }
    else if(max>=100)
    {
        int wd[]={50,70,90,110};
        for (int i=0; i<4; i++) {
            [mValues addObject:[NSString stringWithFormat:@"%d",wd[i]]];
        }
        mmin=wd[0];
        mmax=wd[3];
    }
    else if(max>=80)
    {
        int wd[]={55,70,85,100};
        for (int i=0; i<4; i++) {
            [mValues addObject:[NSString stringWithFormat:@"%d",wd[i]]];
        }
        mmin=wd[0];
        mmax=wd[3];
    }
    else
    {
        int wd[]={50,60,70,80};
        for (int i=0; i<4; i++) {
            [mValues addObject:[NSString stringWithFormat:@"%d",wd[i]]];
        }
        mmin=wd[0];
        mmax=wd[3];
    }
    
    
}

-(void)initType:(int )type
{
    mType=type;
    if(type==0||type==1)
    {
        mDays=[[NSMutableArray alloc] init];
        [ mDays addObject:@"0"];
        [ mDays addObject:@"3"];
        [ mDays addObject:@"6"];
        [ mDays addObject:@"9"];
        [ mDays addObject:@"12"];
        [ mDays addObject:@"15"];
        [ mDays addObject:@"18"];
        [ mDays addObject:@"21"];
        [ mDays addObject:@"24"];
        ncount=8;
        mhourCount=1450;
    }
    else if(type==2)
    {
        mDays=[[NSMutableArray alloc] init];
        [ mDays addObject:@"0"];
        [ mDays addObject:@"1d"];
        [ mDays addObject:@"2d"];
        [ mDays addObject:@"3d"];
        [ mDays addObject:@"4d"];
        [ mDays addObject:@"5d"];
        [ mDays addObject:@"6d"];
        [ mDays addObject:@"7d"];
        [ mDays addObject:@"8d"];
        ncount=7;
        mhourCount=1440*7;
    }
    /* else if(type==2)
     {
     
     mDays=[[NSMutableArray alloc] init];
     [ mDays addObject:@"0"];
     [ mDays addObject:@"2d"];
     [ mDays addObject:@"4d"];
     [ mDays addObject:@"6d"];
     [ mDays addObject:@"8d"];
     [ mDays addObject:@"10d"];
     [ mDays addObject:@"12d"];
     [ mDays addObject:@"14d"];
     [ mDays addObject:@"16d"];
     ncount=7;
     mhourCount=1440*14;
     }*/
    else if(type==3)
    {
        
        mDays=[[NSMutableArray alloc] init];
        [ mDays addObject:@"0"];
        [ mDays addObject:@"5d"];
        [ mDays addObject:@"10d"];
        [ mDays addObject:@"15d"];
        [ mDays addObject:@"20d"];
        [ mDays addObject:@"25d"];
        [ mDays addObject:@"30d"];
        
        ncount=7;
        mhourCount=1440*28;
    }
    /*else if(type==4)
     {
     
     mDays=[[NSMutableArray alloc] init];
     [ mDays addObject:@"0"];
     [ mDays addObject:@"15d"];
     [ mDays addObject:@"30d"];
     [ mDays addObject:@"45d"];
     [ mDays addObject:@"60d"];
     [ mDays addObject:@"75d"];
     [ mDays addObject:@"90d"];
     
     ncount=6;
     mhourCount=1440*92;
     }*/
    else if(type==4)
    {
        mDays=[[NSMutableArray alloc] init];
        [ mDays addObject:@"0"];
        [ mDays addObject:@"1m"];
        [ mDays addObject:@"2m"];
        [ mDays addObject:@"3m"];
        [ mDays addObject:@"4m"];
        [ mDays addObject:@"5m"];
        [ mDays addObject:@"6m"];
        
        ncount=7;
        mhourCount=1440*182;
    }
    else   if(type==5)
    {
        // days=new String[]{"0","2m","4m","6m","8m","10m","12m"};
        mDays=[[NSMutableArray alloc] init];
        [ mDays addObject:@"0"];
        [ mDays addObject:@"2m"];
        [ mDays addObject:@"4m"];
        [ mDays addObject:@"6m"];
        [ mDays addObject:@"8m"];
        [ mDays addObject:@"10m"];
        [ mDays addObject:@"12m"];
        
        ncount=7;
        mhourCount=1440*364;
    }
    else
    {
        mDays=[[NSMutableArray alloc] init];
        [ mDays addObject:@"0"];
        [ mDays addObject:@"3"];
        [ mDays addObject:@"6"];
        [ mDays addObject:@"9"];
        [ mDays addObject:@"12"];
        [ mDays addObject:@"15"];
        [ mDays addObject:@"18"];
        [ mDays addObject:@"21"];
        [ mDays addObject:@"24"];
        ncount=8;
        mhourCount=1440;
    }
    nwidth=ncount;
}

-(void)initSDate:(int)sDate   withstime:(int) stime{
    self.mStartDate=sDate;
    syear=self.mStartDate/10000;
    smonth=self.mStartDate%10000/100;
    smday=self.mStartDate%10000%100;
    mstime=stime;
}

-(int)getDayIndex:(AdInfo *)info
{
    
    
    NSDate *msdate=[DateInfo dateFromDate: self.mStartDate];
    
    int day=0;
    for (int i=1; i<=366; i++) {
        DateInfo *sdinf1=[[DateInfo alloc] init] ;
        [sdinf1 initDateWithDay:i withDate:msdate];
        if (sdinf1.mDate==info.mDate) {
            day=i;
            break;
        }
    }
    
    return day;
    
}



-(UIImage*)getImg
{
    float scaleFactor = [[UIScreen mainScreen] scale];
    CGSize size = CGSizeMake(mwidth, mheight);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef micon=CGBitmapContextCreate(NULL, size.width*scaleFactor, size.height*scaleFactor, 8, size.width*scaleFactor*4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextScaleCTM(micon, scaleFactor, scaleFactor);
    CGContextSetRGBFillColor(micon,0.0, 0.0, 0.0, 1.0);
    CGContextSetRGBStrokeColor(micon, 0.0, 0.0, 0.0, 1.0);
    CGContextSetLineWidth(micon, 1);
    
    UIColor *aColor = [UIColor colorWithRed:0.0 green:0.0 blue:0 alpha:1];
    CGContextSetFillColorWithColor(micon, aColor.CGColor);//填充颜色
    CGContextSetLineWidth(micon, 1.0);//线的宽度
    
    int lw=mwidth-mw*2;
    int nw=lw/nwidth;
    lw=nw*nwidth;
    int nl=mheight-2*mh;
    nl=nl/nheight;
    int lh=nl*nheight;
    
    int topy=mh+lh;
    int topx= mw+lw;
     CGContextSetRGBStrokeColor(micon, 0.224, 0.412, 0.255, 1.0);
     CGContextSetLineWidth(micon, 5.0);//线的宽度
    CGContextMoveToPoint(micon, mw, mh);
    CGContextAddLineToPoint(micon, mw, topy+mh/2);
    // CGContextAddLineToPoint(micon, mwidth-mw, mheight-mh);
    //CGContextAddArc(micon, size.width/2, size.height/2, size.width/2, 0, 2*3.1415927, 0); //添加一个圆
    //kCGPathFill填充非零绕数规则,kCGPathEOFill表示用奇偶规则,kCGPathStroke路径,kCGPathFillStroke路径填充,kCGPathEOFillStroke表示描线，不是填充
    CGContextDrawPath(micon, kCGPathEOFillStroke);
    CGContextMoveToPoint(micon, mw, mh);
    CGContextAddLineToPoint(micon, topx+mw/2, mh);
    CGContextDrawPath(micon, kCGPathEOFillStroke);
    //[@"1234" drawInRect:CGRectMake(0, 0, 10, 10) withAttributes:nil];
    // CGContextSelectFont(micon, "Arial", 24, kCGEncodingMacRoman);
    CGContextSelectFont(micon, "Helvetica", 36, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(micon, kCGTextFill);
    //CGContextSetTextMatrix(micon, CGAffineTransformScale(CGAffineTransformIdentity, 1, -1));
    
     CGContextSetLineWidth(micon, 1.0);//线的宽度
    CGContextSetRGBStrokeColor(micon, 0.0, 0.0, 0.0, 1.0);
    [self setMax];
    NSString *mxInfo=[mValues objectAtIndex:0];
    CGContextShowTextAtPoint(micon, 5, mh-5, [mxInfo UTF8String], mxInfo.length);
    
    for (int i=1; i<=nheight; i++) {
        CGContextMoveToPoint(micon, mw, mh+i*nl);
        CGContextAddLineToPoint(micon, topx, mh+i*nl);
        CGContextDrawPath(micon, kCGPathEOFillStroke);
        
        mxInfo=[mValues objectAtIndex:i];
        CGContextShowTextAtPoint(micon, 5, mh+i*nl-5, [mxInfo UTF8String], mxInfo.length);
        
    }
    
   // mxInfo=[mDays objectAtIndex:0];
    //CGContextSetTextMatrix(micon,  CGAffineTransformMake(1.0, 1.0, 1.0, 0.0,0.0, -1.0));
   // CGContextShowTextAtPoint(micon, mw-5, 15, [mxInfo UTF8String], mxInfo.length);
    
    for (int j=1; j<=nwidth; j++) {
        int x=mw+j*nw;
        CGContextMoveToPoint(micon, x, mh);
        CGContextAddLineToPoint(micon, x, topy);
        CGContextDrawPath(micon, kCGPathEOFillStroke);
        //mxInfo=[mDays objectAtIndex:j];
        
        //CGContextSetTextMatrix(micon,  CGAffineTransformMake(1.0, 1.0, 1.0, 0.0,0.0, -1.0));
       // CGContextShowTextAtPoint(micon, x-5, 15, [mxInfo UTF8String], mxInfo.length);
    }
    
    int xy[mData.count][2];
   // int xy1[mData.count][2];
      CGContextSetLineWidth(micon, 3.0);//线的宽度
    int nmax=mmax-mmin;
    CGContextSetRGBStrokeColor(micon, 1.0, 0.0, 1.0, 1.0);
    if (mData&&mData.count>0) {
        CGContextSetLineWidth(micon, 3.0);
        for (int i=0; i<mData.count; i++) {
            AdInfo *inf0=[mData objectAtIndex:i];
            int nowx=mw+lw*inf0.mDayIndex/mhourCount;
            int nowh=lh*(inf0.mPulse-mmin)/nmax;
            //int nowm=lh*(inf0.mMinSpO2-mmin)/nmax;
            if(nowh<0)
            {
                nowh=0;
            }
           // if(nowm<0)
            {
                //nowm=0;
            }
            xy[i][0]=nowx;
            xy[i][1]=nowh;
            //xy1[i][0]=nowx;
            //xy1[i][1]=nowm;
            
            if (i>=1) {
                 CGContextSetRGBStrokeColor(micon, 0.506, 0.835, 0.773, 1.0);
                CGContextMoveToPoint(micon, xy[i-1][0], mh+xy[i-1][1]);
                CGContextAddLineToPoint(micon,  xy[i][0], mh+xy[i][1]);
                CGContextDrawPath(micon, kCGPathEOFillStroke);
                
               
            }
            CGContextSetRGBFillColor(micon,1.0, 0.0, 0.0, 1.0);
            
            CGContextAddRect(micon, CGRectMake(nowx-6, mh+nowh-6, 12, 12));
            CGContextDrawPath(micon, kCGPathEOFillStroke);
           
        }
        /*
        int px=0;
        int py=0;
        int py1=0;
        for(int l=0;l<mData.count;l++)
        {
            px+=xy[l][0];
            py+=xy[l][1];
            py1+=xy1[l][1];
        }
        
        px=px/mData.count;
        py=py/mData.count;
        py1=py1/mData.count;
        
        
        float k=0;
        float k1=0;
        for(int l=0;l<mData.count;l++)
        {
            k+=(xy[l][0]-px)*(xy[l][1]-py);
            k1+=(xy1[l][0]-px)*(xy1[l][1]-py1);
        }
        
        
        
        float kk=0;
        float kk1=0;
        for(int l=0;l<mData.count;l++)
        {
            kk+=(xy[l][0]-px)*(xy[l][0]-px);
            kk1+=(xy1[l][0]-px)*(xy1[l][0]-px);
        }
        
        k=k/kk;
        k1=k1/kk1;
        
        
        float b=py-k*px;
        float b1=py1-k1*px;
        CGContextSetRGBStrokeColor(micon, 1.0, 0.0, 0.0, 1.0);
        CGContextSetLineWidth(micon, 4.0);
        CGContextMoveToPoint(micon, xy[0][0], mh+(xy[0][0]*k+b));
        CGContextAddLineToPoint(micon,  xy[mData.count-1][0], mh+(xy[mData.count-1][0]*k+b));
        CGContextDrawPath(micon, kCGPathEOFillStroke);
        
        CGContextMoveToPoint(micon, xy1[0][0], mh+(xy1[0][0]*k1+b1));
        CGContextAddLineToPoint(micon,  xy1[mData.count-1][0], mh+(xy1[mData.count-1][0]*k1+b1));
        CGContextDrawPath(micon, kCGPathEOFillStroke);*/
        
    }
    
    CGImageRef img=CGBitmapContextCreateImage(micon);
    UIImage *mImg= [UIImage imageWithCGImage:img ];
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(micon);
    CGImageRelease(img);
    
    UIGraphicsBeginImageContext(CGSizeMake(size.width/2, size.height/2));
    [mImg drawInRect:CGRectMake(0, 0, size.width/2, size.height/2)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;;
}
@end
