//
//  OWSOfficeComponentInformation.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "OWSOfficeComponentInformation.h"
#import <RestKit/RestKit.h>

@implementation OWSOfficeComponentInformation

+ (RKObjectMapping *)mappingForClass {
    RKObjectMapping* map = [RKObjectMapping mappingForClass:[self class]];
    [map addAttributeMappingsFromArray:@[@"componentNumber"]];

    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"componentDescription"
                                                                        toKeyPath:@"componentDescription"
                                                                      withMapping:[OWSObjectDescription mappingForClass]]];
    return map;
}

@end
