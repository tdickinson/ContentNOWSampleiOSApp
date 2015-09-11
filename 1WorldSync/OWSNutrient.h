//
//  OWSNutrient.h
//  1WorldSync
//
//  Created by OpenPath Products on 8/29/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "OWSRKDynamicMapping.h"
#import "OWSValue.h"
#import "OWSNetContent.h"

@interface OWSNutrient : OWSRKDynamicMapping
@property (nonatomic, strong) OWSValue *measurementPrecision;
@property (nonatomic, strong) OWSNetContent *nutrientQuantityContained;
@property (nonatomic, strong) OWSValue *nutrientTypeCode;
@property (nonatomic, strong) NSNumber *percentageOfDailyValueIntake;
@end
