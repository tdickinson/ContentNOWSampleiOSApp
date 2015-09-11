//
//  OWSObjectDescription.h
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OWSRKDynamicMapping.h"

@interface OWSObjectDescription : OWSRKDynamicMapping
@property (nonatomic, strong) NSString *languageDefinition;
@property (nonatomic, strong) NSArray *values;
@end
