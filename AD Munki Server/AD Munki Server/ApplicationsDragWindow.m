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
    
    
}

- (void)mouseDragged:(NSEvent *)theEvent {
    
    [tView dragImage:<#(NSImage *)#> at:<#(NSPoint)#> offset:<#(NSSize)#> event:<#(NSEvent *)#> pasteboard:<#(NSPasteboard *)#> source:<#(id)#> slideBack:<#(BOOL)#>];
    
}

- (BOOL)tableView:(NSTableView *)tableView writeRowsWithIndexes:(NSIndexSet *)rowIndexes toPasteboard:(NSPasteboard *)pboard {
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:rowIndexes];
    [pboard declareTypes:[NSArray arrayWithObject:@"Applications"] owner:self];
    [pboard setData:data forType:@"Applications"];
    return YES;
    
}


@end
