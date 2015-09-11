//
//  OWSMultipleValues.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "OWSMultipleValues.h"
#import "OWSLanguageDefinition.h"

@implementation OWSMultipleValues

+ (RKObjectMapping *)mappingForClass {
    RKObjectMapping* map = [RKObjectMapping mappingForClass:[self class]];
    [map addAttributeMappingsFromArray:@[@"languageDefinition"]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"values"
                                                                        toKeyPath:@"values"
                                                                      withMapping:[OWSLanguageDefinition mappingForClass]]];
    return map;
}

@end
