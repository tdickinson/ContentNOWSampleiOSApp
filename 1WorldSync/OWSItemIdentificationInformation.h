//
//  OWSItemIdentificationInformation.h
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OWSInformationProvider.h"
#import "OWSItemIdInformation.h"
#import "OWSItemReferenceIdInformation.h"
#import "OWSValue.h"
#import "OWSRKDynamicMapping.h"

@interface OWSItemIdentificationInformation : OWSRKDynamicMapping
@property (nonatomic, strong) OWSInformationProvider *informationProvider;
@property (nonatomic, strong) NSArray *itemIdInformation;
@property (nonatomic, strong) OWSItemReferenceIdInformation *itemReferenceIdInformation;
@property (nonatomic, strong) OWSValue *targetMarket;

@end
