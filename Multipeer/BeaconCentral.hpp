//
//  BeaconCentral.h
//  Multipeer
//
//  Created by Daher Alfawares on 4/14/14.
//  Copyright (c) 2014 Daher Alfawares. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#include <string>

@protocol BeaconCentralDelegate <NSObject>
-(void)beaconCentralDidEnterRegion:(std::string)regionUDID;
-(void)beaconCentralDidExitRegion:(std::string)regionUDID;
@end

@interface BeaconCentral : NSObject<CLLocationManagerDelegate>
@property (weak) id<BeaconCentralDelegate> delegate;
-(void)monitorRegionWithUDID:(std::string)regionUDID;
@end

