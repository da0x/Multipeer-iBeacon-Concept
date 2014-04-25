//
//  MultipeerAdvertizer.h
//  Multipeer
//
//  Created by Daher Alfawares on 4/14/14.
//  Copyright (c) 2014 Daher Alfawares. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@class MultipeerSession;

@interface MultipeerAdvertizer : NSObject<MCNearbyServiceAdvertiserDelegate>
-(id)initWithSession:(MultipeerSession*)session;
-(void)startAdvertizing;
-(void)stopAdvertizing;
@end
