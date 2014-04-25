//
//  DPViewController.m
//  Multipeer
//
//  Created by Daher Alfawares on 4/14/14.
//  Copyright (c) 2014 Daher Alfawares. All rights reserved.
//

#import "DPViewController.h"
#import "DPAppDelegate.h"
#import "Multipeer.h"

@interface DPViewController ()
@property IBOutlet UIButton* coloredButton;
@end

@implementation DPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

-(IBAction)startSession:(id)sender
{
    DPAppDelegate* appDelegate = (id)[UIApplication sharedApplication].delegate;
    [appDelegate.multipeer startSession];
    
    [self.coloredButton setAlpha:1];
}

-(IBAction)endSession:(id)sender
{
    DPAppDelegate* appDelegate = (id)[UIApplication sharedApplication].delegate;
    [appDelegate.multipeer endSession];
    
    [self.coloredButton setAlpha:0];
}

@end


