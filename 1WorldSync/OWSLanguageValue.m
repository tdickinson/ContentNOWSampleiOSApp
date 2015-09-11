//
//  OWSLanguageValue.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "OWSLanguageValue.h"

@implementation OWSLanguageValue

+ (RKObjectMapping *)mappingForClass {
    RKObjectMapping* map = [RKObjectMapping mappingForClass:[self class]];
    [map addAttributeMappingsFromDictionary:@{@"description": @"languageDescription", @"language": @"language"}];
    return map;
}

@end
