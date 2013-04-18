//
//  BTTweetView.m
//  BasicTwitter
//
//  Created by Brandon Buck on 4/18/13.
//  Copyright (c) 2013 Brandon Buck. All rights reserved.
//

#import "BTTweetView.h"

@interface BTTweetView ()

@end

@implementation BTTweetView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor paleYellow];
        self.title = @"View Tweet";
        self.scrollView = [[UIScrollView alloc] init];
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
        self.screenNameLabel = [[UILabel alloc] init];
        self.screenNameLabel.font = [UIFont fontWithName:@"Helvetica" size:17];
        self.screenNameLabel.textColor = [UIColor grayColor];
        
        self.avatarView = [[UIImageView alloc] init];
        self.bodyLabel = [[UILabel alloc] init];
        
        [self.view addSubview:self.nameLabel];
        [self.view addSubview:self.screenNameLabel];
        [self.view addSubview:self.bodyLabel];
        [self.view addSubview:self.avatarView];
        
        REGISTER_FOR_ORIENTATION_CHANGE(sizeComponents);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.view addSubview:self.scrollView];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"Yep, in here");
    [self sizeComponents];
    self.scrollView.frame = self.view.frame;
    self.nameLabel.text = self.tweet.name;
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", self.tweet.screenName];
    self.bodyLabel.text = self.tweet.text;
}

- (void)sizeComponents
{
    self.avatarView.frame = CGRectMake(10, 10, 50, 50);
    self.nameLabel.frame = CGRectMake(70, 20, 100, 50);
    self.screenNameLabel.frame = CGRectMake(70, 120, 100, 50);
    self.bodyLabel.frame = CGRectMake(0, 130, 320, 100);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
