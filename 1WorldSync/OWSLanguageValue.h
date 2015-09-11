//
//  OWSLanguageValue.h
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OWSRKDynamicMapping.h"

@interface OWSLanguageValue : OWSRKDynamicMapping
@property (nonatomic, strong) NSString *languageDescription;
@property (nonatomic, strong) NSString *language;
@end
