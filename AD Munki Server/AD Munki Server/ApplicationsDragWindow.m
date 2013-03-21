//
//  ApplicationsDragWindow.m
//  AD Munki Server
//
//  Created by Magnus Eliasson on 3/15/13.
//  Copyright (c) 2013 Magnus Eliasson. All rights reserved.
//

#import "ApplicationsDragWindow.h"

@interface ApplicationsDragWindow ()

@end

@implementation ApplicationsDragWindow
@synthesize applications, tView, arrayController;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        AppllicationsRetriever *appRetriever = [[AppllicationsRetriever alloc] initAppRetriever];
        
        NSString *path = [[NSUserDefaults standardUserDefaults] valueForKey:@"path"];
        [path stringByExpandingTildeInPath];
        NSString *up = [path stringByDeletingLastPathComponent];
        NSString *thePath = [up stringByAppendingPathComponent:@"pkgsinfo"];
        
        [appRetriever getApps:thePath];
        applications = [NSMutableArray array];
        applications = [appRetriever applicationsArray];
        
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    [tView setDataSource:self];
    [self setShouldCascadeWindows:NO];
    [[self window] setFrameAutosaveName:@"ApplicationsDragWindow"];
    
    
}

- (void)showTheWindow {
    [[self window]makeKeyAndOrderFront:self];
}

- (BOOL)tableView:(NSTableView *)tableView writeRowsWithIndexes:(NSIndexSet *)rowIndexes toPasteboard:(NSPasteboard *)pboard {
    
    NSMutableArray *arrData = [NSMutableArray array];
    NSUInteger currentIndex = [rowIndexes firstIndex];
    while (currentIndex != NSNotFound) {
        NSString *theName = [(ApplicationInfo* )[applications objectAtIndex:currentIndex] appName];
        [arrData addObject:theName];
        currentIndex = [rowIndexes indexGreaterThanIndex:currentIndex];
    }
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrData];
    [pboard declareTypes:[NSArray arrayWithObject:@"Applications"] owner:self];
    [pboard setData:data forType:@"Applications"];
    return YES;
    
}


@end
