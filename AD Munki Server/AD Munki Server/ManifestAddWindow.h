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
    
    FileHandler *fileHandler;
    
}

@property (copy) NSMutableArray *noADArray;
@property (copy) NSMutableArray *ADArray;
- (IBAction)addADButton:(id)sender;
- (IBAction)removeADButton:(id)sender;

@end
