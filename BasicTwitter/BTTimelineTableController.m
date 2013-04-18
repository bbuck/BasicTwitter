//
//  BTTimelineTableControllerViewController.m
//  BasicTwitter
//
//  Created by Brandon Buck on 4/17/13.
//  Copyright (c) 2013 Brandon Buck. All rights reserved.
//

#import "BTTimelineTableController.h"

@interface BTTimelineTableController ()

@end

@implementation BTTimelineTableController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Timeline";
        self.accountStore = [[ACAccountStore alloc] init];
        UIBarButtonItem* tweetButton = [[UIBarButtonItem alloc] initWithTitle:@"Tweet"
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:self
                                                                       action:@selector(showTwitterComposeView)];
        self.navigationItem.rightBarButtonItem = tweetButton;
        self.tweets = @[];
        self.tableView.backgroundColor = [UIColor paleYellow];
        
        self.account = [[BTAccount alloc] init];
        [self getTwitterAccount];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweets.count;
}

- (void)processAndSetTweetsFromArray:(NSArray *)theArray
{
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    for (NSDictionary* json in theArray) {
        BTTweet *tweet = [[BTTweet alloc] initWithJSON:json];
        [temp addObject:tweet];
    }
    self.tweets = [[NSArray alloc] initWithArray:temp];
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    BTTweet *tweet = self.tweets[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ @%@", tweet.name, tweet.screenName];
    cell.detailTextLabel.text = tweet.text;
    CGRect detailFrame = cell.detailTextLabel.frame;
    cell.detailTextLabel.frame = CGRectMake(detailFrame.origin.x, detailFrame.origin.y, detailFrame.size.width, 200);
    cell.backgroundColor = [UIColor paleYellow];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BTTweet *tweet = self.tweets[indexPath.row];
    BTTweetView *tweetView = [[BTTweetView alloc] initWithNibName:nil bundle:nil];
    tweetView.tweet = tweet;
    [self.navigationController pushViewController:tweetView animated:YES];
}

- (void)fetchTimeline
{
    NSURL* timelineUrl = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/home_timeline.json"];
    SLRequest* request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                            requestMethod:SLRequestMethodGET
                                                      URL:timelineUrl
                                               parameters:nil];
    [request setAccount:self.account.twitterAccount];
    [request performRequestWithHandler:^(NSData* response, NSHTTPURLResponse* urlResponse, NSError* error)
     {
         NSArray* json = [NSJSONSerialization JSONObjectWithData:response
                                                         options:0
                                                           error:nil];
         [self processAndSetTweetsFromArray:json];
     }];
}

- (void)getAccountFromArray:(NSArray*)theAccounts
{
    if (theAccounts.count == 1) {
        self.account.twitterAccount = theAccounts[0];
        [self fetchTimeline];
    }
    else {
        int index = [BTAccountSelectController needsToDisplayWithAccounts:theAccounts
                                                               andAccount:self.account];
        if (index == NSNotFound) {
            BTAccountSelectController* selectController = [[BTAccountSelectController alloc] initWithNibName:nil bundle:nil];
            selectController.twitterAccounts = theAccounts;
            selectController.delegate = self;
            [self.navigationController presentViewController:selectController
                                                    animated:YES
                                                  completion:nil];
        }
        else {
            self.account.twitterAccount = theAccounts[index];
            [self fetchTimeline];
        }
    }
}

- (void)accountSelectControllerFinished:(BTAccountSelectController *)theSelectController
{
    self.account.twitterAccount = [theSelectController getSelectedTwitterAccount];
    [theSelectController dismissViewControllerAnimated:YES completion:nil];
    [self fetchTimeline];
}

- (void)getTwitterAccount
{
    if (self.account.twitterAccount)
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
