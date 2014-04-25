//
//  Multipeer.m
//  Multipeer
//
//  Created by Daher Alfawares on 4/14/14.
//  Copyright (c) 2014 Daher Alfawares. All rights reserved.
//

#import "MultipeerBrowser.h"
#import "MultipeerSession.h"

@interface MultipeerBrowser()
@property MultipeerSession* session;
@property MCNearbyServiceBrowser* browser;
@end

@implementation MultipeerBrowser

-(id)initWithSession:(MultipeerSession*)session
{
    self = [super init];
    if(self)
    {
        self.session = session;
        self.browser = [[MCNearbyServiceBrowser alloc] initWithPeer:self.session.peerID serviceType:@"nt-present"];
        self.browser.delegate = self;
    }
    return self;
}

-(void)startBrowsing
{
    [self.browser startBrowsingForPeers];
}

-(void)stopBrowsing
{
    [self.browser stopBrowsingForPeers];
}

-(void)browser:(MCNearbyServiceBrowser *)browser didNotStartBrowsingForPeers:(NSError *)error
{
        NSLog(@"browser didNotStartBrowsingForPeers %@", error);
}

-(void)browser:(MCNearbyServiceBrowser *)browser foundPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info
{
        NSLog(@"browser found peer %@", peerID.displayName);
        [self.browser invitePeer:peerID toSession:self.session.session withContext:nil timeout:0u];
}

-(void)browser:(MCNearbyServiceBrowser *)browser lostPeer:(MCPeerID *)peerID
{
        NSLog(@"browser lost peer %@", peerID.displayName);
}

@end


