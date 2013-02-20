//
//  DirectoryHandler.h
//  munkidirectory
//
//  Created by Magnus Eliasson on 11/29/12.
//  Copyright (c) 2012 Magnus Eliasson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenDirectory/OpenDirectory.h>

@interface DirectoryHandler : NSObject

- (NSString *)getNameFromDSAD;
- (NSArray *)getComuterGroups;
- (NSArray *)getMunkiNames:(NSArray *)inNames;
- (NSString *)getNodeName;

@end
