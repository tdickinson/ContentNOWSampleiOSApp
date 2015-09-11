//
//  OWSSearchResult.h
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "OWSItem.h"
#import "OWSRKDynamicMapping.h"

@interface OWSSearchResult : OWSRKDynamicMapping

@property (nonatomic, strong) OWSItem *item;


@end
