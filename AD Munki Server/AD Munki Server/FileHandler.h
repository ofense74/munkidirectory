//
//  FileHandler.h
//  AD Munki Server
//
//  Created by Magnus E on 3/3/13.
//  Copyright (c) 2013 Magnus Eliasson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileHandler : NSObject {
    
    NSString *path;
    NSFileManager *fileManager;
    NSArray *files;
    
}

@property (copy) NSMutableArray *noAD;
@property (copy) NSMutableArray *hasAD;

- (FileHandler *)initFileHandler;

@end
