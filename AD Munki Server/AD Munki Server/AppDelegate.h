//
//  AppDelegate.h
//  AD Munki Server
//
//  Created by Magnus Eliasson on 12/6/12.
//  Copyright (c) 2012 Magnus Eliasson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MainWindowController.h"
#import "PreferencesWindowController.h"
#import "ManifestAddWindow.h"
#import "ApplicationsDragWindow.h"

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    
    MainWindowController *controller;
    PreferencesWindowController *prefController;
    ManifestAddWindow *addManifestWindow;
    ApplicationsDragWindow *appDragWindow;
}


- (IBAction)Save:(id)sender;
- (IBAction)Preferences:(id)sender;
- (IBAction)adManifest:(id)sender;

@end
