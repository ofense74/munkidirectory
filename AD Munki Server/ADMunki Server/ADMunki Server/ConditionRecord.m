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

- (ConditionRecord *)initConditionForGroup:(NSString *)inGroup {
    
    self = [super init];
    group = inGroup;
    filePath = @"/var/tmp/test.plist";
    thePlist = [self getDictFromPlist];
    [self setValues];
    
    return self;
    
    
}

- (NSMutableDictionary *)getDictFromPlist {
    
    //Check if file exists, otherwise point to preferences.
    NSError *err;
    NSInputStream *inStream = [NSInputStream inputStreamWithFileAtPath:filePath];
    [inStream open];
    NSMutableDictionary *fromPlist = [NSPropertyListSerialization propertyListWithStream:inStream
                                                                                 options:NSPropertyListMutableContainersAndLeaves
                                                                                  format:0
                                                                                   error:&err];
    [inStream close];
    
    return fromPlist;
}

- (NSDictionary *)getSubDict {
    
    //Checking against the group string
    NSString *groupString = [NSString stringWithFormat:@"ad_group_membership == \"%@\"", group];
    NSArray *arrayWithDicts = [thePlist valueForKey:@"conditional_items"];
    for (NSDictionary *tempDict in arrayWithDicts) {
        
        if ([[tempDict valueForKey:@"condition"] isEqualToString:groupString]) {
            return tempDict;
        }
        
    }
    return nil;
    
}

- (void)setValues {
    
    NSDictionary *valuesFromPlist = [self getSubDict];
    arrInstalls = [valuesFromPlist objectForKey:@"managed_installs"];
    arrUninstalls = [valuesFromPlist objectForKey:@"managed_unistalls"];
    arrOptionals = [valuesFromPlist objectForKey:@"optional_installs"];
    arrManifests = [valuesFromPlist objectForKey:@"included_manifests"];
    
    installs = [self arrayToString:arrInstalls];
    uninstalls = [self arrayToString:arrUninstalls];
    optional = [self arrayToString:arrOptionals];
    manifests = [self arrayToString:arrManifests];
    
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
