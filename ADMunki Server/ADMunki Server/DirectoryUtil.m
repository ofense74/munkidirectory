//
//  DirectoryUtil.m
//  ADMunki Server
//
//  Created by Magnus Eliasson on 12/4/12.
//  Copyright (c) 2012 Magnus Eliasson. All rights reserved.
//

#import "DirectoryUtil.h"

@implementation DirectoryUtil

- (DirectoryUtil *)initWithSessionAndNode {
    
    NSError *err;
    self = [super init];
    session = [ODSession defaultSession];
    node = [ODNode nodeWithSession:session name:[self getADNode] error:&err];
    
    if (err) {
        return nil;
    }
    else {
        return self;
    }
    
}

- (NSArray *)getADGroups {
    
    NSError *err;
    ODQuery *query = [ODQuery queryWithNode:node
                             forRecordTypes:kODRecordTypeGroups
                                  attribute:kODAttributeTypeRecordName
                                  matchType:kODMatchBeginsWith
                                queryValues:@"MACAPP"
                           returnAttributes:kODAttributeTypeStandardOnly
                             maximumResults:0 error:&err];
    
    NSArray *results = [query resultsAllowingPartial:NO error:&err];
    NSArray *final = [NSArray array];
    
    for (ODRecord *record in results) {
        
        NSArray *temp = [record valuesForAttribute:kODAttributeTypeRecordName error:&err];
        NSArray *div = [[temp objectAtIndex:0] componentsSeparatedByString:@"\\"];
        final = [final arrayByAddingObject:[div objectAtIndex:1]];
    }
    NSLog(@"Array of Groups: %@", final);
    return final;
    
}

- (NSString *)getADNode {
    
    NSError *err;
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
