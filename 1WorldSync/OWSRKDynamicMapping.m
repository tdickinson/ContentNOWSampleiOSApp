//
//  OWSRKDynamicMapping.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "OWSRKDynamicMapping.h"
#import <objc/runtime.h>

@implementation OWSRKDynamicMapping

+ (RKObjectMapping *)mappingForClass {
    //should be overridden
    return nil;
}

- (NSString *)description {
    unsigned int varCount;
    NSMutableString *descriptionString = [[NSMutableString alloc]init];
    
    
    objc_property_t *vars = class_copyPropertyList(object_getClass(self), &varCount);
    
    for (int i = 0; i < varCount; i++)
    {
        objc_property_t var = vars[i];
        
        const char* name = property_getName (var);
        
        NSString *keyValueString = [NSString stringWithFormat:@"\n %@ = %@",[NSString stringWithUTF8String:name],[self valueForKey:[NSString stringWithUTF8String:name]]];
        [descriptionString appendString:keyValueString];
    }
    
    free(vars);
    return descriptionString;
}
@end
