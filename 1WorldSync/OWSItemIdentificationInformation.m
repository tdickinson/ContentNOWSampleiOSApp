//
//  OWSItemIdentificationInformation.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "OWSItemIdentificationInformation.h"


@implementation OWSItemIdentificationInformation

+ (RKObjectMapping *)mappingForClass {
    RKObjectMapping* map = [RKObjectMapping mappingForClass:[self class]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"informationProvider"
                                                                        toKeyPath:@"informationProvider"
                                                                      withMapping:[OWSInformationProvider mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"itemReferenceIdInformation"
                                                                        toKeyPath:@"itemReferenceIdInformation"
                                                                      withMapping:[OWSItemReferenceIdInformation mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"targetMarket"
                                                                        toKeyPath:@"targetMarket"
                                                                      withMapping:[OWSValue mappingForClass]]];

    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"itemIdInformation"
                                                                        toKeyPath:@"itemIdInformation"
                                                                      withMapping:[OWSItemIdInformation mappingForClass]]];
    return map;
}

@end
