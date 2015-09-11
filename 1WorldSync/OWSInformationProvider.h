//
//  OWSInformationProvider.h
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OWSValue.h"
#import "OWSRKDynamicMapping.h"

@interface OWSInformationProvider : OWSRKDynamicMapping
@property (nonatomic, strong) NSString *informationProviderId;
@property (nonatomic, strong) NSString *informationProviderName;
@property (nonatomic, strong) OWSValue *informationProviderType;
@property (nonatomic) BOOL isPrimary;
@end
