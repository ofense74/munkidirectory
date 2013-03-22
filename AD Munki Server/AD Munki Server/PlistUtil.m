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
@synthesize dirUtil;


- (PlistUtil *)initPlistUtil {
    
    self = [super init];
    NSURL *dirPath = [NSURL fileURLWithPath:[[NSUserDefaults standardUserDefaults] valueForKey:@"path"]];
    filePath = [dirPath URLByAppendingPathComponent:@"ADConditionManifest"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:[filePath path]]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [self writePlist:dict];
    }
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
    NSInputStream *inStream = [NSInputStream inputStreamWithURL:filePath];
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
    NSString *condString = [NSString stringWithFormat:@"ad_group_membership LIKE \"%@\"", inGroup];
    
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
    //Stringify the Optionrecords
    NSMutableArray *stringedArray = [NSMutableArray array];
    for (ConditionRecord *dict in inArray) {
        NSMutableDictionary *newDict = [NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"ad_group_membership LIKE \"%@\"", dict.group]
                                                                          forKey:@"condition"];
        int count = 0;
        
        if ([dict.optInstalls count] > 0) {
            [newDict setObject:[dict makeStringArrayFromArray:dict.optInstalls] forKey:@"managed_installs"];
            count ++;
        }
        if ([dict.optUninstalls count] > 0) {
            [newDict setObject:[dict makeStringArrayFromArray:dict.optUninstalls] forKey:@"managed_uninstalls"];
            count ++;
        }
        if ([dict.optOptionals count] > 0) {
            [newDict setObject:[dict makeStringArrayFromArray:dict.optOptionals] forKey:@"optional_installs"];
            count ++;
        }
        if ([dict.optManifests count] > 0) {
            [newDict setObject:[dict makeStringArrayFromArray:dict.optManifests] forKey:@"included_manifests"];
            count ++;
        }
        
        if (count) {
            [stringedArray addObject:newDict];
        }
        
    }
    
    
    NSMutableDictionary *toPlist = [NSMutableDictionary dictionaryWithObject:stringedArray forKey:@"conditional_items"];
    [self writePlist:toPlist];
    
    
}

- (void)writePlist:(NSMutableDictionary *)plist {
    
    NSOutputStream *outStream = [NSOutputStream outputStreamWithURL:filePath append:NO];
    NSError *err;
    [outStream open];
    [NSPropertyListSerialization writePropertyList:plist
                                          toStream:outStream
                                            format:NSPropertyListXMLFormat_v1_0
                                           options:0
                                             error:&err];
    
    [outStream close];
    
}

@end
