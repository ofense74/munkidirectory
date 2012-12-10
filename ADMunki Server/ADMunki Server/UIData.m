//
//  UIData.m
//  ADMunki Server
//
//  Created by Magnus Eliasson on 12/4/12.
//  Copyright (c) 2012 Magnus Eliasson. All rights reserved.
//

#import "UIData.h"

@implementation UIData


- (UIData *)initUIData {
    
    self = [super init];
    dUtil = [[DirectoryUtil alloc] initWithSessionAndNode];
    return self;
    
}

- (NSArray *)getADGroups {
    
    return [dUtil getADGroups];
    
}

@end
