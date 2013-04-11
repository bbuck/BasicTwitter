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

@interface BTAccountSelectController : UIViewController

@property (strong, nonatomic) NSArray* accounts;
@property (strong, nonatomic) BTAccount* account;

- (BOOL)needsToDisplay;

@end
