//
//  OWSIngredient.h
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "OWSItem.h"
#import "OWSRKDynamicMapping.h"
#import "OWSMultipleValues.h"

@interface OWSIngredient : OWSRKDynamicMapping

@property (nonatomic, strong) NSNumber *ingredientSequence;
@property (nonatomic, strong) OWSMultipleValues *ingredientName;
@property (nonatomic, strong) OWSValue *fishCatchZone;
@property (nonatomic, strong) OWSValue *ingredientCountryOfOrigin;

@end
