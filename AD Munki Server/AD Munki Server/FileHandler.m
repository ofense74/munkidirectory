//
//  FileHandler.m
//  AD Munki Server
//
//  Created by Magnus E on 3/3/13.
//  Copyright (c) 2013 Magnus Eliasson. All rights reserved.
//

#import "FileHandler.h"

@implementation FileHandler

@synthesize noAD, hasAD;

- (FileHandler *)initFileHandler {
    
    self = [super init];
    
    noAD = [NSMutableArray array];
    hasAD = [NSMutableArray array];
    
    fileManager = [NSFileManager defaultManager];
    path = [[NSUserDefaults standardUserDefaults] valueForKey:@"path"];
    [path stringByExpandingTildeInPath];
    
    NSError *err;
    files = [fileManager contentsOfDirectoryAtPath:path error:&err];
    [self makeArrays];

    return self;
}

- (void)makeArrays {
    
    for (NSString *file in files) {
        NSString *fullPath = [path stringByAppendingPathComponent:file];
        NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:fullPath];
        if (plist) {
            NSArray *incManifests = [plist objectForKey:@"included_manifests"];
            if (!incManifests || ![incManifests containsObject:@"ADConditionManifest"]) {
                Manifest *man = [[Manifest alloc] initManifest:file];
                [noAD addObject:man];
                
            }
            else {
                Manifest *man = [[Manifest alloc] initManifest:file];
                [hasAD addObject:man];
                
            }
        }
        
    }
    
}


- (void)addToManifests:(NSArray *)manifests {
    
    for (Manifest *man in manifests) {
        NSLog(@"In loop");
        NSString *fullPath = [path stringByAppendingPathComponent:[man fileName]];
        NSMutableDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:fullPath];
        NSMutableArray *includedManifests = [plist objectForKey:@"included_manifests"];
        
        if (includedManifests) {
            NSLog(@"There is an Array");
            [includedManifests addObject:@"ADConditionManifest"];
        }
        else {
            NSLog(@"No array");
            NSArray *incManifests = [NSArray arrayWithObject:@"ADConditionManifest"];
            [plist setObject:incManifests forKey:@"included_manifests"];
        }
        
        [plist writeToFile:fullPath atomically:NO];
        [self makeArrays];
    }
    
}

- (void)removeFromManifests:(NSArray *)manifests {
    
    
    
}

@end
