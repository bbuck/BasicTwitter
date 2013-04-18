//
//  BTAccountSelectDelegate.h
//  BasicTwitter
//
//  Created by Brandon Buck on 4/17/13.
//  Copyright (c) 2013 Brandon Buck. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BTAccountSelectController;

@protocol BTAccountSelectDelegate <NSObject>

@required
- (void)accountSelectControllerFinished:(BTAccountSelectController*)theAccountController;

@end
