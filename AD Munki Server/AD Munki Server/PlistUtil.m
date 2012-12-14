//
//  PlistUtil.m
//  ADMunki Server
//
//  Created by Magnus Eliasson on 12/5/12.
//  Copyright (c) 2012 Magnus Eliasson. All rights reserved.
//

#import "PlistUtil.h"

@implementation PlistUtil

@synthesize filePath;
@synthesize conditions;
@synthesize condRecords;
@synthesize adGroups;


- (PlistUtil *)initPlistUtil {
    
    self = [super init];
    filePath = @"/var/tmp/test.plist";
    dirUtil = [[DirectoryUtil alloc] initWithSessionAndNode];
    adGroups = [dirUtil getADGroups];
    conditions = [self getArrFromPlist];
    condRecords = [NSMutableArray array];
    for (NSString *temp in adGroups) {
        [condRecords addObject:[self getRecordForGroup:temp]];
    }
    
    return self;
}

- (NSMutableArray *)getArrFromPlist {
    
    //Check if file exists, otherwise point to preferences.
    NSError *err;
    NSInputStream *inStream = [NSInputStream inputStreamWithFileAtPath:filePath];
    [inStream open];
    NSMutableDictionary *fromPlist = [NSPropertyListSerialization propertyListWithStream:inStream
                                                                                 options:NSPropertyListMutableContainersAndLeaves
                                                                                  format:0
                                                                                   error:&err];
    [inStream close];
    
    NSMutableArray *subDict = [fromPlist objectForKey:@"conditional_items"];
    
    return subDict;
}

- (ConditionRecord *)getRecordForGroup:(NSString *)inGroup {
    
    //Checking against the group string
    NSString *condString = [NSString stringWithFormat:@"ad_group_membership == \"%@\"", inGroup];
    
    for (NSMutableDictionary *dict in conditions) {
        if ([[dict valueForKey:@"condition"] isEqualToString:condString]) {
            ConditionRecord *cond = [[ConditionRecord alloc] initConditionForDictionary:dict group:inGroup];
            return cond;
        }
    }

    ConditionRecord *newCond = [self createNewCond:inGroup];
    
    return newCond;
    
}

- (ConditionRecord *)createNewCond:(NSString *)inGroup {
    
    //Create new condition with empty arrays
    NSMutableArray *installs = [NSMutableArray array];
    NSMutableArray *uninstalls = [NSMutableArray array];
    NSMutableArray *optionals = [NSMutableArray array];
    NSMutableArray *manifests = [NSMutableArray array];
    NSArray *obj = [NSArray arrayWithObjects:installs, uninstalls, optionals, manifests, nil];
    NSArray *keys = [NSArray arrayWithObjects:@"managed_installs", @"managed_uninstalls", @"optional_installs", @"included_manifests", nil];
    
    NSMutableDictionary *tempDict = [NSMutableDictionary dictionaryWithObjects:obj forKeys:keys];
    ConditionRecord *condRec = [[ConditionRecord alloc] initConditionForDictionary:tempDict group:inGroup];
    
    return condRec;
    
}

- (void)putArrToPlist:(NSMutableArray *)inArray {
    
    NSMutableDictionary *toPlist = [NSMutableDictionary dictionaryWithObject:inArray forKey:@"conditional_items"];
    [toPlist writeToFile:filePath atomically:NO];
    
}

@end
