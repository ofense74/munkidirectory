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
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"path"]) {
        if (!prefController) {
            prefController = [[PreferencesWindowController alloc] initWithWindowNibName:@"PreferencesWindowController"];
            [prefController showWindow:self];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotPath:) name:@"pathUpdate" object:nil];
        }
    } else {
        controller = [[MainWindowController alloc] initWithWindowNibName:@"MainWindow"];
        [controller showWindow:self];
    }
    
}


- (IBAction)Save:(id)sender {
    [controller saveState];
    
}

- (IBAction)Preferences:(id)sender {
    if (!prefController) {
        prefController = [[PreferencesWindowController alloc] initWithWindowNibName:@"PreferencesWindowController"];
    }
    [prefController showWindow:self];
    
}

- (void)gotPath:(NSNotification *)notification {
    controller = [[MainWindowController alloc] initWithWindowNibName:@"MainWindow"];
    [controller showWindow:self];
    
}



@end
