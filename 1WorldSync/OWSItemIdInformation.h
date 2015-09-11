//
//  OWSItemIdInformation.h
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OWSValue.h"
#import "OWSRKDynamicMapping.h"

@interface OWSItemIdInformation : OWSRKDynamicMapping
@property (nonatomic) BOOL isPrimary;
@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) OWSValue *itemIdType;
@end
