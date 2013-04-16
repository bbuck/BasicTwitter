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
        self.accounts = @[];
        
        //UILabel* label = [[UILabel alloc] init];
        //label
        
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
    self.accounts = [[NSArray alloc] initWithArray:temp];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.accounts.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"@%@", [[self.accounts objectAtIndex:row] username]];
}

- (void)sizeComponents
{
    self.picker.frame = [self getPickerFrame];
}

- (CGRect)getPickerFrame
{
    CGSize screenSize = [BTUtils getScreenSizeForCurrentOrientationMinusStatusBar:YES];
    float pickerY = screenSize.height - 216;
    
    return CGRectMake(0, pickerY, screenSize.width, 216 /* magic height? */);
}

+ (int)needsToDisplayWithAccounts:(NSArray*)theAccounts
                       andAccount:(BTAccount*)anAccount
{
    if (!anAccount)
        return -1;
    
    for (int i = 0, len = theAccounts.count; i < len; i += 1) {
        ACAccount* acAccount = [theAccounts objectAtIndex:i];
        if (acAccount.username == anAccount.username) {
            return i;
        }
    }
    
    return -1;
}

@end
