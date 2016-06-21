//
//  TimeSelectViewController.h
//  haihuaguser
//
//  Created by zbf on 14-3-14.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "BaseNetViewController.h"
@protocol TimeSelectDelegate;
@interface TimeSelectViewController : BaseNetViewController<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIPickerView *mTime;
    NSMutableArray *mHours;
    NSMutableArray *mMinite;
    int mHour;
    int mMite;
    id<TimeSelectDelegate>delegate;
    BOOL misload;
}
@property(assign)int mHour;
@property(assign)int mMite;
@property(retain,nonatomic) IBOutlet UIPickerView *mTime;
@property(retain,nonatomic)id<TimeSelectDelegate>delegate;
@property(retain,nonatomic)IBOutlet UIButton *mBtnOk;
@property(retain,nonatomic)IBOutlet UILabel *mTitle;
-(IBAction)btnOk:(id)sender;
@end
@protocol TimeSelectDelegate <NSObject>

-(void)selectHour:(int)hour selectMinite:(int)minite;

@end