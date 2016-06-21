//
//  AdResultInfo.m
//  JeffreyPrj
//
//  Created by taiheiot on 12-7-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AdResultInfo.h"
#import "TBXML.h"
@implementation AdResultInfo
@synthesize mCode;
@synthesize mDesc;
@synthesize mTime;
@synthesize mImgUrl;
@synthesize mSoundUrl;


-(BOOL)loadXml:(NSString *)strXml
{
    if (strXml!=nil) {
        TBXML *tbxml=[[TBXML alloc]initWithXMLString:strXml];
        TBXMLElement * root = tbxml.rootXMLElement;
        if (root!=NULL) {
            TBXMLElement *info=[TBXML childElementNamed:@"info" parentElement:root];
            TBXMLElement *data=[TBXML childElementNamed:@"data" parentElement:root];
            if (info!=NULL&&data!=NULL) {
                TBXMLElement *code=[TBXML childElementNamed:@"code" parentElement:info];
                if (code!=NULL) {
                    mCode=[TBXML textForElement:code];
                    TBXMLElement *desc=[TBXML childElementNamed:@"desc" parentElement:info];
                    if (desc!=NULL) {
                        mDesc=[TBXML textForElement:desc];
                    }
                    if([mCode isEqual:@"0"])
                    {
                        TBXMLElement * imgUrl=[TBXML childElementNamed:@"gif" parentElement:data];
                        if (imgUrl!=NULL) {
                            mImgUrl=[TBXML textForElement:imgUrl];
                        }
                        TBXMLElement * soundUrl=[TBXML childElementNamed:@"audio" parentElement:data];
                        if (soundUrl!=NULL) {
                            mSoundUrl=[TBXML textForElement:soundUrl];
                        }
                        TBXMLElement * stime=[TBXML childElementNamed:@"length" parentElement:data];
                        if (stime!=NULL) {
                            mTime=[TBXML textForElement:stime];
                        }
                        if (mImgUrl!=nil&&mSoundUrl!=nil) {
                            NSRange rang=[mImgUrl rangeOfString:@"http://"];
                            if (rang.length==0||rang.location!=0) {
                                mImgUrl=[[NSString alloc] initWithFormat:@"http://www.9733.co/%@",mImgUrl];
                                mImgUrl=[mImgUrl stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
                                
                            }
                            rang=[mSoundUrl rangeOfString:@"http://"];
                            if (rang.length==0||rang.location!=0) {
                                mSoundUrl=[[NSString alloc] initWithFormat:@"http://www.9733.co/%@",mSoundUrl];
                                mSoundUrl=[mSoundUrl stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];                           
                            }
                            return YES;
                        }
                    }
                }
            }
        }
    }
    return NO;
}

-(void)dealloc
{
   // [super dealloc];
}

@end
