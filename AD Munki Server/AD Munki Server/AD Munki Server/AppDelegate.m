//
//  AppDelegate.m
//  AD Munki Server
//
//  Created by Magnus Eliasson on 12/6/12.
//  Copyright (c) 2012 Magnus Eliasson. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize util;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{

    controller = [[MainWindowController alloc] initWithWindowNibName:@"MainWindow"];
    [controller showWindow:self];
    
}


@end
