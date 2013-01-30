//
//  AppDelegate.m
//  AD Munki Server
//
//  Created by Magnus Eliasson on 12/6/12.
//  Copyright (c) 2012 Magnus Eliasson. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{

    controller = [[MainWindowController alloc] initWithWindowNibName:@"MainWindow"];
    [controller showWindow:self];
    
}


- (IBAction)Save:(id)sender {
    [controller saveState];
    
}

- (IBAction)Preferences:(id)sender {
    
    
}


@end
