//
//  OWSValue.h
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OWSRKDynamicMapping.h"

@interface OWSValue : OWSRKDynamicMapping
@property (nonatomic, strong) NSArray *value;
@property (nonatomic, strong) NSString *valueDefinition;
@end
