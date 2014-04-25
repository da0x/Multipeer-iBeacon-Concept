//
//  MultipeerSession.m
//  Multipeer
//
//  Created by Daher Alfawares on 4/21/14.
//  Copyright (c) 2014 Daher Alfawares. All rights reserved.
//

#import "MultipeerSession.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation MultipeerSession

-(id)init
{
    self = [super init];
    if(self)
    {
        self.peerID = [[MCPeerID alloc] initWithDisplayName:[[UIDevice currentDevice] name]];
        self.session = [[MCSession alloc] initWithPeer:self.peerID];
        self.session.delegate = self;
    }
    return self;
}

-(void)sendFileNamed:(NSString*)name toPeer:(MCPeerID*)peerID
{
    NSURL* url = [NSURL URLWithString:[NSBundle pathForResource:name ofType:nil inDirectory:nil]];
    [self.session sendResourceAtURL:url withName:name toPeer:peerID withCompletionHandler:^(NSError *error) {
        NSLog(@"File %@ was sent to %@", name, peerID.displayName );
    }];
}

-(void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error
{
    NSLog(@"session didFinishReceivingResourceWithName");
}

-(void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"session peer %@ is %@", peerID.displayName, [self stringWithState:state]);
    });
    
    if( state == MCSessionStateConnected )
        return [self.delegate session:self didConnectPeer:peerID];
    
    if( state == MCSessionStateNotConnected )
        return [self.delegate session:self didDisconnectPeer:peerID];
}

- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID
{
    NSLog(@"session didReceiveData %@ from peer %@", data, peerID.displayName);
}

-(void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID
{
    NSLog(@"session didReceiveStream");
}

-(void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress
{
    NSLog(@"session didStartReceivingResourceWithName");
}

-(void)session:(MCSession *)session didReceiveCertificate:(NSArray *)certificate fromPeer:(MCPeerID *)peerID certificateHandler:(void (^)(BOOL))certificateHandler
{
    NSLog(@"session didReceiveCertificate");
    certificateHandler(true);
}

-(NSString*)stringWithState:(MCSessionState)state
{
    switch (state) {
        case MCSessionStateConnecting:
            return @"connecting";
        case MCSessionStateConnected:
            return @"connected";
        case MCSessionStateNotConnected:
            return @"disconnected";
    }
    return @"unknown";
}

#pragma mark send / recv

-(void)sendData
{
    NSString* data = @"Hello world";
    NSError* error = nil;
    [self.session sendData:[data dataUsingEncoding:NSStringEncodingConversionAllowLossy] toPeers:[self.session connectedPeers] withMode:MCSessionSendDataReliable error:&error];
}

-(void)beep
{
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"alert" ofType:@"wav"];
    
    SystemSoundID soundID;
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
    
    AudioServicesPlaySystemSound (soundID);
}

@end
