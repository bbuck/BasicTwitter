//
//  BTTweet.m
//  BasicTwitter
//
//  Created by Brandon Buck on 4/17/13.
//  Copyright (c) 2013 Brandon Buck. All rights reserved.
//

#import "BTTweet.h"

@implementation BTTweet

- (id)initWithJSON:(NSDictionary *)theJson
{
    self = [super init];
    if (self) {
        self.text = theJson[@"text"];
        self.name = theJson[@"user"][@"name"];
        self.screenName = theJson[@"user"][@"screen_name"];
        self.avatarUrl = theJson[@"user"][@"profile_image_url"];
    }
    return self;
}

- (void)fetchAvatarFromTwitterWithDelegate:(id)theDelegate
{
    if (self.connection)
        [self.connection cancel];
    
    NSURL *url = [[NSURL alloc] initWithString:self.avatarUrl];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:theDelegate startImmediately:YES];
}

@end
