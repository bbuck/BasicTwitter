//
//  BTBaseViewController.h
//  BasicTwitter
//
//  Created by Brandon Buck on 4/4/13.
//  Copyright (c) 2013 Brandon Buck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

#import "BTAccount.h"
#import "BTUtils.h"
#import "UIColor+ColorExtentions.h"

@interface BTBaseViewController : UIViewController

@property (strong, nonatomic) ACAccountStore* accountStore;
@property (strong, nonatomic) UIScrollView* scrollView;
@property (strong, nonatomic) BTAccount* account;

- (void)showTwitterComposeView;
- (void)sizeComponents;
- (void)fetchTimeline;
- (void)getAccountFromArray:(NSArray*)theAccounts;

@end
