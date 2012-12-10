//
//  AppDelegate.h
//  ADMunki Server
//
//  Created by Magnus Eliasson on 12/3/12.
//  Copyright (c) 2012 Magnus Eliasson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "UIData.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSScrollView *view;
- (IBAction)edit:(id)sender;
@property (weak) IBOutlet NSArrayController *arrayController;

@end
