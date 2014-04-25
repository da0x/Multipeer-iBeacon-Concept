//
//  Multipeer.m
//  Multipeer
//
//  Created by Daher Alfawares on 4/15/14.
//  Copyright (c) 2014 Daher Alfawares. All rights reserved.
//

#import "Multipeer.h"
#import "Beacon.hpp"
#import "BeaconCentral.hpp"
#import "MultipeerAdvertizer.h"
#import "MultipeerBrowser.h"
#import "MultipeerSession.h"

namespace global
{
    namespace constant
    {
        namespace
        {
            std::string region_udid = "757278b2-49c5-4a09-b1e4-81e589229726";
        }
    }
}

@interface Multipeer ()
@property Beacon *              sessionBeacon;
@property BeaconCentral*        sessionBeaconCentral;
@property MultipeerAdvertizer * multipeerAdvertizer;
@property MultipeerBrowser*     multipeerBrowser;
@property MultipeerSession*     multipeerSession;

@property UILocalNotification*  sessionNotification;
@end

@implementation Multipeer

- (id)init
{
    self = [super init];
    if(self)
    {
            // init the beacon.
        self.sessionBeacon = [[Beacon alloc] initWithUUID:global::constant::region_udid withMajor:1 withMinor:1];
        
            // init the beacon central.
        self.sessionBeaconCentral = [[BeaconCentral alloc] init];
        [self.sessionBeaconCentral setDelegate:self];
        [self.sessionBeaconCentral monitorRegionWithUDID:global::constant::region_udid];
        
            // init the notification.
        self.sessionNotification = [[UILocalNotification alloc] init];
        self.sessionNotification.alertAction = @"join the session";
        self.sessionNotification.alertBody = @"A session has started";
        self.sessionNotification.soundName = UILocalNotificationDefaultSoundName;
        
            // init the session.
        self.multipeerSession = [[MultipeerSession alloc] init];
        
            // init the browser.
        self.multipeerBrowser = [[MultipeerBrowser alloc] initWithSession:self.multipeerSession];
        
            // init the advertizer.
        self.multipeerAdvertizer = [[MultipeerAdvertizer alloc] initWithSession:self.multipeerSession];
    }
    return self;
}

-(void)startSession
{
        // first, start advertizing session connectivity.
    [self.multipeerBrowser startBrowsing];
    
        // second, start advertizing beacons to wake up devices.
    [self.sessionBeacon startAdvertizing];
}

-(void)endSession
{
        // stop advertizing beacons to wake up devices.
    [self.sessionBeacon stopAdvertizing];
    
        // stop browsing for peers.
    [self.multipeerBrowser stopBrowsing];
}

-(void)joinSession
{
        // announce yourself as a potential peer.
    [self.multipeerAdvertizer startAdvertizing];
}

-(void)leaveSession
{
        // stop advertizing.
    [self.multipeerAdvertizer stopAdvertizing];
}

#pragma mark Helper functions

-(void)beaconCentralDidEnterRegion:(std::string)regionUDID
{
    [[UIApplication sharedApplication] presentLocalNotificationNow:self.sessionNotification];
}

-(void)beaconCentralDidExitRegion:(std::string)regionUDID
{
    [[UIApplication sharedApplication] cancelLocalNotification:self.sessionNotification];
}

#pragma mark Session Delegate

-(void)session:(MultipeerSession*)session didConnectPeer:(MCPeerID*)peerID
{
    [session sendFileNamed:@"sample.pdf" toPeer:peerID];
}

-(void)session:(MultipeerSession*)session didDisconnectPeer:(MCPeerID*)peerID
{
    
}


@end
