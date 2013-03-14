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
@synthesize adArray, noADArray, ADArrayController, noADArrayController, noADTableView, hasADTableView, fileHandler;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        fileHandler = [[FileHandler alloc] initFileHandler];
        [self getArrays];
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
}

- (void)getArrays {
    
    adArray = [fileHandler hasAD];
    noADArray = [fileHandler noAD];
    
}

- (IBAction)addADButton:(id)sender {
    
    NSArray *selected = [noADArrayController selectedObjects];
    [fileHandler addToManifests:selected];
    [ADArrayController addObjects:selected];
    [noADArrayController removeObjects:selected];
    
    
}

- (IBAction)removeADButton:(id)sender {
    
    NSArray *selected = [ADArrayController selectedObjects];
    [fileHandler removeFromManifests:selected];
    [noADArrayController addObjects:selected];
    [ADArrayController removeObjects:selected];

    
}
@end
