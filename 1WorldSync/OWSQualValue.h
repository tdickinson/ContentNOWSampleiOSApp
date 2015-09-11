//
//  OWSQualValue.h
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "OWSRKDynamicMapping.h"

@interface OWSQualValue : OWSRKDynamicMapping
@property (nonatomic, strong) NSString *qual;
@property (nonatomic, strong) NSNumber *value;
@end
