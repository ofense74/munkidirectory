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
    fileManager = [NSFileManager defaultManager];
    path = [[NSUserDefaults standardUserDefaults] valueForKey:@"path"];
    [path stringByExpandingTildeInPath];
    NSError *err;
    files = [fileManager contentsOfDirectoryAtPath:path error:&err];
    NSLog(@"Error: %@", [err localizedDescription]);
    [self makeArrays];
    return self;
}

- (void)makeArrays {
    
    NSLog(@"Path: %@", path);
    NSLog(@"Array:\n%@", files);
    
}

@end
