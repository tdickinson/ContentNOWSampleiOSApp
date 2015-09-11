//
//  OWSRKDynamicMapping.h
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface OWSRKDynamicMapping : NSObject

+ (RKObjectMapping *)mappingForClass;

@end
