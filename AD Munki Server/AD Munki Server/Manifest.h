//
//  Manifest.h
//  AD Munki Server
//
//  Created by Magnus E on 3/3/13.
//  Copyright (c) 2013 Magnus Eliasson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Manifest : NSObject

@property (copy) NSString *fileName;

- (Manifest *)initManifest:(NSString *)name;

@end
