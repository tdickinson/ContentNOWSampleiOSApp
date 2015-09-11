//
//  OWSImage.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "OWSImage.h"
#import "SettingsManager.h"

@implementation OWSImage

+ (RKObjectMapping *)mappingForClass {
    RKObjectMapping* map = [RKObjectMapping mappingForClass:[self class]];
    [map addAttributeMappingsFromArray:@[@"defaultImage", @"fileAspectRatio", @"fileColorSchemeCode", @"fileEffectiveEndDate", @"fileEffectiveStartDate", @"fileFormatName", @"filePixelHeight", @"filePixelWidth", @"fileVersion", @"linkFileName", @"isFileForInternalUseOnly", @"uniformResourceIdentifier", @"thumbnailURI"]];
    
    
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"canFilesBeEdited"
                                                                        toKeyPath:@"canFilesBeEdited"
                                                                      withMapping:[OWSValue mappingForClass]]];

    


    
    
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"fileCameraPerspective"
                                                                        toKeyPath:@"fileCameraPerspective"
                                                                      withMapping:[OWSObjectDescription mappingForClass]]];

    


    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"fileCopyrightDescription"
                                                                        toKeyPath:@"fileCopyrightDescription"
                                                                      withMapping:[OWSObjectDescription mappingForClass]]];


    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"fileDisclaimerInformation"
                                                                        toKeyPath:@"fileDisclaimerInformation"
                                                                      withMapping:[OWSObjectDescription mappingForClass]]];



    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"fileFormatDescription"
                                                                        toKeyPath:@"fileFormatDescription"
                                                                      withMapping:[OWSObjectDescription mappingForClass]]];


    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"filePrintHeight"
                                                                        toKeyPath:@"filePrintHeight"
                                                                      withMapping:[OWSValuesObject mappingForClass]]];

    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"filePrintWidth"
                                                                        toKeyPath:@"filePrintWidth"
                                                                      withMapping:[OWSValuesObject mappingForClass]]];

    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"fileUsageRestriction"
                                                                        toKeyPath:@"fileUsageRestriction"
                                                                      withMapping:[OWSMultipleValues mappingForClass]]];



    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"isFileBackgroundTransparent"
                                                                        toKeyPath:@"isFileBackgroundTransparent"
                                                                      withMapping:[OWSValue mappingForClass]]];


    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"isTalentReleaseOnFile"
                                                                        toKeyPath:@"isTalentReleaseOnFile"
                                                                      withMapping:[OWSValue mappingForClass]]];

    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"linkContentDescription"
                                                                        toKeyPath:@"linkContentDescription"
                                                                      withMapping:[OWSObjectDescription mappingForClass]]];


    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"productImageType"
                                                                        toKeyPath:@"productImageType"
                                                                      withMapping:[OWSValue mappingForClass]]];


    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"uniformResourceIdentifierType"
                                                                        toKeyPath:@"uniformResourceIdentifierType"
                                                                      withMapping:[OWSValue mappingForClass]]];

    
    return map;
}

- (NSString *)displayString {
    NSString *displayString = self.productImageType.value.firstObject;
    if (!displayString.length) {
        displayString = @"Other Media";
    }
    
    //replace "WEBSITE" with "Brand Owner Page"
    if ([displayString isEqualToString:@"WEBSITE"]) {
        displayString = @"Brand Owner Page";
    }
    
    return displayString;
}

- (NSURL *)urlForSize:(CGSize)size {
    CGSize sizeToUse = [SettingsManager updateSizeForDisplay:size];
    NSMutableString *convertedUrlString = [NSMutableString stringWithString:self.uniformResourceIdentifier];
    [convertedUrlString replaceOccurrencesOfString:@"/dwn" withString:@"/img" options:0 range:NSMakeRange(0, self.uniformResourceIdentifier.length)];
    [convertedUrlString appendFormat:@"/s,x,%.0f,y,%.0f/", sizeToUse.width, sizeToUse.height];
    return [NSURL URLWithString:convertedUrlString];
}
@end
