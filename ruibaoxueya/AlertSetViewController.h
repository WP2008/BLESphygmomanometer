//
//  AlertSetViewController.h
//  ruibaoxueya
//
//  Created by zbf on 14-4-20.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "BaseNetViewController.h"

@interface AlertSetViewController : BaseNetViewController<UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate>
{
    BOOL misload;
    NSMutableArray *mNumbers;
    NSMutableArray *mNumbers1;
    int mIndex1;
    int mIndex2;


}
@property(retain,nonatomic) IBOutlet UIPickerView *mShouSuo;
@property(retain,nonatomic) IBOutlet UIPickerView *mShouZhang;
@property(retain,nonatomic) IBOutlet UISegmentedControl *mSate1;
@property(retain,nonatomic) IBOutlet UISegmentedControl *mSate;
@property(retain,nonatomic)IBOutlet UILabel *mTitle;
@property(retain,nonatomic)IBOutlet UIButton *mBtnOk;

@property(retain,nonatomic)IBOutlet UILabel *mlShouSuo;
@property(retain,nonatomic)IBOutlet UILabel *mlShouZhang;
@property(retain,nonatomic)IBOutlet UILabel *mlSate;
@property(retain,nonatomic)IBOutlet UILabel *mlSate1;
-(IBAction)btn_ok:(id)sender;

@end
