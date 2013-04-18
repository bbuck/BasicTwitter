//
//  BTTimelineTableControllerViewController.h
//  BasicTwitter
//
//  Created by Brandon Buck on 4/17/13.
//  Copyright (c) 2013 Brandon Buck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

#import "BTAccountSelectController.h"
#import "BTAccountSelectDelegate.h"
#import "UIColor+ColorExtentions.h"
#import "BTTweet.h"
#import "BTTWeetView.h"
#import "BTAccount.h"

@interface BTTimelineTableController : UITableViewController <BTAccountSelectDelegate>

@property (strong, nonatomic) NSArray* tweets;
@property (strong, nonatomic) ACAccountStore *accountStore;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) BTTimelineTableController *timelineController;
@property (strong, nonatomic) BTAccount *account;

- (void)showTwitterComposeView;
- (void)fetchTimeline;
- (void)getAccountFromArray:(NSArray*)theAccounts;
- (void)processAndSetTweetsFromArray:(NSArray *)theArray;

@end
