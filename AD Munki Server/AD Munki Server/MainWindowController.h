//
//  MainWindowController.h
//  AD Munki Server
//
//  Created by Magnus Eliasson on 12/10/12.
//  Copyright (c) 2012 Magnus Eliasson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PlistUtil.h"
#import "ApplicationsDragWindow.h"

@interface MainWindowController : NSWindowController {
    
    ApplicationsDragWindow *appDragWindow;
    
}

@property (copy) NSMutableArray *arr;
@property PlistUtil *pUtil;

- (void)saveState;
- (IBAction)applicationsWindow:(id)sender;

@end
