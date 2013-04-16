//
//  BTUtils.m
//  BasicTwitter
//
//  Created by Brandon Buck on 4/15/13.
//  Copyright (c) 2013 Brandon Buck. All rights reserved.
//

#import "BTUtils.h"

@implementation BTUtils

+ (CGSize)getScreenSizeForCurrentOrientation
{
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    CGSize returnSize = CGSizeMake(0, 0);
    
    
    if (UIDeviceOrientationIsLandscape(orientation)) {
        returnSize.width = screenSize.height;
        returnSize.height = screenSize.width;
    }
    else {
        returnSize.width = screenSize.width;
        returnSize.height = screenSize.height;
    }
    
    return returnSize;
}

+ (CGSize)getScreenSizeForCurrentOrientationMinusStatusBar:(BOOL)countStatusBar
{
    CGSize screenSize = [BTUtils getScreenSizeForCurrentOrientation];
    if (countStatusBar) {
        float statusBarHeight = [BTUtils getStatusBarHeight];
        screenSize.height = screenSize.height - statusBarHeight;
    }
    return screenSize;
}

+ (float)getStatusBarHeight
{
    float statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    // Don't know why this happens, but it does.
    if (statusBarHeight != kStatusBarSizeLarge
        || statusBarHeight != kStatusBarSizeSmall
        || statusBarHeight != kStatusBarSizeHidden)
        statusBarHeight = 20;
    return statusBarHeight;
}

@end
