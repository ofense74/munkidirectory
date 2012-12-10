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
    mainWindowController = [[MainWindowController alloc] initWithWindowNibName:@"MainMenu"];
    [mainWindowController showWindow:self];
}

@end
