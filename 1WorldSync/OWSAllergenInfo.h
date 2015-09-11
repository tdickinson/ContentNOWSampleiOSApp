//
//  OWSAllergenInfo.h
//  1WorldSync
//
//  Created by OpenPath Products on 8/29/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "OWSRKDynamicMapping.h"
#import "OWSValue.h"

@interface OWSAllergenInfo : OWSRKDynamicMapping
@property (nonatomic, strong) OWSValue *allergenTypeCode;
@property (nonatomic, strong) OWSValue *levelOfContainment;
@property (nonatomic, strong) NSString *allergenSpecificationAgency;
@property (nonatomic, strong) NSString *allergenSpecificationName;

@end
