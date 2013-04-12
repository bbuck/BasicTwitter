//
//  BTAccount.h
//  BasicTwitter
//
//  Created by Brandon Buck on 4/8/13.
//  Copyright (c) 2013 Brandon Buck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>

@interface BTAccount : NSObject <NSCoding>

@property (strong, nonatomic) NSString* username;
@property (strong, nonatomic) ACAccount* account;

+ (NSString*)getArchivePath;
+ (void)saveAccount:(BTAccount*)anAccount;
+ (BTAccount*)getAccount;

- (id)initWithAccount:(ACAccount*)anAccount;

@end
