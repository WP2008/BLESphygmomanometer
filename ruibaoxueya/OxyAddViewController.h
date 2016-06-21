//
//  OxyAddViewController.h
//  ruibaoxueya
//
//  Created by zbf on 14-4-20.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "BaseNetViewController.h"
#import "DateTimeSelectViewController.h"
#import "AdInfo.h"
@interface OxyAddViewController : BaseNetViewController<UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate,DateTimeSelectDelegate>
{
    int mdate;
    int mtime;
    BOOL misload;
    NSMutableArray *mNumbers;
    int mIndex1;
    int mIndex2;
    int mIndex3;
    NSString *mDateString;
}
@property(retain,nonatomic) IBOutlet UIPickerView *mShouSuo;
@property(retain,nonatomic) IBOutlet UIPickerView *mShouZhang;
@property(retain,nonatomic) IBOutlet UIPickerView *mXinLv;
@property(retain,nonatomic) IBOutlet UIButton *mDate;
@property(retain,nonatomic) IBOutlet UISegmentedControl *mSate;
@property(retain,nonatomic)IBOutlet UIButton *mBtnOk;
@property(retain,nonatomic)IBOutlet UILabel *mTitle;
@property(retain,nonatomic)IBOutlet UILabel *mlStat;
@property(retain,nonatomic)IBOutlet UILabel *mlshuzhangya;
@property(retain,nonatomic)IBOutlet UILabel *mlshoushuya;
@property(retain,nonatomic)IBOutlet UILabel *mlxinLv;
@property(retain,nonatomic) IBOutlet UIButton *mDate1;
@property(retain,nonatomic)AdInfo *mInfo;
-(IBAction)btn_date:(id)sender;
-(IBAction)btn_ok:(id)sender;

@end
