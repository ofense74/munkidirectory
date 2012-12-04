//
//  ConditionRecord.h
//  ADMunki Server
//
//  Created by Magnus Eliasson on 12/4/12.
//  Copyright (c) 2012 Magnus Eliasson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConditionRecord : NSObject {
    
@private
    NSArray *arrInstalls;
    NSArray *arrUninstalls;
    NSArray *arrOptionals;
    NSArray *arrManifests;
    NSString *filePath;
    NSMutableDictionary *thePlist;
    
}

- (ConditionRecord *)initConditionForGroup:(NSString *)group;

@property (copy) NSString *group;
@property (copy) NSString *installs;
@property (copy) NSString *uninstalls;
@property (copy) NSString *optional;
@property (copy) NSString *manifests;

@end
