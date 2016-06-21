//
//  CheckSetViewController.h
//  ruibaoxueya
//
//  Created by zbf on 14-4-28.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "BaseNetViewController.h"

@interface CheckSetViewController : BaseNetViewController<UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate>
{
    int mdate;
    int mtime;
    BOOL misload;
    NSMutableArray *mNumbers;
    NSMutableArray *mNumbers1;
    NSMutableArray *mNumbers2;
    NSString *mAlertInfo;
    int mIndex1;
    int mIndex2;
    int mIndex3;
    
}
@property(retain,nonatomic) IBOutlet UIPickerView *mStart;
@property(retain,nonatomic) IBOutlet UIPickerView *mEnd;
@property(retain,nonatomic) IBOutlet UIPickerView *mJianGe;
@property(retain,nonatomic) IBOutlet UILabel *mTitle;
@property(retain,nonatomic) IBOutlet UILabel *mTitleEx;
@property(retain,nonatomic) IBOutlet UISegmentedControl *mSate;

@property(retain,nonatomic)IBOutlet UIButton *mBtnOk;
@property(retain,nonatomic)IBOutlet UILabel *mlstart;
@property(retain,nonatomic)IBOutlet UILabel *mlend;
@property(retain,nonatomic)IBOutlet UILabel *mljiange;

@property(assign)int mtype;
-(IBAction)btn_ok:(id)sender;
@end
