//
//  AdResultInfo.h
//  JeffreyPrj
//
//  Created by taiheiot on 12-7-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdResultInfo : NSObject{
    NSString *mCode;
    NSString *mDesc;
    NSString *mImgUrl;
    NSString *mSoundUrl;
    NSString *mTime;
}
@property(nonatomic,retain) NSString *mCode;
@property(nonatomic,retain) NSString *mDesc;
@property(nonatomic,retain) NSString *mImgUrl;
@property(nonatomic,retain) NSString *mSoundUrl;
@property(nonatomic,retain) NSString *mTime;
-(BOOL)loadXml:(NSString *)strXml;
@end
