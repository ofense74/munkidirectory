//
//  Manifest.m
//  AD Munki Server
//
//  Created by Magnus E on 3/3/13.
//  Copyright (c) 2013 Magnus Eliasson. All rights reserved.
//

#import "Manifest.h"

@implementation Manifest
@synthesize fileName;

- (Manifest *)initManifest:(NSString *)name {
    
    self = [super init];
    fileName = name;
    return self;
    
}

@end
