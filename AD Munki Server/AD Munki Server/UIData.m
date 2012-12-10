//
//  UIData.m
//  ADMunki Server
//
//  Created by Magnus Eliasson on 12/4/12.
//  Copyright (c) 2012 Magnus Eliasson. All rights reserved.
//

#import "UIData.h"

@implementation UIData

- (UIData *)initWithPlistUtil {
    
    self = [super init];
    plUtil = [[PlistUtil alloc] initPlistUtil];
    return self;
    
}


@end
