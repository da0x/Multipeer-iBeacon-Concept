//
//  DPAppDelegate.h
//  Multipeer
//
//  Created by Daher Alfawares on 4/14/14.
//  Copyright (c) 2014 Daher Alfawares. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Multipeer;

@interface DPAppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property Multipeer* multipeer;
@end
