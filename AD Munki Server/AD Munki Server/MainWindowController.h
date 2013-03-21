//
//  MainWindowController.h
//  AD Munki Server
//
//  Created by Magnus Eliasson on 12/10/12.
//  Copyright (c) 2012 Magnus Eliasson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PlistUtil.h"
#import "ApplicationsDragWindow.h"
#import "ManifestsWindow.h"
#import "OptionRecord.h"
#import "FileHandler.h"

@interface MainWindowController : NSWindowController <NSTableViewDataSource> {
    
    
}

@property (copy) NSMutableArray *arr;
@property PlistUtil *pUtil;

@property (strong) ApplicationsDragWindow *appDragWindow;
@property (strong) ManifestsWindow *manifestWindow;

@property (weak) IBOutlet NSTableView *installsTView;
@property (weak) IBOutlet NSTableView *unistallsTView;
@property (weak) IBOutlet NSTableView *optionalsTView;
@property (weak) IBOutlet NSTableView *manifestsTView;


- (void)saveState;
- (IBAction)applicationsWindow:(id)sender;
- (IBAction)manifestsWindow:(id)sender;


@end
