//
//  OptionRecord.m
//  AD Munki Server
//
//  Created by Magnus Eliasson on 12/13/12.
//  Copyright (c) 2012 Magnus Eliasson. All rights reserved.
//

#import "OptionRecord.h"

@implementation OptionRecord
@synthesize option;

- (OptionRecord *)initWithOption:(NSString *)inOption {
    
    if ([super init]) {
        option = inOption;
    }
    return self;
    
}

@end
