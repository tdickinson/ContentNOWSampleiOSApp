//
//  OWSCodeMapping.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/29/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "OWSCodeMapping.h"
#import "OWSItemDefinition.h"
#import "OWSItemValue.h"
#import "OWSValue.h"
#import "OWSLanguageValue.h"

@implementation OWSCodeMapping


+ (NSString *)displayStringForCode:(NSString *)codeString forDefinitionName:(NSString *)definitionName inItem:(OWSItem *)item {
    //The server returns itemDefinitions --> definitions, from which we can find the appropriate mapping
    if (!codeString) {
        return @"";
    }
    
    if (!definitionName) {
        return codeString;//we can't map to a definition, just return the code string
    }
    
    for (OWSItemDefinition *definition in item.itemDefinitions.definitions) {
        if ([definition.name isEqualToString:definitionName]) {
            for (OWSItemValue *value in definition.values) {
                if ([value.code isEqualToString:codeString]) {
                    return ((OWSLanguageValue *)value.languageValues.firstObject).languageDescription;
                }
            }
        }
    }
    
    return @"";
}

@end
