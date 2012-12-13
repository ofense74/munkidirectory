//
//  AppDelegate.h
//  AD Munki Server
//
//  Created by Magnus Eliasson on 12/6/12.
//  Copyright (c) 2012 Magnus Eliasson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MainWindowController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    
    MainWindowController *controller;
}

@property (strong) PlistUtil *util;

@end
