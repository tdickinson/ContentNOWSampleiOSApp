//
//  OWSAdditive.h
//  1WorldSync
//
//  Created by OpenPath Products on 11/5/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "OWSRKDynamicMapping.h"
#import "OWSValue.h"

@interface OWSAdditive : OWSRKDynamicMapping

@property (nonatomic, strong) NSString *additiveName;
@property (nonatomic, strong) OWSValue *additiveLevelOfContainment;
@end
