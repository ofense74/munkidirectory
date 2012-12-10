//
//  UIData.h
//  ADMunki Server
//
//  Created by Magnus Eliasson on 12/4/12.
//  Copyright (c) 2012 Magnus Eliasson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DirectoryUtil.h"
#import "ConditionRecord.h"

@interface UIData : NSObject {
    
@private DirectoryUtil *dUtil;
    
}
- (UIData *)initUIData;
- (NSDictionary *)getDataForGroups;

@end
