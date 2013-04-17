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
        
        UIColor* paleYellow = [UIColor paleYellow];
        self.view.backgroundColor = paleYellow;
        
        self.accountStore = [[ACAccountStore alloc] init];
        
        UIBarButtonItem* tweetButton = [[UIBarButtonItem alloc]
                                            initWithTitle:@"Tweet"
                                                    style:UIBarButtonItemStylePlain
                                                   target:self
                                                   action:@selector(showTwitterComposeView)];
        self.navigationItem.rightBarButtonItem = tweetButton;
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.backgroundColor = paleYellow;
        
        [self.view addSubview:self.scrollView];
        
        [self getTwitterAccount];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    [request setAccount:self.account.twitterAccount];
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
    self.scrollView.frame = self.navigationController.view.frame;;
}

- (void)getAccountFromArray:(NSArray*)theAccounts
{
    if (theAccounts.count == 0)
        self.account = [[BTAccount alloc] initWithAccount:theAccounts[0]];
    else {
        int index = [BTAccountSelectController needsToDisplayWithAccounts:theAccounts
                                                               andAccount:self.account];
        if (index == NSNotFound) {
            BTAccountSelectController* selectController = [[BTAccountSelectController alloc] init];
            selectController.btBaseController = self;
            selectController.twitterAccounts = theAccounts;
            selectController.account = self.account;
            [self.navigationController
                presentViewController:selectController
                             animated:YES
                           completion:nil];
        }
        else {
            self.account.twitterAccount = [theAccounts objectAtIndex:index];
            [self fetchTimeline];
        }
    }
}

- (void)getTwitterAccount
{
    if (self.account)
        return;
    
    ACAccountType* accountType = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [self.accountStore
     requestAccessToAccountsWithType:accountType
     options:nil
     completion:^(BOOL granted, NSError* error) {
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

- (void)showTwitterComposeView
{
    SLComposeViewController* composer = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [self presentViewController:composer animated:YES completion:nil];
}

@end
