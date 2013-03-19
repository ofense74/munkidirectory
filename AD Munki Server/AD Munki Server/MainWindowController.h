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
#import "OptionRecord.h"

@interface MainWindowController : NSWindowController <NSTableViewDataSource> {
    
@private NSArray *dragArr;
    
}

@property (copy) NSMutableArray *arr;
@property PlistUtil *pUtil;

@property (strong) ApplicationsDragWindow *appDragWindow;

@property (weak) IBOutlet NSTableView *installsTView;
@property (weak) IBOutlet NSTableView *unistallsTView;
@property (weak) IBOutlet NSTableView *optionalsTView;
@property (weak) IBOutlet NSTableView *manifestsTView;

@property (strong) IBOutlet NSArrayController *installsArrController;
@property (strong) IBOutlet NSArrayController *uninstallsArrController;
@property (strong) IBOutlet NSArrayController *optionalsArrController;


- (void)saveState;
- (IBAction)applicationsWindow:(id)sender;


@end
