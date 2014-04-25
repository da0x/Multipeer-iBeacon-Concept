//
//  MultipeerAdvertizer.m
//  Multipeer
//
//  Created by Daher Alfawares on 4/14/14.
//  Copyright (c) 2014 Daher Alfawares. All rights reserved.
//

#import "MultipeerAdvertizer.h"
#import "MultipeerSession.h"

@interface MultipeerAdvertizer()
@property MultipeerSession* session;
@property MCNearbyServiceAdvertiser* advertizer;
@property BOOL shouldAdvertize;
@end


@implementation MultipeerAdvertizer

-(id)initWithSession:(MultipeerSession *)session
{
    self = [super init];
    if(self)
    {
        self.session = session;
        self.advertizer = [[MCNearbyServiceAdvertiser alloc] initWithPeer:self.session.peerID discoveryInfo:nil serviceType:@"nt-present"];
        self.advertizer.delegate = self;
        
        // detect when app becomes active.
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
    
    return self;
}

-(void)startAdvertizing
{
    [self.advertizer startAdvertisingPeer];
    [self setShouldAdvertize:true];
}

-(void)stopAdvertizing
{
    [self.advertizer stopAdvertisingPeer];
    [self setShouldAdvertize:false];
}

-(void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didReceiveInvitationFromPeer:(MCPeerID *)peerID withContext:(NSData *)context invitationHandler:(void (^)(BOOL, MCSession *))invitationHandler
{
        NSLog(@"Advertizer didReceiveInvitationFromPeer %@", peerID.displayName);
        invitationHandler( true, self.session.session );
}

-(void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didNotStartAdvertisingPeer:(NSError *)error
{
        NSLog(@"Advertizer didNotStartAdvertisingPeer %@",error.localizedDescription);
}

-(void)didEnterForeground:(id)sender
{
    if( self.shouldAdvertize )
        [self.advertizer startAdvertisingPeer];
}

@end
