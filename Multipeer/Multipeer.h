//
//  Multipeer.h
//  Multipeer
//
//  Created by Daher Alfawares on 4/15/14.
//  Copyright (c) 2014 Daher Alfawares. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "Beacon.hpp"
#import "BeaconCentral.hpp"
#import "MultipeerSession.h"

@interface Multipeer : NSObject<BeaconCentralDelegate,MultipeerSessionDelegate>

    // host a session.
-(void)startSession;
-(void)endSession;

    // join existing.
-(void)joinSession;
-(void)leaveSession;

@end
