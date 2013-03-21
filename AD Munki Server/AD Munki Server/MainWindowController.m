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
@synthesize appDragWindow, manifestWindow;
@synthesize installsTView, unistallsTView, optionalsTView, manifestsTView;

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
    [manifestsTView setDataSource:self];
    
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

- (IBAction)manifestsWindow:(id)sender {
    
    if (!manifestWindow) {
        manifestWindow = [[ManifestsWindow alloc] initWithWindowNibName:@"ManifestsWindow"];
    }
    [[manifestWindow window] makeKeyAndOrderFront:self];
}

- (BOOL)tableView:(NSTableView *)tableView writeRowsWithIndexes:(NSIndexSet *)rowIndexes toPasteboard:(NSPasteboard *)pboard {
    
    if (tableView == manifestsTView) {
        return NO;
    }
    
    NSData *rows = [NSKeyedArchiver archivedDataWithRootObject:rowIndexes];
    [pboard declareTypes:[NSArray arrayWithObject:@"SameWinApps"] owner:self];
    [pboard setData:rows forType:@"SameWinApps"];
    
    return YES;
    
}

- (NSDragOperation)tableView:(NSTableView *)tableView validateDrop:(id<NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)dropOperation {
    
    if (tableView == [info draggingSource]) {
        return NSDragOperationNone;
    }
    
    [tableView setDropRow:row dropOperation:NSTableViewDropAbove];
    return NSDragOperationGeneric;
}

- (BOOL)tableView:(NSTableView *)tableView acceptDrop:(id<NSDraggingInfo>)info row:(NSInteger)row dropOperation:(NSTableViewDropOperation)dropOperation {
    
    NSPasteboard *pBoard = [info draggingPasteboard];
    NSDictionary *targetDict = [tableView infoForBinding:NSContentBinding];
    NSArrayController *targetArrCont = [targetDict valueForKey:NSObservedObjectKey];
    
    if ([[pBoard types] containsObject:@"SameWinApps"]) {
        
        NSData *data = [pBoard dataForType:@"SameWinApps"];
        NSIndexSet *indexes = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        NSTableView *sourceTView = [info draggingSource];
        NSDictionary *sourceDict = [sourceTView infoForBinding:NSContentBinding];
        NSArrayController *sourceArrCont = [sourceDict valueForKey:NSObservedObjectKey];
        NSArray *objects = [[sourceArrCont arrangedObjects] objectsAtIndexes:indexes];
        
        [targetArrCont addObjects:objects];
        [sourceArrCont removeObjectsAtArrangedObjectIndexes:indexes];
        return YES;
    }
    
    if ([[pBoard types] containsObject:@"Applications"]) {
        NSData *data = [pBoard dataForType:@"Applications"];
        NSArray *sourceStrings = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        for (NSString *temp in sourceStrings) {
            OptionRecord *optRec = [[OptionRecord alloc] initWithOption:temp];
            [targetArrCont addObject:optRec];
        }
        return YES;
    }
    
    if ([[pBoard types] containsObject:@"Manifests"]) {
        NSData *data = [pBoard dataForType:@"Manifests"];
        NSArray *sourceStrings = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        for (NSString *temp in sourceStrings) {
            OptionRecord *optRec = [[OptionRecord alloc] initWithOption:temp];
            [targetArrCont addObject:optRec];
        }
        return YES;
    }
    
    return NO;
}


























@end
