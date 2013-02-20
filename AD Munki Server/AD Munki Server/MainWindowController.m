//
//  MainWindowController.m
//  AD Munki Server
//
//  Created by Magnus Eliasson on 12/10/12.
//  Copyright (c) 2012 Magnus Eliasson. All rights reserved.
//

#import "MainWindowController.h"

@interface MainWindowController ()

@end

@implementation MainWindowController
@synthesize arr;
@synthesize pUtil;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        pUtil = [[PlistUtil alloc] initPlistUtil];
        arr = [pUtil condRecords];
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (void)saveState {
    
    [pUtil putArrToPlist:arr];
}

@end
