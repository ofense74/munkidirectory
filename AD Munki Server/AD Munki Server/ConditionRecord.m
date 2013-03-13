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
@synthesize optInstalls;
@synthesize optUninstalls;
@synthesize optOptionals;
@synthesize optManifests;

- (ConditionRecord *)initConditionForDictionary:(NSDictionary *)inDict group:(NSString *)inGroup {
    
    self = [super init];

    group = inGroup;
    
    arrInstalls = [inDict objectForKey:@"managed_installs"];
    optInstalls = [self makeOptArrayFromArray:arrInstalls];
    
    arrUninstalls = [inDict objectForKey:@"managed_uninstalls"];
    optUninstalls = [self makeOptArrayFromArray:arrUninstalls];
    
    arrOptionals = [inDict objectForKey:@"optional_installs"];
    optOptionals = [self makeOptArrayFromArray:arrOptionals];
    
    arrManifests = [inDict objectForKey:@"included_manifests"];
    optManifests = [self makeOptArrayFromArray:arrManifests];
    
    
    return self;
    
    
}

- (NSMutableArray *)makeOptArrayFromArray:(NSArray *)inArray {
    
    NSMutableArray *toReturn = [NSMutableArray array];
    for (NSString *temp in inArray) {
        
        OptionRecord *tempOpt = [[OptionRecord alloc] initWithOption:temp];
        [toReturn addObject:tempOpt];
    }
    return toReturn;
    
}

- (NSArray *)makeStringArrayFromArray:(NSArray *)inOptionArray {
    
    NSMutableArray *toReturn = [NSMutableArray array];
    for (OptionRecord *temp in inOptionArray) {
        
        [toReturn addObject:temp.option];
        
    }
    return toReturn;
    
}



@end
