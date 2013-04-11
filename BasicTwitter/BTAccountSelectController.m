//
//  BTAccountSelectController.m
//  BasicTwitter
//
//  Created by Brandon Buck on 4/8/13.
//  Copyright (c) 2013 Brandon Buck. All rights reserved.
//

#import "BTAccountSelectController.h"

@interface BTAccountSelectController ()

@end

@implementation BTAccountSelectController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UILabel* label = [[UILabel alloc] init];
        label.text = @"You should see me";
        label.frame = CGRectMake(0, 0, 100, 50);
        [self.view addSubview:label];
    }
    return self;
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
