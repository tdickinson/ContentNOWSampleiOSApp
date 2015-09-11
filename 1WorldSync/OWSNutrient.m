//
//  OWSNutrient.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/29/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "OWSNutrient.h"

@implementation OWSNutrient

+ (RKObjectMapping *)mappingForClass {
    RKObjectMapping* map = [RKObjectMapping mappingForClass:[self class]];
    [map addAttributeMappingsFromArray:@[@"percentageOfDailyValueIntake"]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"measurementPrecision"
                                                                        toKeyPath:@"measurementPrecision"
                                                                      withMapping:[OWSValue mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"nutrientQuantityContained"
                                                                        toKeyPath:@"nutrientQuantityContained"
                                                                      withMapping:[OWSNetContent mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"nutrientTypeCode"
                                                                        toKeyPath:@"nutrientTypeCode"
                                                                      withMapping:[OWSValue mappingForClass]]];
    return map;
}

@end
