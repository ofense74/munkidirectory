//
//  PreferencesWindowController.m
//  AD Munki Server
//
//  Created by Magnus Eliasson on 1/30/13.
//  Copyright (c) 2013 Magnus Eliasson. All rights reserved.
//

#import "PreferencesWindowController.h"

@interface PreferencesWindowController ()

@end

@implementation PreferencesWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    NSString *label = [[NSUserDefaults standardUserDefaults] valueForKey:@"path"];
    if (! label) {
        [_pathLabel setStringValue:@"Path not set"];
    } else {
        [_pathLabel setStringValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"path"]];
    }
    [self setShouldCascadeWindows:NO];
    [[self window] setFrameAutosaveName:@"PreferenceWindow"];
}

- (IBAction)chooseButton:(id)sender {
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    [openPanel setCanChooseDirectories:YES];
    [openPanel setCanChooseFiles:NO];
    [openPanel setAllowsMultipleSelection:NO];
    [openPanel setCanCreateDirectories:YES];
    [openPanel beginSheetModalForWindow:[self window] completionHandler:^(NSInteger result) {
        if (result == NSOKButton) {
            [self setPath:[openPanel URL]];
            [self updateLabel:[openPanel URL]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"pathUpdate" object:nil];
        }
    }];
}

- (void)setPath:(NSURL *)url {
    [[NSUserDefaults standardUserDefaults] setURL:url forKey:@"path"];
    
    
}

- (void)updateLabel:(NSURL *)url {
    [_pathLabel setStringValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"path"]];
    
}
@end
