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

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    
    MainWindowController *controller;
    PreferencesWindowController *prefController;
}


- (IBAction)Save:(id)sender;
- (IBAction)Preferences:(id)sender;

@end
