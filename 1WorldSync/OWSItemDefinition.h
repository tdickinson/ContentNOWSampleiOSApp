//
//  OWSItemDefinition.h
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OWSRKDynamicMapping.h"

@interface OWSItemDefinition : OWSRKDynamicMapping

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSArray *values;

@end
