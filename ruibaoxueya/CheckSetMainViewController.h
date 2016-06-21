//
//  CheckSetMainViewController.h
//  ruibaoxueya
//
//  Created by zbf on 14-4-28.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "BaseNetViewController.h"
@protocol SendBianDelegate;
@interface CheckSetMainViewController : BaseNetViewController<UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate>
{
    NSString *mAlertInfo;
    BOOL misload;
}
@property(nonatomic, retain)IBOutlet UIActivityIndicatorView *indicatorView;
@property(nonatomic, retain)IBOutlet UIButton *btnOk;
@property(assign)int mIndex;
@property(assign)int mRequestCode;
@property(retain,nonatomic)NSMutableArray *mNumbers;
@property(retain,nonatomic) IBOutlet UIPickerView *mQiYa;
@property(retain,nonatomic)IBOutlet UIButton *mBtnOk;
@property(retain,nonatomic)IBOutlet UILabel *mTitle;
@property(retain,nonatomic)IBOutlet UIButton *mBtnSet1;
@property(retain,nonatomic)IBOutlet UIButton *mBtnSet2;
@property(retain,nonatomic)IBOutlet UILabel *mlset1;
@property(retain,nonatomic)IBOutlet UILabel *mlset2;
@property(retain,nonatomic)IBOutlet UILabel *mlQiYA;
-(void)sendOk;
-(IBAction)btnOk:(id)sender;
-(IBAction)btnBaiTian:(id)sender;
-(IBAction)btnWanShang:(id)sender;
@property(retain,nonatomic)id<SendBianDelegate>delegate;
@end
@protocol SendBianDelegate <NSObject>

-(void)startBianChang;

@end
