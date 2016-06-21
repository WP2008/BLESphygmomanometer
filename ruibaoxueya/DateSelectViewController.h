//
//  DateSelectViewController.h
//  haihuaguser
//
//  Created by zbf on 14-3-14.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "BaseNetViewController.h"
@protocol DateSelectDelegate;
@interface DateSelectViewController : BaseNetViewController<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIPickerView *mTime;
    NSMutableArray *mYears;
    NSMutableArray *mMonths;
    NSMutableArray *mDays;
    int mYear;
    int mMonth;
    int mDay;
    id<DateSelectDelegate>delegate;
    BOOL misload;

}
@property(assign)int mYear;
@property(assign)int mMonth;
@property(assign)int mDay;
@property(retain,nonatomic) IBOutlet UIPickerView *mTime;
@property(retain,nonatomic)id<DateSelectDelegate>delegate;
@property(retain,nonatomic)IBOutlet UIButton *mBtnOk;
@property(retain,nonatomic)IBOutlet UILabel *mTitle;
-(IBAction)btnOk:(id)sender;

@end
@protocol DateSelectDelegate <NSObject>

-(void)selectYear:(int)year selectMonth:(int)month selectDay:(int)day;

@end