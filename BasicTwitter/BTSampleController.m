//
//  BTSampleController.m
//  BasicTwitter
//
//  Created by Brandon Buck on 4/3/13.
//  Copyright (c) 2013 Brandon Buck. All rights reserved.
//

#import "BTSampleController.h"

@implementation BTSampleController

@synthesize button;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        CGRect rect = CGRectMake(10, 10, 200, 50);
        self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.button.frame = rect;
        [self.button setTitle:@"Hello" forState:UIControlStateNormal];
//        [self.button setTitle:@"World!" forState:UIControlStateHighlighted];
        [self.button addTarget:self action:@selector(buttonPushed) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    return self;
}

- (void)buttonPushed
{
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    if (window.rootViewController == self)
        [self.button setTitle:@"Has been pushed" forState:UIControlStateNormal];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
