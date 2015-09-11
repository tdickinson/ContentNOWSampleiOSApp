//
//  OWSAllergenInfo.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/29/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "OWSAllergenInfo.h"

@implementation OWSAllergenInfo

+ (RKObjectMapping *)mappingForClass {
    RKObjectMapping* map = [RKObjectMapping mappingForClass:[self class]];
    [map addAttributeMappingsFromArray:@[@"allergenSpecificationAgency", @"allergenSpecificationName"]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"allergenTypeCode"
                                                                        toKeyPath:@"allergenTypeCode"
                                                                      withMapping:[OWSValue mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"levelOfContainment"
                                                                        toKeyPath:@"levelOfContainment"
                                                                      withMapping:[OWSValue mappingForClass]]];
    return map;
}

@end
