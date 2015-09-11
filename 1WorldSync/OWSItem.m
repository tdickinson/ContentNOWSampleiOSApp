//
//  OWSItem.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "OWSItem.h"
#import "OWSImage.h"
#import "OWSLanguageDefinition.h"
#import "OWSCodeMapping.h"
#import "OWSFoodBeverageNutrientInfo.h"
#import "OWSQualValue.h"
#import "OWSAdditive.h"
#import "OWSIngredient.h"
#import "OWSOfficeComponentInformation.h"

@implementation OWSItem

+ (RKObjectMapping *)mappingForClass {
    RKObjectMapping* map = [RKObjectMapping mappingForClass:[self class]];

    [map addAttributeMappingsFromArray:@[@"brandName", @"lastModifiedDate", @"digitalId", @"regulatedProductName", @"percentageOfAlcoholPerVolume"]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"imageInformation"
                                                                        toKeyPath:@"imageInformation"
                                                                      withMapping:[OWSImage mappingForClass]]];
    
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"itemDefinitions"
                                                                        toKeyPath:@"itemDefinitions"
                                                                      withMapping:[OWSItemDefinitions mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"itemIdentificationInformation"
                                                                        toKeyPath:@"itemIdentificationInformation"
                                                                      withMapping:[OWSItemIdentificationInformation mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"productCategory"
                                                                        toKeyPath:@"productCategory"
                                                                      withMapping:[OWSProductCategory mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"productDescription"
                                                                        toKeyPath:@"productDescription"
                                                                      withMapping:[OWSObjectDescription mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"productName"
                                                                        toKeyPath:@"productName"
                                                                      withMapping:[OWSObjectDescription mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"foodAndBevAllergens"
                                                                        toKeyPath:@"foodAndBevAllergens"
                                                                      withMapping:[OWSAllergenInfo mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"foodAndBevNutrientInfo"
                                                                        toKeyPath:@"foodAndBevNutrientInfo"
                                                                      withMapping:[OWSFoodBeverageNutrientInfo mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"countryOfOrigin"
                                                                        toKeyPath:@"countryOfOrigin"
                                                                      withMapping:[OWSValue mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"foodAndBeverageMarketingInformation" toKeyPath:@"foodAndBeverageMarketingInformation" withMapping:[OWSFoodAndBeverageMarketingInformation mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"foodAndBeverageIngredientInfo.ingredientStatement"
                                                                        toKeyPath:@"ingredientStatement"
                                                                      withMapping:[OWSMultipleValues mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"foodAndBeverageIngredientInfo.foodAndBeverageIngredient"
                                                                        toKeyPath:@"foodAndBeverageIngredient"
                                                                      withMapping:[OWSIngredient mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"netContent"
                                                                        toKeyPath:@"netContent"
                                                                      withMapping:[OWSNetContent mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"healthClaims.healthClaim"
                                                                        toKeyPath:@"healthClaims"
                                                                      withMapping:[OWSObjectDescription mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"allergenStatement"
                                                                        toKeyPath:@"allergenStatement"
                                                                      withMapping:[OWSObjectDescription mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"drainedWeight"
                                                                        toKeyPath:@"drainedWeight"
                                                                      withMapping:[OWSNetContent mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"contactName"
                                                                        toKeyPath:@"contactName"
                                                                      withMapping:[OWSValue mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"communicationAddress"
                                                                        toKeyPath:@"communicationAddress"
                                                                      withMapping:[OWSValue mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"placeOfProvenance"
                                                                        toKeyPath:@"placeOfProvenance"
                                                                      withMapping:[OWSValue mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"placeOfBirth"
                                                                        toKeyPath:@"placeOfBirth"
                                                                      withMapping:[OWSValue mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"placeOfRearing"
                                                                        toKeyPath:@"placeOfRearing"
                                                                      withMapping:[OWSValue mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"placeOfSlaughter"
                                                                        toKeyPath:@"placeOfSlaughter"
                                                                      withMapping:[OWSValue mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"compulsoryAdditivesLabelInformation"
                                                                        toKeyPath:@"compulsoryAdditivesLabelInformation"
                                                                      withMapping:[OWSObjectDescription mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"foodAndBevAdditiveInformation"
                                                                        toKeyPath:@"foodAndBevAdditiveInformation"
                                                                      withMapping:[OWSAdditive mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"packageMarksDietAllergen"
                                                                        toKeyPath:@"packageMarksDietAllergen"
                                                                      withMapping:[OWSValue mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"packageMarksEthical"
                                                                        toKeyPath:@"packageMarksEthical"
                                                                      withMapping:[OWSValue mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"packagingMarkedLabelAccreditationCode"
                                                                        toKeyPath:@"packagingMarkedLabelAccreditationCode"
                                                                      withMapping:[OWSValue mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"packageMarksEnvironment"
                                                                        toKeyPath:@"packageMarksEnvironment"
                                                                      withMapping:[OWSValue mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"packageMarksHygienic"
                                                                        toKeyPath:@"packageMarksHygienic"
                                                                      withMapping:[OWSValue mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"nutritionalClaim"
                                                                        toKeyPath:@"nutritionalClaim"
                                                                      withMapping:[OWSObjectDescription mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"nutritionalClaimCode"
                                                                        toKeyPath:@"nutritionalClaimCode"
                                                                      withMapping:[OWSValue mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"packageMarksFreeFrom"
                                                                        toKeyPath:@"packageMarksFreeFrom"
                                                                      withMapping:[OWSValue mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"tradeItemMarketingMessage"
                                                                        toKeyPath:@"tradeItemMarketingMessage"
                                                                      withMapping:[OWSObjectDescription mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"consumerUsageStorageInstructions"
                                                                        toKeyPath:@"consumerUsageStorageInstructions"
                                                                      withMapping:[OWSObjectDescription mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"dailyValueIntakePercentMeasurementPrecisionCode"
                                                                        toKeyPath:@"dailyValueIntakePercentMeasurementPrecisionCode"
                                                                      withMapping:[OWSValue mappingForClass]]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"officeComponentInformation"
                                                                        toKeyPath:@"officeComponentInformation"
                                                                      withMapping:[OWSOfficeComponentInformation mappingForClass]]];
    return map;
}


- (NSString *)itemDescription {
    //find the best description
    if (self.productDescription.values.count) {
        for (OWSValue *value in self.productDescription.values) {
            NSString *valueString = value.value.firstObject;
            if (valueString.length) {
                return valueString;
            }
        }
    }
    return @"";
}

- (NSString *)itemIngredients {
    //find the ingredients
    return ((OWSLanguageDefinition *)self.ingredientStatement.values.firstObject).value;
}

- (NSString *)itemAllergens {
    //Make a string, separated by newlines, of all the allergens.
    NSMutableString *allergens = [NSMutableString new];
    for (OWSAllergenInfo *allergen in self.foodAndBevAllergens) {
        [allergens appendString:[OWSCodeMapping displayStringForCode:allergen.levelOfContainment.value.firstObject forDefinitionName:allergen.levelOfContainment.valueDefinition inItem:self]];
        [allergens appendString:@" "];
        [allergens appendString:[OWSCodeMapping displayStringForCode:allergen.allergenTypeCode.value.firstObject forDefinitionName:allergen.allergenTypeCode.valueDefinition inItem:self]];
        [allergens appendString:@"\n"];
    }
    return allergens;
}

- (NSString *)itemImageUrl:(BOOL)isThumbnail {
    
    OWSImage *defaultImage = nil;
    for (OWSImage *image in self.imageInformation) {
        if (image.defaultImage) {
            defaultImage = image;
            break;
        }
    }
    
    //don't even try to return an image if it's not either reported as an image type, or if it doens't have the right extension
    if (!defaultImage) {
        return nil;
    }

    BOOL isImage = NO;
    if (defaultImage.uniformResourceIdentifier != nil) {
        if ([defaultImage.uniformResourceIdentifier rangeOfString:@".jpg"].location != NSNotFound ||
            [defaultImage.uniformResourceIdentifier rangeOfString:@".jpeg"].location != NSNotFound ||
            [defaultImage.uniformResourceIdentifier rangeOfString:@".gif"].location != NSNotFound ||
            [defaultImage.uniformResourceIdentifier rangeOfString:@".pic"].location != NSNotFound ||
            [defaultImage.uniformResourceIdentifier rangeOfString:@".ico"].location != NSNotFound ||
            [defaultImage.uniformResourceIdentifier rangeOfString:@".bmp"].location != NSNotFound ||
            [defaultImage.uniformResourceIdentifier rangeOfString:@".png"].location != NSNotFound ||
            [defaultImage.uniformResourceIdentifier rangeOfString:@".tiff"].location != NSNotFound) {
            isImage = YES;
        }
    }
    
    if ([defaultImage.productImageType.value.firstObject isEqualToString:@"PRODUCT_IMAGE"] ||
        [defaultImage.productImageType.value.firstObject isEqualToString:@"PRODUCT_LABEL_IMAGE"] ||
        [defaultImage.productImageType.value.firstObject isEqualToString:@"LOGO"]) {
        isImage = YES;
    }
    
    if (!isImage) {
        return nil;
    }
    
    NSString *imageUrl = nil;
    if (isThumbnail) {
        imageUrl = [defaultImage.thumbnailURI stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    if (!imageUrl) {
        NSString *url = defaultImage.uniformResourceIdentifier;
        url = [url stringByReplacingOccurrencesOfString:@"s,x,100,y,100" withString:@"s,x,300,y,300"];
        imageUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    return imageUrl;
}

- (NSString *)itemId {
    return self.itemIdentificationInformation.itemReferenceIdInformation.itemReferenceId;
}

- (NSURL *)brandOwnerLink {
    //Use the Product Image link where the type is WEBSITE
    for (OWSImage *image in self.imageInformation) {
        if ([image.productImageType.value.firstObject isEqualToString:@"WEBSITE"]) {
            return [NSURL URLWithString:image.uniformResourceIdentifier];
        }
    }
    return nil;
}

@end
