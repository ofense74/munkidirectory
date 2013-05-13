//
//  ManifestsWindow.h
//  AD Munki Server
//
//  Created by Magnus Eliasson on 3/21/13.
//  Copyright (c) 2013 Magnus Eliasson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FileHandler.h"
#import "Manifest.h"

@interface ManifestsWindow : NSWindowController <NSTableViewDataSource>

@property (copy) NSMutableArray *arr;
@property FileHandler *fileHandler;
@property (weak) IBOutlet NSTableView *tableView;
@property (strong) IBOutlet NSArrayController *arrayController;

@end
