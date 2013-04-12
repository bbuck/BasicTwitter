//
//  BTAccountPicker.m
//  BasicTwitter
//
//  Created by Brandon Buck on 4/12/13.
//  Copyright (c) 2013 Brandon Buck. All rights reserved.
//

#import "BTAccountPicker.h"

@implementation BTAccountPicker

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.accounts = @[];
    }
    return self;
}

- (id)initWithAccounts:(NSArray*)theAccounts
{
    self = [super init];
    if (self) {
        self.accounts = theAccounts;
    }
    return self;
}

- (int)numberOfRowsInComponent:(NSInteger)component
{
    return self.accounts.count;
}

@end
