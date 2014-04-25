//
//  BeaconCentral.m
//  Multipeer
//
//  Created by Daher Alfawares on 4/14/14.
//  Copyright (c) 2014 Daher Alfawares. All rights reserved.
//

#import "BeaconCentral.hpp"
#import <map>

@interface BeaconCentral()
@property CLBeaconRegion *beaconRegion;
@property CLLocationManager* locationManager;

@end
@implementation BeaconCentral


-(id)init
{
    self = [super init];
    if(self)
    {
        NSLog(@"Monitoring availability       : %@",[CLLocationManager isMonitoringAvailableForClass:[CLBeaconRegion class]] ? @"Yes" : @"No");
        NSLog(@"Location authorization status : %d",[CLLocationManager authorizationStatus]);
        NSLog(@"Location ranging supported    : %@",[CLLocationManager isRangingAvailable] ? @"Yes":@"No");
        
        
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    return self;
}

-(void)monitorRegionWithUDID:(std::string)regionUDID
{
    
    // Beacon UUID
    NSUUID *proximityUUID = [[NSUUID alloc]
                             initWithUUIDString:[NSString stringWithUTF8String:regionUDID.c_str()]];
    
    // Create the beacon region to be monitored.
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID major:1 minor:1 identifier:@"com.solstice-mobile.meetup"];
    
    // Register the beacon region with the location manager.
    [self.locationManager startMonitoringForRegion:self.beaconRegion];
}

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager
         didEnterRegion:(CLRegion *)region
{
    if( [region isKindOfClass:[CLBeaconRegion class]] )
    {
        CLBeaconRegion * beaconRegion = (id)region;
        [self.delegate beaconCentralDidEnterRegion:[[[beaconRegion proximityUUID] UUIDString] UTF8String]];
    }
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    if( [region isKindOfClass:[CLBeaconRegion class]] )
    {
        CLBeaconRegion * beaconRegion = (id)region;
        [self.delegate beaconCentralDidExitRegion:[[[beaconRegion proximityUUID] UUIDString] UTF8String]];
    }
}

@end
