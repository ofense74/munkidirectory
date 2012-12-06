//
//  DirectoryHandler.m
//  munkidirectory
//
//  Created by Magnus Eliasson on 11/29/12.
//  Copyright (c) 2012 Magnus Eliasson. All rights reserved.
//

#import "DirectoryHandler.h"

@implementation DirectoryHandler

- (NSString *)getNameFromDSAD {
    
    NSTask *ad = [[NSTask alloc] init];
    NSPipe *pipe = [[NSPipe alloc] init];
    
    //Get AD computer name from dsconfigad
    [ad setLaunchPath:@"/usr/sbin/dsconfigad"];
    [ad setArguments:[NSArray arrayWithObjects:@"--show", @"--xml", nil]];
    [ad setStandardOutput:pipe];
    [ad launch];
    NSData *output = [[[ad standardOutput] fileHandleForReading] readDataToEndOfFile];
    
    //Get computer name from the Plist
    NSError *err;
    NSDictionary *dict = [NSPropertyListSerialization propertyListWithData:output
                                                                   options:0
                                                                    format:NULL
                                                                     error:&err];
    NSDictionary *gi = [dict valueForKey:@"General Info"];
    NSString *cName = [gi valueForKey:@"Computer Account"];
    cName = [cName stringByReplacingOccurrencesOfString:@"$" withString:@""];
    return cName;
    
}

- (NSArray *)getComuterGroups {
    //Fetch the computer groups from the AD Node
    
    NSString *comp = [self getNameFromDSAD];
    NSString *nodeName = [self getNodeName];
    NSError *err;
    ODSession *session = [ODSession defaultSession];
    ODNode *adNode = [ODNode nodeWithSession:session name:nodeName error:&err];

    ODQuery *query = [ODQuery queryWithNode:adNode
                             forRecordTypes:kODRecordTypeGroups
                                  attribute:kODAttributeTypeRecordName
                                  matchType:kODMatchBeginsWith
                                queryValues:@"MACAPP"
                           returnAttributes:kODAttributeTypeStandardOnly
                             maximumResults:0 error:&err];
    
    NSArray *results = [query resultsAllowingPartial:NO error:&err];
    
    ODRecord *record;
    NSArray *groups = [NSArray array];
    if (results) {
        //There are results, so loop through them and and trim it with only the groups that has the comp as member
        for (record in results) {
            NSArray *tempArrName = [record valuesForAttribute:kODAttributeTypeRecordName error:&err];
            NSArray *tempArrMem = [record valuesForAttribute:kODAttributeTypeGroupMembership error:&err];
            for (int i = 0; i < [tempArrName count]; i++) {
                for (int j = 0; j < [tempArrMem count]; j++) {
                    NSArray *divName = [[tempArrMem objectAtIndex:j] componentsSeparatedByString:@"\\"];
                    NSString *tempComp = [divName objectAtIndex:1];
                    if ([tempComp isEqualTo:comp]) {
                        groups = [groups arrayByAddingObject:[tempArrName objectAtIndex:i]];
                        break;
                    }
                }
            }
        }
    }
    else {
        NSLog(@"Got no results from the search");
        return nil;
    }
    return groups;
    
}

- (NSArray *)getMunkiNames:(NSArray *)inNames {
    
    NSArray *export = [NSArray array];
    for (int i = 0; i < [inNames count]; i++) {
        NSArray *tempArr = [[inNames objectAtIndex:i] componentsSeparatedByString:@"\\"];
        NSString *temp = [tempArr objectAtIndex:1];
        export = [export arrayByAddingObject:temp];
    }
    return export;
}

- (NSString *)getNodeName {
    
    NSError *err;
    ODSession *session = [ODSession defaultSession];
    NSArray *nodes = [session nodeNamesAndReturnError:&err];
    
    //Take out the Active Directory Nodes
    NSArray *adNames = [NSArray array];
    for (NSString *temp in nodes) {
        NSArray *dividedName = [temp pathComponents];
        if ([[dividedName objectAtIndex:1] isEqualTo:@"Active Directory"]) {
            adNames = [adNames arrayByAddingObject:temp];
        }
    }
    
    //Probably ugly but I will return the Node with the longest name since there can be more than one
    NSString *toReturn = [NSString string];
    for (NSString *compare in adNames) {
        if ([compare length] > [toReturn length]) {
            toReturn = compare;
        }
    }
    NSLog(@"Actual AD-Node: %@", toReturn);
    return toReturn;
}

@end
