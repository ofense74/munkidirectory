//
//  ApplicationsDragWindow.h
//  AD Munki Server
//
//  Created by Magnus Eliasson on 3/15/13.
//  Copyright (c) 2013 Magnus Eliasson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppllicationsRetriever.h"

@interface ApplicationsDragWindow : NSWindowController <NSTableViewDataSource>

@property (copy) NSMutableArray *applications;
@property (weak) IBOutlet NSTableView *tView;
@property (strong) IBOutlet NSArrayController *arrayController;

- (void)showTheWindow;

@end
