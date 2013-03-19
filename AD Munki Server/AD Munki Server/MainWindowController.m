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
    [installsTView registerForDraggedTypes:[NSArray arrayWithObjects:@"SameWinApps", @"Applications", nil]];
    [unistallsTView registerForDraggedTypes:[NSArray arrayWithObjects:@"SameWinApps", @"Applications", nil]];
    [optionalsTView registerForDraggedTypes:[NSArray arrayWithObjects:@"SameWinApps", @"Applications", nil]];
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
    if (tableView == installsTView) {
        dragArr = [installsArrController selectedObjects];
    }
    if (tableView == unistallsTView) {
        dragArr = [uninstallsArrController selectedObjects];
    }
    if (tableView == optionalsTView) {
        dragArr = [optionalsArrController selectedObjects];
    }
    
    [pboard declareTypes:[NSArray arrayWithObject:@"SameWinApps"] owner:self];
    
    return YES;
    
}

- (NSDragOperation)tableView:(NSTableView *)tableView validateDrop:(id<NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)dropOperation {
    
    
    return NSDragOperationCopy;   
    
}

- (BOOL)tableView:(NSTableView *)tableView acceptDrop:(id<NSDraggingInfo>)info row:(NSInteger)row dropOperation:(NSTableViewDropOperation)dropOperation {
    
    NSPasteboard *pBoard = [info draggingPasteboard];
    if ([[pBoard types] containsObject:@"Applications"]) {
        
        NSArray *arrData = [NSKeyedUnarchiver unarchiveObjectWithData:[pBoard dataForType:@"Applications"]];
        for (NSString *temp in arrData) {
            
            OptionRecord *optRec = [[OptionRecord alloc] initWithOption:temp];
            if (tableView == installsTView) {
                [installsArrController addObject:optRec];
            }
            if (tableView == unistallsTView) {
                [uninstallsArrController addObject:optRec];
            }
            if (tableView == optionalsTView) {
                [optionalsArrController addObject:optRec];
            }
            return YES;
            
        }
    }
    if ([[pBoard types] containsObject:@"SameWinApps"]) {
        if (tableView == installsTView) {
            [installsArrController addObjects:dragArr];
        }
        if (tableView == unistallsTView) {
            [uninstallsArrController addObjects:dragArr];
        }
        if (tableView == optionalsTView) {
            [optionalsArrController addObjects:dragArr];
        }
        return YES;
    }
    
    return NO;
}


























@end
