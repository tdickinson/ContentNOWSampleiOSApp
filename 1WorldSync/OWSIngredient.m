//
//  OWSIngredient.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "OWSIngredient.h"
#import <RestKit/RestKit.h>

@implementation OWSIngredient

+ (RKObjectMapping *)mappingForClass {
    RKObjectMapping* map = [RKObjectMapping mappingForClass:[self class]];
    [map addAttributeMappingsFromArray:@[@"ingredientSequence"]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"ingredientName"
                                                                        toKeyPath:@"ingredientName"
                                                                      withMapping:[OWSMultipleValues mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"fishCatchZone"
                                                                        toKeyPath:@"fishCatchZone"
                                                                      withMapping:[OWSValue mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"ingredientCountryOfOrigin"
                                                                        toKeyPath:@"ingredientCountryOfOrigin"
                                                                      withMapping:[OWSValue mappingForClass]]];
    return map;
}

@end
