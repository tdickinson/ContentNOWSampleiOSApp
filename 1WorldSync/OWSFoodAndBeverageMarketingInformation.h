//
//  OWSFoodAndBeverageMarketingInformation.h
//  1WorldSync
//
//  Created by OpenPath Products on 9/29/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OWSRKDynamicMapping.h"
#import "OWSMultipleValues.h"

@interface OWSFoodAndBeverageMarketingInformation : OWSRKDynamicMapping
@property (nonatomic, strong) OWSMultipleValues *servingSuggestion;
@end
