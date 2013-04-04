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
        self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.button setTitle:@"Tweet" forState:UIControlStateNormal];
        self.button.frame = CGRectMake(10, 10, 100, 50);
        [self.view addSubview:self.button];
        [self.button addTarget:self action:@selector(tweetBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        
        [[NSNotificationCenter defaultCenter]
            addObserver:self
            selector:@selector(changeTweetBtn)
            name:ACAccountStoreDidChangeNotification
            object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self changeTweetBtn];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [composer shouldAutomaticallyForwardAppearanceMethods]
}

@end
