//
//  OWSOfficeComponentInformation.h
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "OWSRKDynamicMapping.h"
#import "OWSObjectDescription.h"

@interface OWSOfficeComponentInformation : OWSRKDynamicMapping
@property (nonatomic, strong) NSNumber *componentNumber;
@property (nonatomic, strong) OWSObjectDescription *componentDescription;
@end
