//
//  OWSItemValue.h
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OWSLanguageDefinition.h"
#import "OWSRKDynamicMapping.h"

@interface OWSItemValue : OWSRKDynamicMapping
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSArray *languageValues;
@end
