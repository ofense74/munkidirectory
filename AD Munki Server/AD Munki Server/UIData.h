//
//  UIData.h
//  ADMunki Server
//
//  Created by Magnus Eliasson on 12/4/12.
//  Copyright (c) 2012 Magnus Eliasson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlistUtil.h"

@interface UIData : NSObject {
    
@private
    PlistUtil *plUtil;
    
}
- (UIData *)initWithPlistUtil;

@end
