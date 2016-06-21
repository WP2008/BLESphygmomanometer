//
//  DateTimeSelectViewController.h
//  haihuaguser
//
//  Created by zbf on 14-3-14.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "BaseNetViewController.h"
@protocol DateTimeSelectDelegate ;
@interface DateTimeSelectViewController : BaseNetViewController<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIPickerView *mTime;
    NSMutableArray *mYears;
    NSMutableArray *mMonths;
    NSMutableArray *mDays;
    int mYear;
    int mMonth;
    int mDay;
    
    NSMutableArray *mHours;
    NSMutableArray *mMinite;
    int mHour;
    int mMite;
    id<DateTimeSelectDelegate>delegate;
    
    BOOL misload;
}
@property(assign)int mHour;
@property(assign)int mMite;
@property(assign)int mYear;
@property(assign)int mMonth;
@property(assign)int mDay;
@property(retain,nonatomic) IBOutlet UIPickerView *mTime;
@property(retain,nonatomic)id<DateTimeSelectDelegate>delegate;
-(IBAction)btnOk:(id)sender;
@property(retain,nonatomic)IBOutlet UIButton *mBtnOk;
@property(retain,nonatomic)IBOutlet UILabel *mTitle;
-(NSString *)getDateString;
@end
@protocol DateTimeSelectDelegate <NSObject>
@optional
-(void)selectYear:(int)year selectMonth:(int)month selectDay:(int)day;
-(void)selectHour:(int)hour selectMinite:(int)minite;
-(void)selectDate:(NSString *)date;
@end
