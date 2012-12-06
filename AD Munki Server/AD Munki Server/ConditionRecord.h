//
//  ConditionRecord.h
//  ADMunki Server
//
//  Created by Magnus Eliasson on 12/4/12.
//  Copyright (c) 2012 Magnus Eliasson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConditionRecord : NSObject {
    
    
}

- (ConditionRecord *)initConditionForDictionary:(NSDictionary *)inDict group:(NSString *)inGroup;

@property (copy) NSString *group;
@property (copy) NSString *installs;
@property (copy) NSString *uninstalls;
@property (copy) NSString *optional;
@property (copy) NSString *manifests;
@property (copy) NSArray *arrInstalls;
@property (copy) NSArray *arrUninstalls;
@property (copy) NSArray *arrOptionals;
@property (copy) NSArray *arrManifests;

@end
