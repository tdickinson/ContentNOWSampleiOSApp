//
//  OWSFoodAndBeverageMarketingInformation.m
//  1WorldSync
//
//  Created by OpenPath Products on 9/29/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "OWSFoodAndBeverageMarketingInformation.h"

@implementation OWSFoodAndBeverageMarketingInformation

+ (RKObjectMapping *)mappingForClass {
    RKObjectMapping* map = [RKObjectMapping mappingForClass:[self class]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"servingSuggestion"
                                                                        toKeyPath:@"servingSuggestion"
                                                                      withMapping:[OWSMultipleValues mappingForClass]]];
    return map;
}

@end
