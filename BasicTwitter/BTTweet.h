//
//  BTTweet.h
//  BasicTwitter
//
//  Created by Brandon Buck on 4/17/13.
//  Copyright (c) 2013 Brandon Buck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTTweet : NSObject

@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *screenName;
@property (strong, nonatomic) NSString *avatarUrl;
@property (strong, nonatomic) NSURLConnection *connection;

- (id)initWithJSON:(NSDictionary *)theJson;
- (void)fetchAvatarFromTwitterWithDelegate:(id)theDelegate;

@end
