//
//  BTAccountSelectController.h
//  BasicTwitter
//
//  Created by Brandon Buck on 4/8/13.
//  Copyright (c) 2013 Brandon Buck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>

#import "BTBaseViewController.h"
#import "BTAccount.h"
#import "BTUtils.h"
#import "UIColor+ColorExtentions.h"

@interface BTAccountSelectController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) NSArray* accounts;
@property (strong, nonatomic) BTAccount* account;
@property (strong, nonatomic) BTBaseViewController* btBaseController;
@property (strong, nonatomic) UIPickerView* picker;

- (void)setAccountsSource:(NSArray*)theAccounts;
- (void)sizeComponents;
- (CGRect)getPickerFrame;

+ (int)needsToDisplayWithAccounts:(NSArray*)theAccounts
                       andAccount:(BTAccount*)anAccount;

@end
