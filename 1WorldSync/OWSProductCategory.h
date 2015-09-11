//
//  OWSProductCategory.h
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OWSRKDynamicMapping.h"

@interface OWSProductCategory : OWSRKDynamicMapping

@property (nonatomic, strong) NSString *brickCode;
@property (nonatomic, strong) NSString *brickDescription;
@property (nonatomic, strong) NSString *classCode;
@property (nonatomic, strong) NSString *classDescription;
@property (nonatomic, strong) NSString *familyCode;
@property (nonatomic, strong) NSString *familyDescription;
@property (nonatomic, strong) NSString *segmentCode;
@property (nonatomic, strong) NSString *segmentDescription;
@end
