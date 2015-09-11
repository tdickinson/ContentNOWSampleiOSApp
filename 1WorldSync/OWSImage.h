//
//  OWSImage.h
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OWSObjectDescription.h"
#import "OWSValue.h"
#import "OWSValuesObject.h"
#import "OWSMultipleValues.h"
#import "OWSRKDynamicMapping.h"

@interface OWSImage : OWSRKDynamicMapping

@property (nonatomic, strong) OWSValue *canFilesBeEdited;
@property (nonatomic) BOOL defaultImage;
@property (nonatomic, strong) NSString *fileAspectRatio;

@property (nonatomic, strong) OWSObjectDescription *fileCameraPerspective;
@property (nonatomic, strong) NSString *fileColorSchemeCode;
@property (nonatomic, strong) OWSObjectDescription *fileCopyrightDescription;
@property (nonatomic, strong) OWSObjectDescription *fileDisclaimerInformation;
@property (nonatomic, strong) NSDate *fileEffectiveEndDate;
@property (nonatomic, strong) NSDate *fileEffectiveStartDate;
@property (nonatomic, strong) OWSObjectDescription *fileFormatDescription;
@property (nonatomic, strong) NSString *fileFormatName;
@property (nonatomic, strong) NSString *filePixelHeight;
@property (nonatomic, strong) NSString *filePixelWidth;
@property (nonatomic, strong) OWSValuesObject *filePrintHeight;
@property (nonatomic, strong) OWSValuesObject *filePrintWidth;
@property (nonatomic, strong) OWSMultipleValues *fileUsageRestriction;
@property (nonatomic, strong) NSString *fileVersion;
//TODO: intendedpublicationcountry if needed
@property (nonatomic, strong) OWSValue *isFileBackgroundTransparent;
@property (nonatomic) BOOL isFileForInternalUseOnly;
@property (nonatomic, strong) OWSValue *isTalentReleaseOnFile;
@property (nonatomic, strong) OWSObjectDescription *linkContentDescription;
@property (nonatomic, strong) NSString *linkFileName;
@property (nonatomic, strong) OWSValue *productImageType;
@property (nonatomic, strong) NSString *uniformResourceIdentifier;
@property (nonatomic, strong) OWSValue *uniformResourceIdentifierType;
@property (nonatomic, strong) NSString *thumbnailURI;

- (NSString *)displayString;

/**
 * Transforms the image url to return the image API url to fetch the image at the given size
 */
- (NSURL *)urlForSize:(CGSize)size;

@end

