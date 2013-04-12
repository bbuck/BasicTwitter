//
//  BTAccountPicker.h
//  BasicTwitter
//
//  Created by Brandon Buck on 4/12/13.
//  Copyright (c) 2013 Brandon Buck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTAccountPicker : UIPickerView

@property (strong, nonatomic) NSArray* accounts;

-(id) initWithAccounts:(NSArray*)theAccounts;

@end
