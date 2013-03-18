//
//  AppllicationsRetriever.m
//  AD Munki Server
//
//  Created by Magnus Eliasson on 3/15/13.
//  Copyright (c) 2013 Magnus Eliasson. All rights reserved.
//

#import "AppllicationsRetriever.h"

@implementation AppllicationsRetriever

@synthesize applicationsArray;

- (AppllicationsRetriever *)initAppRetriever {
    
    self = [super init];
    applicationsArray = [NSMutableArray array];
    return self;
    
}

- (void)getApps:(NSString *)path {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if ([fileManager fileExistsAtPath:path isDirectory:&isDir] && isDir) {
        NSError *err;
        NSArray *filesFolders = [fileManager contentsOfDirectoryAtPath:path error:&err];
        for (NSString *fileName in filesFolders) {
            NSString *newPath = [path stringByAppendingPathComponent:fileName];
            [self getApps:newPath];
        }
    }
    else {
        NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:path];
        if (plist && ![plist objectForKey:@"update_for"]) {
            ApplicationInfo *appInfo = [[ApplicationInfo alloc] init];
            [appInfo setAppName:[plist objectForKey:@"name"]];
            [appInfo setAppVersion:[plist objectForKey:@"version"]];
            [applicationsArray addObject:appInfo];
        }
        
    }
    
}

@end
