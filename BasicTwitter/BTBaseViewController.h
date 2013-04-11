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

@interface BTBaseViewController : UIViewController

@property (strong, nonatomic) ACAccount* account;
@property (strong, nonatomic) ACAccountStore* accountStore;
@property (strong, nonatomic) UIButton* button;
@property (strong, nonatomic) UIScrollView* scrollView;
@property (strong, nonatomic) BTAccount* btaccount;

- (void)changeTweetBtn;
- (void)tweetBtnPressed;
- (void)sizeComponents;
- (void)fetchTimeline;
- (void)getAccountFromArray:(NSArray*)theAccounts;

@end
