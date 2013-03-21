//
//  ManifestsWindow.m
//  AD Munki Server
//
//  Created by Magnus Eliasson on 3/21/13.
//  Copyright (c) 2013 Magnus Eliasson. All rights reserved.
//

#import "ManifestsWindow.h"

@interface ManifestsWindow ()

@end

@implementation ManifestsWindow
@synthesize fileHandler, arr, tableView;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        fileHandler = [[FileHandler alloc] initFileHandler];
        [fileHandler makeManifestArray];
        arr = [fileHandler manifestsArr];
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    [tableView setDataSource:self];
    [self setShouldCascadeWindows:NO];
    [[self window] setFrameAutosaveName:@"ManifestsDragWindow"];
}

- (BOOL)tableView:(NSTableView *)tableView writeRowsWithIndexes:(NSIndexSet *)rowIndexes toPasteboard:(NSPasteboard *)pboard {
    
    NSMutableArray *arrData = [NSMutableArray array];
    NSUInteger currentIndex = [rowIndexes firstIndex];
    while (currentIndex != NSNotFound) {
        NSString *theName = [(Manifest* )[arr objectAtIndex:currentIndex] fileName];
        [arrData addObject:theName];
        currentIndex = [rowIndexes indexGreaterThanIndex:currentIndex];
    }
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrData];
    [pboard declareTypes:[NSArray arrayWithObject:@"Manifests"] owner:self];
    [pboard setData:data forType:@"Manifests"];
    return YES;
    
}

@end
