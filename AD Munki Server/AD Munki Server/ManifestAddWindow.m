//
//  ManifestAddWindow.m
//  AD Munki Server
//
//  Created by Magnus E on 2/3/13.
//  Copyright (c) 2013 Magnus Eliasson. All rights reserved.
//

#import "ManifestAddWindow.h"

@interface ManifestAddWindow ()

@end

@implementation ManifestAddWindow

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    fileHandler = [[FileHandler alloc] initFileHandler];
}

- (IBAction)addADButton:(id)sender {
}

- (IBAction)removeADButton:(id)sender {
}
@end
