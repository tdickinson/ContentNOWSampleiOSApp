//
//  OWSItemValue.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "OWSItemValue.h"
#import "OWSLanguageValue.h"

@implementation OWSItemValue

+ (RKObjectMapping *)mappingForClass {
    RKObjectMapping* map = [RKObjectMapping mappingForClass:[self class]];
    [map addAttributeMappingsFromArray:@[@"code"]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"languageValues"
                                                                        toKeyPath:@"languageValues"
                                                                      withMapping:[OWSLanguageValue mappingForClass]]];
    return map;
}

@end
