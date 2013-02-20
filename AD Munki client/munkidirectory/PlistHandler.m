//
//  PlistHandler.m
//  munkidirectory
//
//  Created by Magnus Eliasson on 11/29/12.
//  Copyright (c) 2012 Magnus Eliasson. All rights reserved.
//

#import "PlistHandler.h"

@implementation PlistHandler

- (void)createPlistFromNames:(NSArray *)names compName:(NSString *)compName nodeName:(NSString *)nodeName {
    
    //Change this to the path given in ManagedInstalls.plist
    NSString *path = @"/Library/Managed Installs/ConditionalItems.plist";
    NSError *err;
    NSInteger plist;
    
    if (! [[NSFileManager defaultManager] fileExistsAtPath:path]) {
        //Create a new plistfile
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObject:names forKey:@"ad_group_membership"];
        [dict setObject:compName forKey:@"ad_computer_name"];
        [dict setObject:nodeName forKey:@"ad_node_name"];
        
        NSOutputStream *output = [NSOutputStream outputStreamToFileAtPath:path append:NO];
        [output open];
        
        plist = [NSPropertyListSerialization writePropertyList:(id)dict
                                                      toStream:output
                                                        format:NSPropertyListXMLFormat_v1_0
                                                       options:NSPropertyListMutableContainersAndLeaves
                                                         error:&err];
        [output close];
    }
    else {
        //There is a plist file so import it and add to it.
        NSInputStream *inStream = [NSInputStream inputStreamWithFileAtPath:path];
        [inStream open];
        NSMutableDictionary *fromPlist = [NSPropertyListSerialization propertyListWithStream:inStream
                                                                              options:NSPropertyListMutableContainersAndLeaves
                                                                               format:0
                                                                                error:&err];
        [inStream close];
        [fromPlist setObject:names forKey:@"ad_group_membership"];
        [fromPlist setObject:compName forKey:@"ad_computer_name"];
        [fromPlist setObject:nodeName forKey:@"ad_node_name"];
        NSOutputStream *outStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
        [outStream open];
        plist = [NSPropertyListSerialization writePropertyList:(id)fromPlist
                                                      toStream:outStream
                                                        format:NSPropertyListXMLFormat_v1_0
                                                       options:NSPropertyListMutableContainersAndLeaves
                                                         error:&err];
        [outStream close];
        
    }
    
     
}


@end
