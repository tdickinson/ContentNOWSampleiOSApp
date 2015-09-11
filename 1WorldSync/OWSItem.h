//
//  OWSItem.h
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OWSItemDefinitions.h"
#import "OWSItemIdentificationInformation.h"
#import "OWSProductCategory.h"
#import "OWSObjectDescription.h"
#import "OWSRKDynamicMapping.h"
#import "OWSAllergenInfo.h"
#import "OWSMultipleValues.h"
#import "OWSFoodAndBeverageMarketingInformation.h"
#import "OWSNetContent.h"

@interface OWSItem : OWSRKDynamicMapping

@property (nonatomic, strong) NSString *brandName;
@property (nonatomic, strong) NSString *digitalId;
@property (nonatomic, strong) NSArray *imageInformation;
@property (nonatomic, strong) OWSItemDefinitions *itemDefinitions;
@property (nonatomic, strong) OWSItemIdentificationInformation *itemIdentificationInformation;
@property (nonatomic, strong) NSDate *lastModifiedDate;
@property (nonatomic, strong) OWSProductCategory *productCategory;
@property (nonatomic, strong) OWSObjectDescription *productDescription;
@property (nonatomic, strong) OWSObjectDescription *productName;
@property (nonatomic, strong) NSArray *foodAndBevAllergens;
@property (nonatomic, strong) NSArray *foodAndBevNutrientInfo;
@property (nonatomic, strong) NSArray *foodAndBeverageIngredient;
@property (nonatomic, strong) OWSMultipleValues *ingredientStatement;
@property (nonatomic, strong) OWSFoodAndBeverageMarketingInformation *foodAndBeverageMarketingInformation;
@property (nonatomic, strong) OWSValue *countryOfOrigin;
@property (nonatomic, strong) OWSNetContent *netContent;
@property (nonatomic, strong) NSString *regulatedProductName;
@property (nonatomic, strong) NSArray *healthClaims;
@property (nonatomic, strong) OWSObjectDescription *allergenStatement;
@property (nonatomic, strong) OWSNetContent *drainedWeight;
@property (nonatomic, strong) OWSValue *contactName;
@property (nonatomic, strong) OWSValue *communicationAddress;
@property (nonatomic, strong) OWSValue *placeOfProvenance;
@property (nonatomic, strong) OWSValue *placeOfBirth;
@property (nonatomic, strong) OWSValue *placeOfRearing;
@property (nonatomic, strong) OWSValue *placeOfSlaughter;
@property (nonatomic, strong) NSNumber *percentageOfAlcoholPerVolume;
@property (nonatomic, strong) OWSObjectDescription *compulsoryAdditivesLabelInformation;
@property (nonatomic, strong) NSArray *foodAndBevAdditiveInformation;
@property (nonatomic, strong) OWSValue *packageMarksDietAllergen;
@property (nonatomic, strong) OWSValue *packageMarksEthical;
@property (nonatomic, strong) OWSValue *packagingMarkedLabelAccreditationCode;
@property (nonatomic, strong) OWSValue *packageMarksEnvironment;
@property (nonatomic, strong) OWSValue *packageMarksHygienic;
@property (nonatomic, strong) OWSObjectDescription *nutritionalClaim;
@property (nonatomic, strong) OWSValue *nutritionalClaimCode;
@property (nonatomic, strong) OWSValue *packageMarksFreeFrom;
@property (nonatomic, strong) OWSObjectDescription *tradeItemMarketingMessage;
@property (nonatomic, strong) OWSObjectDescription *consumerUsageStorageInstructions;
@property (nonatomic, strong) OWSValue *dailyValueIntakePercentMeasurementPrecisionCode;
@property (nonatomic, strong) NSArray *officeComponentInformation;

/**
 * Finds the appropriate information to display as the item description. Not a direct server response field.
 */
- (NSString *)itemDescription;

/**
 * Finds the appropriate information to display as the item ingredients. Not a direct server response field.
 */
- (NSString *)itemIngredients;

/**
 * Finds the appropriate information to display as the item allergen info. Not a direct server response field.
 */
- (NSString *)itemAllergens;

/**
 * Finds the best image (url) to display. Not a direct server response field. Thumbnail or full
 */
- (NSString *)itemImageUrl:(BOOL)isThumbnail;

/**
 * Finds the primary id value for this item, the one to use for the fetch product info api call. Not a direct server response field
 */
- (NSString *)itemId;

/**
 * Brand owner link, to the external website for the product, owned by the brand owner. Returns a URL -- if the string 
 * is something that won't be a valid URL, this method will return nil
 */
- (NSURL *)brandOwnerLink;

@end

