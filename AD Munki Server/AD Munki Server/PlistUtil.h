//
//  PlistUtil.h
//  ADMunki Server
//
//  Created by Magnus Eliasson on 12/5/12.
//  Copyright (c) 2012 Magnus Eliasson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConditionRecord.h"
#import "DirectoryUtil.h"

@interface PlistUtil : NSObject {
    
@private
    DirectoryUtil *dirUtil;

    
}

@property (copy) NSString *filePath;
@property (copy) NSMutableArray *conditions; //Array of conditions in Dictionary format
@property (copy) NSMutableArray *condRecords; //Array with ConditionRecords
@property (copy) NSArray *adGroups;
@property (weak) IBOutlet NSArrayController *arrayController;

- (PlistUtil *)initPlistUtil;
- (void)putArrToPlist:(NSMutableArray *)inArray;

@end
