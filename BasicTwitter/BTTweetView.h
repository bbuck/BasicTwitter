//
//  BTTweetView.h
//  BasicTwitter
//
//  Created by Brandon Buck on 4/18/13.
//  Copyright (c) 2013 Brandon Buck. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BTUtils.h"
#import "BTTweet.h"
#import "UIColor+ColorExtentions.h"

@interface BTTweetView : UIViewController

@property (strong, nonatomic) BTTweet* tweet;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *screenNameLabel;
@property (strong, nonatomic) UILabel *bodyLabel;
@property (strong, nonatomic) UIImageView *avatarView;

- (void)sizeComponents;

@end
