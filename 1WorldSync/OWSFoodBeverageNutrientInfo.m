//
//  OWSFoodBeverageNutrientInfo.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/29/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "OWSFoodBeverageNutrientInfo.h"
#import "OWSIngredient.h"

@implementation OWSFoodBeverageNutrientInfo

+ (RKObjectMapping *)mappingForClass {
    RKObjectMapping* map = [RKObjectMapping mappingForClass:[self class]];
    [map addAttributeMappingsFromArray:@[@"preparationState"]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"foodAndBeverageNutrient"
                                                                        toKeyPath:@"foodAndBeverageNutrient"
                                                                      withMapping:[OWSNutrient mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"householdServingSize"
                                                                        toKeyPath:@"householdServingSize"
                                                                      withMapping:[OWSMultipleValues mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"servingSize"
                                                                        toKeyPath:@"servingSize"
                                                                      withMapping:[OWSNetContent mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"dailyValueIntakeReference"
                                                                        toKeyPath:@"dailyValueIntakeReference"
                                                                      withMapping:[OWSObjectDescription mappingForClass]]];
    
    return map;
}

@end
