//
//  ConditionRecord.m
//  ADMunki Server
//
//  Created by Magnus Eliasson on 12/4/12.
//  Copyright (c) 2012 Magnus Eliasson. All rights reserved.
//

#import "ConditionRecord.h"

@implementation ConditionRecord

@synthesize group;
@synthesize installs;
@synthesize uninstalls;
@synthesize optional;
@synthesize manifests;
@synthesize arrInstalls;
@synthesize arrUninstalls;
@synthesize arrOptionals;
@synthesize arrManifests;

- (ConditionRecord *)initConditionForDictionary:(NSDictionary *)inDict group:(NSString *)inGroup {
    
    self = [super init];

    group = [NSString stringWithString:inGroup];
    NSLog(@"Got group %@ to handle", group);
    arrInstalls = [inDict objectForKey:@"managed_installs"];
    arrUninstalls = [inDict objectForKey:@"managed_unistalls"];
    arrOptionals = [inDict objectForKey:@"optional_installs"];
    arrManifests = [inDict objectForKey:@"included_manifests"];
    
    installs = [self arrayToString:arrInstalls];
    uninstalls = [self arrayToString:arrUninstalls];
    optional = [self arrayToString:arrOptionals];
    manifests = [self arrayToString:arrManifests];
    
    return self;
    
    
}


- (NSString *)arrayToString:(NSArray *)inArray {
    
    NSMutableString *temp = [NSMutableString string];
    for (NSString *loopTemp in inArray) {
        [temp appendString:loopTemp];
        [temp appendString:@" "];
    }
    return temp;
}

@end
