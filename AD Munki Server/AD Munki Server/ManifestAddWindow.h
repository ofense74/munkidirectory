//
//  ManifestAddWindow.h
//  AD Munki Server
//
//  Created by Magnus E on 2/3/13.
//  Copyright (c) 2013 Magnus Eliasson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FileHandler.h"

@interface ManifestAddWindow : NSWindowController {
    
    
}
@property FileHandler *fileHandler;

@property (copy) NSMutableArray *noADArray;
@property (strong) IBOutlet NSArrayController *noADArrayController;

@property (copy) NSMutableArray *adArray;
@property (strong) IBOutlet NSArrayController *ADArrayController;

@property (weak) IBOutlet NSTableView *noADTableView;
@property (weak) IBOutlet NSTableView *hasADTableView;



- (IBAction)addADButton:(id)sender;
- (IBAction)removeADButton:(id)sender;

@end
