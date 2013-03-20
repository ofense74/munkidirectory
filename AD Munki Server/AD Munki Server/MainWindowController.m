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
@synthesize arr, pUtil;
@synthesize appDragWindow;
@synthesize installsTView, unistallsTView, optionalsTView, manifestsTView;
@synthesize installsArrController, uninstallsArrController, optionalsArrController;

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
    [installsTView registerForDraggedTypes:[NSArray arrayWithObjects:@"Applications", @"SameWinApps", nil]];
    [installsTView setDraggingSourceOperationMask:NSDragOperationMove forLocal:YES];
    
    [unistallsTView registerForDraggedTypes:[NSArray arrayWithObjects:@"Applications", @"SameWinApps", nil]];
    [unistallsTView setDraggingSourceOperationMask:NSDragOperationMove forLocal:YES];
    
    [optionalsTView registerForDraggedTypes:[NSArray arrayWithObjects:@"Applications", @"SameWinApps", nil]];
    [optionalsTView setDraggingSourceOperationMask:NSDragOperationMove forLocal:YES];
    
    [manifestsTView registerForDraggedTypes:[NSArray arrayWithObject:@"Manifests"]];
    
    [installsTView setDataSource:self];
    [unistallsTView setDataSource:self];
    [optionalsTView setDataSource:self];
    
}


- (void)saveState {
    
    [pUtil putArrToPlist:arr];
}

- (IBAction)applicationsWindow:(id)sender {
    
    if (!appDragWindow) {
        appDragWindow = [[ApplicationsDragWindow alloc] initWithWindowNibName:@"ApplicationsDragWindow"];
    }
    [[appDragWindow window] makeKeyAndOrderFront:self];
}

- (BOOL)tableView:(NSTableView *)tableView writeRowsWithIndexes:(NSIndexSet *)rowIndexes toPasteboard:(NSPasteboard *)pboard {
    
    if (tableView == manifestsTView) {
        return NO;
    }
    
    NSDictionary *tvDict = [tableView infoForBinding:NSContentBinding];
    NSArrayController *arrController = [tvDict valueForKey:NSObservedObjectKey];
    NSMutableArray *optURIs = [NSMutableArray array];
    
    for (id optRec in [[arrController arrangedObjects] objectsAtIndexes:rowIndexes]) {

        [optURIs addObject:[[optRec objectID] URIRepresentation]];
    }
    
    [pboard setData:[NSArchiver archivedDataWithRootObject:optURIs] forType:@"SameWinApps"];
    [pboard declareTypes:[NSArray arrayWithObject:@"SameWinApps"] owner:self];
    
    return YES;
    
}

- (NSDragOperation)tableView:(NSTableView *)tableView validateDrop:(id<NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)dropOperation {
    
    [tableView setDropRow:row dropOperation:NSTableViewDropAbove];
    return NSDragOperationMove;
}

- (BOOL)tableView:(NSTableView *)tableView acceptDrop:(id<NSDraggingInfo>)info row:(NSInteger)row dropOperation:(NSTableViewDropOperation)dropOperation {
    
    NSDictionary *controlDict = [tableView infoForBinding:NSContentBinding];
    NSArrayController *tViewController = [controlDict valueForKey:NSObservedObjectKey];
    
    NSManagedObjectContext *context = [[NSApp delegate] managedObjectContext];
    NSPersistentStoreCoordinator *coordinator = [context persistentStoreCoordinator];
    
    
    NSPasteboard *pBoard = [info draggingPasteboard];
    if ([[pBoard types] containsObject:@"SameWinApps"]) {
        NSArray *objURIs = [NSUnarchiver unarchiveObjectWithData:[pBoard dataForType:@"SameWinApps"]];
        for (NSURL *objURI in objURIs) {
            NSManagedObjectID *objID;
            NSManagedObject *obj;
            objID = [coordinator managedObjectIDForURIRepresentation:objURI];
            obj = [context objectWithID:objID];
            [tViewController addObject:obj];
        }
    }
    
    
    return NO;
}


























@end
