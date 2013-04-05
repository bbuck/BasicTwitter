//
//  BTBaseViewController.m
//  BasicTwitter
//
//  Created by Brandon Buck on 4/4/13.
//  Copyright (c) 2013 Brandon Buck. All rights reserved.
//

#import "BTBaseViewController.h"

@interface BTBaseViewController ()

@end

@implementation BTBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.accountStore = [[ACAccountStore alloc] init];
        
        NSNotificationCenter* notifCenter = [NSNotificationCenter defaultCenter];
        [notifCenter
         addObserver:self
         selector:@selector(changeTweetBtn)
         name:ACAccountStoreDidChangeNotification
         object:nil];
        [notifCenter
         addObserver:self
         selector:@selector(sizeComponents)
         name:UIDeviceOrientationDidChangeNotification
         object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self changeTweetBtn];
    
}

- (void)loadView
{
    [super loadView];
    
    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.button setTitle:@"Tweet" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(tweetBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    self.button.imageView.image = [UIImage imageNamed:@"bird_blue_32"];
    
    self.timelineView = [[UIScrollView alloc] init];
    self.timelineView.backgroundColor = [UIColor redColor];
    
    [self sizeComponents];
    
    [self.view addSubview:self.button];
    [self.view addSubview:self.timelineView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sizeComponents
{
    CGRect bounds = self.view.bounds;
    NSLog(@"%f x %f", bounds.size.width, bounds.size.height);
    float buttonWidth = bounds.size.width - 20;
    self.button.frame = CGRectMake(10, 10, buttonWidth, 50);

    CGRect timelineFrame = CGRectMake(0, 70, bounds.size.width, self.view.bounds.size.height - 70);
    self.timelineView.frame = timelineFrame;
}

- (void)changeTweetBtn
{
    ACAccountType* accountType = [self.accountStore accountTypeWithAccountTypeIdentifier:SLServiceTypeTwitter];
    [self.accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError* error) {
        if (granted)
            self.account = [self.accountStore accountWithIdentifier:ACAccountTypeIdentifierTwitter];
        else {
            if (error.code == 6)
                NSLog(@"No twitter account");
            else
                NSLog(@"Access denied");
        }
    }];
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        [self.button setEnabled:YES];
    else
        [self.button setEnabled:NO];
}

- (void)tweetBtnPressed
{
    ACAccountType* accountType = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    if (self.account && self.account.accountType == accountType)
        return;
    SLComposeViewController* composer = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [self presentViewController:composer animated:YES completion:nil];
}

@end
