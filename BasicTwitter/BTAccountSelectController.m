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
        self.view.backgroundColor = [UIColor paleYellow];
        self.picker = [[UIPickerView alloc] initWithFrame:[self getPickerFrame]];
        self.picker.dataSource = self;
        self.picker.delegate = self;
        self.picker.showsSelectionIndicator = YES;
        [self.view addSubview:self.picker];
        self.twitterAccounts = @[];
        
        CGSize screenSize = [BTUtils getScreenSizeForCurrentOrientationMinusStatusBar:YES];
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, 100)];
        self.label.text = @"Select a Twitter Account to Use";
        self.label.backgroundColor = [UIColor paleYellow];
        self.label.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.numberOfLines = 0;
        self.label.lineBreakMode = NSLineBreakByWordWrapping;
        [self.view addSubview:self.label];
        
        self.doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.doneButton setTitle:@"Done" forState:UIControlStateNormal];
        self.doneButton.frame = CGRectMake(10, screenSize.height - 60, screenSize.width - 20, 50);
        [self.doneButton addTarget:self
                            action:@selector(selectTwitterAccount)
                  forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.doneButton];
        
        REGISTER_FOR_ORIENTATION_CHANGE(sizeComponents)
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self sizeComponents];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setAccountsSource:(NSArray*)theAccounts
{
    NSMutableArray* temp = [[NSMutableArray alloc] init];
    for (ACAccount* account in theAccounts)
        [temp addObject:account.username];
    self.twitterAccounts = [[NSArray alloc] initWithArray:temp];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.twitterAccounts.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"@%@", [[self.twitterAccounts objectAtIndex:row] username]];
}

- (void)sizeComponents
{
    CGSize screenSize = [BTUtils getScreenSizeForCurrentOrientationMinusStatusBar:YES];
    self.picker.frame = [self getPickerFrame];
    
    CGRect labelFrame = CGRectMake(0, 0, screenSize.width, 0);
    if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation]))
        labelFrame.size.height = 50;
    else
        labelFrame.size.height = 100;
    self.label.frame = labelFrame;
    self.doneButton.frame = CGRectMake(10, screenSize.height - 60, screenSize.width - 20, 50);
}

- (CGRect)getPickerFrame
{
    CGSize screenSize = [BTUtils getScreenSizeForCurrentOrientationMinusStatusBar:YES];
    
    float pickerHeight = 0;
    if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation]))
        pickerHeight = kUIPickerViewSmall;
    else
        pickerHeight = kUIPickerViewLarge;
    float pickerY = screenSize.height - pickerHeight - 70;
    
    return CGRectMake(0, pickerY, screenSize.width, pickerHeight);
}

- (ACAccount *)getSelectedTwitterAccount
{
    NSInteger index = [self.picker selectedRowInComponent:0];
    return self.twitterAccounts[index];
}

- (void)selectTwitterAccount
{
    [self.delegate accountSelectControllerFinished:self];
}

// Determine if this view needs to display
+ (int)needsToDisplayWithAccounts:(NSArray*)theAccounts
                       andAccount:(BTAccount*)anAccount
{
    if (!anAccount)
        return NSNotFound;
    
    for (int i = 0, len = theAccounts.count; i < len; i += 1) {
        ACAccount* acAccount = [theAccounts objectAtIndex:i];
        if (acAccount.username == anAccount.username) {
            return i;
        }
    }
    
    return NSNotFound;
}

@end
