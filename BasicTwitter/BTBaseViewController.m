//
//  BTBaseViewController.m
//  BasicTwitter
//
//  Created by Brandon Buck on 4/4/13.
//  Copyright (c) 2013 Brandon Buck. All rights reserved.
//

#import "BTBaseViewController.h"
#import "BTAccountSelectController.h"

@interface BTBaseViewController ()

@end

@implementation BTBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Timeline";
        
        UIColor* offWhite = [UIColor colorWithRed:(230 / 255.0) green:(230 / 255.0) blue:(184 / 255.0) alpha:1];
        self.view.backgroundColor = offWhite;
        
        self.accountStore = [[ACAccountStore alloc] init];
        
        self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.button setTitle:@"Tweet" forState:UIControlStateNormal];
        [self.button addTarget:self action:@selector(tweetBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        self.button.imageView.image = [UIImage imageNamed:@"bird_blue_32"];
        
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.backgroundColor = offWhite;
        
        [self.view addSubview:self.button];
        [self.view addSubview:self.scrollView];
        
        [self getTwitterAccount];
        
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
    [self sizeComponents];
  //  [self fetchTimeline];
}

- (void)loadView
{
    [super loadView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchTimeline
{
    return;
    NSURL* timelineUrl = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/home_timeline.json"];
    SLRequest* request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                            requestMethod:SLRequestMethodGET
                                                      URL:timelineUrl
                                               parameters:nil];
    [request setAccount:self.account];
    [request performRequestWithHandler:^(NSData* response, NSHTTPURLResponse* urlResponse, NSError* error)
     {
         NSDictionary* json = [NSJSONSerialization JSONObjectWithData:response
                                                              options:0
                                                                error:nil];
         NSLog(@"%@", json);
     }];
}

- (void)sizeComponents
{
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    float width = screenSize.width;
    float height = screenSize.height;
    float statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    // Don't know why this happens, but it does.
    if (statusBarHeight != 40 || statusBarHeight != 20 || statusBarHeight != 0)
        statusBarHeight = 20;
    if (UIDeviceOrientationIsLandscape(orientation)) {
        width = screenSize.height;
        height = screenSize.width - statusBarHeight;
    }
    else {
        width = screenSize.width;
        height = screenSize.height - statusBarHeight;
    }
    
    float buttonWidth = width - 20;
    self.button.frame = CGRectMake(10, 10, buttonWidth, 50);

    CGRect timelineFrame = CGRectMake(0, 70, width, height - 70);
    self.scrollView.frame = timelineFrame;
}

- (void)getAccountFromArray:(NSArray*)theAccounts
{
    if (theAccounts.count == 0)
        self.btaccount = [[BTAccount alloc] initWithAccount:theAccounts[0]];
    else {
        NSLog(@"Should be doing what I want ><");
        BTAccountSelectController* selectController = [[BTAccountSelectController alloc] init];
        selectController.accounts = theAccounts;
        selectController.account = self.btaccount;
        [self presentViewController:selectController animated:YES completion:nil];
    }
}

- (void)getTwitterAccount
{
    if (self.btaccount)
        return;
    
    ACAccountType* accountType = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    NSLog(@"Making this call to getTwitterAccount");
    [self.accountStore
     requestAccessToAccountsWithType:accountType
     options:nil
     completion:^(BOOL granted, NSError* error) {
        NSLog(@"Testing, this should show up");
        if (granted) {
            NSArray* accounts = [self.accountStore accountsWithAccountType:accountType];
            [self getAccountFromArray:accounts];
        }
        else {
            if (error.code == 6)
                NSLog(@"No twitter account");
            else
                NSLog(@"Access denied");
        }
    }];
}

- (void)changeTweetBtn
{
    if (!self.account)
        [self getTwitterAccount];
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        [self.button setEnabled:YES];
    else
        [self.button setEnabled:NO];
}

- (void)tweetBtnPressed
{
    SLComposeViewController* composer = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [self presentViewController:composer animated:YES completion:nil];
}

@end
