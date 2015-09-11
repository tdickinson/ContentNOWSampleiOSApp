//
//  OWSProductCategory.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "OWSProductCategory.h"

@implementation OWSProductCategory

+ (RKObjectMapping *)mappingForClass {
    RKObjectMapping* map = [RKObjectMapping mappingForClass:[self class]];
    [map addAttributeMappingsFromArray:@[@"brickCode", @"brickDescription", @"classCode", @"classDescription", @"familyCode", @"familyDescription", @"segmentCode", @"segmentDescription"]];

    return map;
}

@end
