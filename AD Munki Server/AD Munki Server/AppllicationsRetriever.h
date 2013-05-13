//
//  AppllicationsRetriever.h
//  AD Munki Server
//
//  Created by Magnus Eliasson on 3/15/13.
//  Copyright (c) 2013 Magnus Eliasson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApplicationInfo.h"

@interface AppllicationsRetriever : NSObject

@property (copy) NSMutableArray *applicationsArray;

- (AppllicationsRetriever *)initAppRetriever;
- (void)getApps:(NSString *)path;

@end
