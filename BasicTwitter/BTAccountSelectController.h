//
//  BTAccountSelectController.h
//  BasicTwitter
//
//  Created by Brandon Buck on 4/8/13.
//  Copyright (c) 2013 Brandon Buck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>

#import "BTAccount.h"
#import "BTUtils.h"
#import "UIColor+ColorExtentions.h"
#import "BTAccountSelectDelegate.h"

@interface BTAccountSelectController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) NSArray* twitterAccounts;
@property (strong, nonatomic) UIPickerView* picker;
@property (strong, nonatomic) UILabel* label;
@property (strong, nonatomic) UIButton* doneButton;
@property (weak) id <BTAccountSelectDelegate> delegate;

- (void)setAccountsSource:(NSArray*)theAccounts;
- (void)sizeComponents;
- (CGRect)getPickerFrame;
- (void)selectTwitterAccount;
- (ACAccount *)getSelectedTwitterAccount;

+ (int)needsToDisplayWithAccounts:(NSArray*)theAccounts
                       andAccount:(BTAccount*)anAccount;

@end
