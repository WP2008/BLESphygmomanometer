//
//  NumberSelectViewController.h
//  ruibaoxueya
//
//  Created by zbf on 14-4-18.
//  Copyright (c) 2014年 zbf. All rights reserved.
//

#import "BaseNetViewController.h"
@protocol NumberSelectDelegate;
@interface NumberSelectViewController : BaseNetViewController<UIPickerViewDataSource,UIPickerViewDelegate>
{
   
    BOOL misload;
}
@property(assign)int mIndex;
@property(assign)int mRequestCode;
@property(retain,nonatomic)NSMutableArray *mNumbers;
@property(retain,nonatomic) IBOutlet UIPickerView *mTime;
@property(retain,nonatomic)id<NumberSelectDelegate>delegate;
@property(retain,nonatomic)IBOutlet UIButton *mBtnOk;
@property(retain,nonatomic)IBOutlet UILabel *mTitle;
-(IBAction)btnOk:(id)sender;
@end
@protocol NumberSelectDelegate <NSObject>

-(void)selectAtIndex:(int)index andRequest:(int)requestCode;

@end
