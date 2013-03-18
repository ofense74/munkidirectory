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
    
}


- (void)saveState {
    
    [pUtil putArrToPlist:arr];
}

- (IBAction)applicationsWindow:(id)sender {
    
    if (!appDragWindow) {
        appDragWindow = [[ApplicationsDragWindow alloc] initWithWindowNibName:@"ApplicationsDragWindow"];
    }
    [appDragWindow showWindow:self];
    
}


@end
