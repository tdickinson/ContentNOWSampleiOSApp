//
//  OWSInformationProvider.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "OWSInformationProvider.h"

@implementation OWSInformationProvider

+ (RKObjectMapping *)mappingForClass {
    RKObjectMapping* map = [RKObjectMapping mappingForClass:[self class]];
    [map addAttributeMappingsFromArray:@[@"informationProviderId", @"informationProviderName", @"isPrimary"]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"informationProviderType"
                                                                        toKeyPath:@"informationProviderType"
                                                                      withMapping:[OWSValue mappingForClass]]];
    return map;
}

@end
