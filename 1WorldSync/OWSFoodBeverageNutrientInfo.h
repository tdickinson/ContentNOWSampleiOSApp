//
//  OWSFoodBeverageNutrientInfo.h
//  1WorldSync
//
//  Created by OpenPath Products on 8/29/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "OWSRKDynamicMapping.h"
#import "OWSNutrient.h"
#import "OWSMultipleValues.h"
#import "OWSNetContent.h"
#import "OWSObjectDescription.h"

@interface OWSFoodBeverageNutrientInfo : OWSRKDynamicMapping
@property (nonatomic, strong) NSArray *foodAndBeverageNutrient;
@property (nonatomic, strong) OWSMultipleValues *householdServingSize;
@property (nonatomic, strong) OWSObjectDescription *dailyValueIntakeReference;
@property (nonatomic, strong) NSString *preparationState;
@property (nonatomic, strong) OWSNetContent *servingSize;

@end
