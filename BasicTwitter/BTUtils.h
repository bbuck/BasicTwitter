//
//  BTUtils.h
//  BasicTwitter
//
//  Created by Brandon Buck on 4/15/13.
//  Copyright (c) 2013 Brandon Buck. All rights reserved.
//

#define REGISTER_FOR_ORIENTATION_CHANGE(selectorName) \
    [[NSNotificationCenter defaultCenter]\
        addObserver:self \
           selector:@selector(selectorName) \
               name:UIDeviceOrientationDidChangeNotification \
             object:nil];

#import <Foundation/Foundation.h>

#import "Constants.h"

@interface BTUtils : NSObject

+ (CGSize)getScreenSizeForCurrentOrientation;
+ (CGSize)getScreenSizeForCurrentOrientationMinusStatusBar:(BOOL)countStatusBar;
+ (float)getStatusBarHeight;

@end
