//
//  DirectoryUtil.h
//  ADMunki Server
//
//  Created by Magnus Eliasson on 12/4/12.
//  Copyright (c) 2012 Magnus Eliasson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenDirectory/OpenDirectory.h>

@interface DirectoryUtil : NSObject {
    
@private ODSession *session;
@private ODNode *node;
    
}

- (DirectoryUtil *)initWithSessionAndNode;
- (NSArray *)getADGroups;

@end
