//
//  AppDelegate.m
//  AD Munki Server
//
//  Created by Magnus Eliasson on 12/6/12.
//  Copyright (c) 2012 Magnus Eliasson. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"path"]) {
        if (!prefController) {
            prefController = [[PreferencesWindowController alloc] initWithWindowNibName:@"PreferencesWindowController"];
            [prefController showWindow:self];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotPath:) name:@"pathUpdate" object:nil];
        }
    } else {
        controller = [[MainWindowController alloc] initWithWindowNibName:@"MainWindow"];
        [controller showWindow:self];
    }
    
}


- (IBAction)Save:(id)sender {
    [controller saveState];
    
}

- (IBAction)Preferences:(id)sender {
    if (!prefController) {
        prefController = [[PreferencesWindowController alloc] initWithWindowNibName:@"PreferencesWindowController"];
    }
    [prefController showWindow:self];
    
}

- (IBAction)adManifest:(id)sender {
    if (!addManifestWindow) {
        addManifestWindow = [[ManifestAddWindow alloc] initWithWindowNibName:@"ManifestAddWindow"];
    }
    [addManifestWindow showWindow:self];
}

- (void)gotPath:(NSNotification *)notification {
    controller = [[MainWindowController alloc] initWithWindowNibName:@"MainWindow"];
    [controller showWindow:self];
    
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    
    return YES;
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender {
    if (controller) {
        NSAlert *alert = [NSAlert alertWithMessageText:@"Save your changes?"
                                         defaultButton:@"Save"
                                       alternateButton:@"Cancel"
                                           otherButton:@"Don't save"
                             informativeTextWithFormat:@"Do you wich to save before you quit?\nIf not it will revert to the last saved state next time you open the application."];
        
        [alert beginSheetModalForWindow:[controller window]
                          modalDelegate:self
                         didEndSelector:@selector(alertDidEnd:returnCode:contextInfo:)
                            contextInfo:nil];
    }
    return NSTerminateLater;
    
}

- (void) alertDidEnd:(NSWindow *)alert returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo {
    
    if (returnCode == NSAlertDefaultReturn) {
        [controller saveState];
        [NSApp replyToApplicationShouldTerminate:YES];
    }
    if (returnCode == NSAlertAlternateReturn) {
        [NSApp replyToApplicationShouldTerminate:NO];
    }
    if (returnCode == NSAlertOtherReturn) {
        [NSApp replyToApplicationShouldTerminate:YES];
    }
    
}



@end
