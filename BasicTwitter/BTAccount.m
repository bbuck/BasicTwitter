//
//  BTAccount.m
//  BasicTwitter
//
//  Created by Brandon Buck on 4/8/13.
//  Copyright (c) 2013 Brandon Buck. All rights reserved.
//

#import "BTAccount.h"

@implementation BTAccount

- (id)initWithAccount:(ACAccount*)anAccount
{
    self = [self init];
    if (self) {
        self.account = anAccount;
    }
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super init];
    if (self) {
        self.accountName = [aDecoder decodeObjectForKey:@"accountName"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder*)aCoder
{
    [aCoder encodeObject:self.accountName forKey:@"accountName"];
}

+ (NSString*)getArchivePath
{
    NSArray* dirList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docDir = dirList[0];
    return [docDir stringByAppendingPathComponent:@"BTAccount.archive"];
}

+ (void)saveAccount:(BTAccount *)anAccount
{
    [NSKeyedArchiver archiveRootObject:anAccount toFile:[BTAccount getArchivePath]];
}

+ (BTAccount*)getAccount
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[BTAccount getArchivePath]];
}

@end
