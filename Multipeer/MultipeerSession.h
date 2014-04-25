//
//  MultipeerSession.h
//  Multipeer
//
//  Created by Daher Alfawares on 4/21/14.
//  Copyright (c) 2014 Daher Alfawares. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>
@class MultipeerSession;

@protocol MultipeerSessionDelegate <NSObject>

-(void)session:(MultipeerSession*)session didConnectPeer:(MCPeerID*)peerID;
-(void)session:(MultipeerSession*)session didDisconnectPeer:(MCPeerID*)peerID;

@end

@interface MultipeerSession : NSObject<MCSessionDelegate>

    // dirty exposed variables, for now.
@property MCPeerID* peerID;
@property MCSession* session;
@property (weak) id<MultipeerSessionDelegate> delegate;


-(void)sendFileNamed:(NSString*)name toPeer:(MCPeerID*)peerID;
@end
