//
//  OWSItemReferenceIdInformation.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "OWSItemReferenceIdInformation.h"

@implementation OWSItemReferenceIdInformation

+ (RKObjectMapping *)mappingForClass {
    RKObjectMapping* map = [RKObjectMapping mappingForClass:[self class]];
    [map addAttributeMappingsFromArray:@[@"itemReferenceId"]];
    return map;
}

@end
