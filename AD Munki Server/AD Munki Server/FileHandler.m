//
//  FileHandler.m
//  AD Munki Server
//
//  Created by Magnus E on 3/3/13.
//  Copyright (c) 2013 Magnus Eliasson. All rights reserved.
//

#import "FileHandler.h"

@implementation FileHandler

@synthesize noAD, hasAD, manifestsArr;

- (FileHandler *)initFileHandler {
    
    self = [super init];
    
    noAD = [NSMutableArray array];
    hasAD = [NSMutableArray array];
    manifestsArr = [NSMutableArray array];
    
    fileManager = [NSFileManager defaultManager];
    path = [[NSUserDefaults standardUserDefaults] valueForKey:@"path"];
    [path stringByExpandingTildeInPath];
    
    NSError *err;
    files = [fileManager contentsOfDirectoryAtPath:path error:&err];

    return self;
}

- (void)makeManifestArray {
    
    for (NSString *file in files) {
        
        if ([file isEqualToString:@"ADConditionManifest"]) {
            continue;
        }
        NSString *fullPath = [path stringByAppendingPathComponent:file];
        if (![NSDictionary dictionaryWithContentsOfFile:fullPath]) {
            continue;
        }
        Manifest *man = [[Manifest alloc] initManifest:file];
        [manifestsArr addObject:man];
    }
    
}

- (void)makeArrays {
    
    for (NSString *file in files) {
        
        if ([file isEqualToString:@"ADConditionManifest"]) {
            continue;
        }
        
        NSError *err;
        NSArray *incManifests = [self readPlistAndReturnIncManifests:file error:&err];
        
        if ([err code] == 5) {
            continue;
        }
        
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

- (NSMutableArray *)readPlistAndReturnIncManifests:(NSString *)fileName error:(NSError **)error {
    NSString *fullPath = [path stringByAppendingPathComponent:fileName];
    NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:fullPath];
    if (!plist) {
        NSDictionary *errodDict = [NSDictionary dictionaryWithObject:@"Not a plist file" forKey:NSLocalizedDescriptionKey];
        *error = [NSError errorWithDomain:@"FileHandler" code:5 userInfo:errodDict];
        return nil;
    }
    NSMutableArray *incMan = [plist objectForKey:@"included_manifests"];
    
    return incMan;
    
}


- (void)addToManifests:(NSArray *)manifests {
    
    for (Manifest *man in manifests) {
        NSString *fullPath = [path stringByAppendingPathComponent:[man fileName]];
        NSMutableDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:fullPath];
        NSError *err;
        NSMutableArray *incMan = [self readPlistAndReturnIncManifests:[man fileName] error:&err];
        
        if (incMan) {
            [incMan addObject:@"ADConditionManifest"];
        }
        else {
            incMan = [NSArray arrayWithObject:@"ADConditionManifest"];
        }
        [plist setObject:incMan forKey:@"included_manifests"];
        [plist writeToFile:fullPath atomically:NO];
    }
    
}

- (void)removeFromManifests:(NSArray *)manifests {
    
    for (Manifest *man in manifests) {
        NSString *fullPath = [path stringByAppendingPathComponent:[man fileName]];
        NSMutableDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:fullPath];
        NSError *err;
        NSMutableArray *incMan = [self readPlistAndReturnIncManifests:[man fileName] error:&err];
        
        if ([incMan count] == 1) {
            [plist removeObjectForKey:@"included_manifests"];
        }
        else {
            [incMan removeObject:@"ADConditionManifest"];
            [plist setObject:incMan forKey:@"included_manifests"];
        }
        [plist writeToFile:fullPath atomically:NO];
    }
    
    
}



































@end
