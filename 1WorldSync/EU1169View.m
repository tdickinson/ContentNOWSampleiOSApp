//
//  EU1169View.m
//  1WorldSync
//
//  Created by OpenPath Products on 11/7/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "EU1169View.h"
#import "OWSFoodBeverageNutrientInfo.h"
#import "OWSCodeMapping.h"
#import "OWSIngredient.h"
#import "OWSLanguageDefinition.h"
#import "OWSQualValue.h"
#import "OWSAdditive.h"
#import "OWSOfficeComponentInformation.h"
#import "SettingsManager.h"
#import "TableRowView.h"

@implementation EU1169View

- (void)showItem:(OWSItem *)item {
    UIView *spacer = [[UIView alloc] initWithFrame:CGRectZero];
    spacer.translatesAutoresizingMaskIntoConstraints = NO;
    spacer.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:spacer];
    NSLayoutConstraint *lc1 = [NSLayoutConstraint constraintWithItem:spacer attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.f constant:0.f];
    NSLayoutConstraint *lc2 = [NSLayoutConstraint constraintWithItem:spacer attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.f constant:0.f];
    NSLayoutConstraint *lc3 = [NSLayoutConstraint constraintWithItem:spacer attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.f constant:0.f];
    NSLayoutConstraint *lc4 = [NSLayoutConstraint constraintWithItem:spacer attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:0.f];
    [self addConstraints:@[lc1, lc2, lc3]];
    [spacer addConstraint:lc4];
    
    UIView *aboveView = spacer;
    
    /*
     * Add all the EU1169 attributes
     */
    
    //Country of origin.
    NSMutableArray *strings = [NSMutableArray new];
    
    aboveView = [self addLabelsForValue:item.countryOfOrigin inItem:item withTitle:@"Country/Countries Of Origin" belowView:aboveView];

    //ingredients
    if (item.itemIngredients.length > 0) {
        aboveView = [self addLabelsWithTitle:@"Ingredient Statement" andBodyStrings:@[item.itemIngredients] belowView:aboveView];
    }
    
    if (item.foodAndBeverageIngredient.count) {
        //add the table header row
        aboveView = [self addLabelWithTitle:@"Ingredients" belowView:aboveView];
        aboveView = [self addTableRowWithStrings:@[@"Seq. No.", @"Ingredient", @"Fish Catch Zone", @"Country Of Origin"] bold:YES belowView:aboveView];
        for (OWSIngredient *ingredient in [item.foodAndBeverageIngredient sortedArrayUsingComparator:^NSComparisonResult(OWSIngredient *obj1, OWSIngredient *obj2) {
            return [obj1.ingredientSequence compare:obj2.ingredientSequence];
        }]) {
            NSString *ingredientName = ((OWSLanguageDefinition *)ingredient.ingredientName.values.firstObject).value;
            NSString *sequenceNumber = [NSString stringWithFormat:@"%i", ingredient.ingredientSequence.intValue];
            NSString *fishCatchZone = [ingredient.fishCatchZone.value componentsJoinedByString:@"\n"];
            NSMutableArray *countriesOfOrigin = [NSMutableArray new];
            for (NSString *zone in ingredient.fishCatchZone.value) {
                [countriesOfOrigin addObject:[OWSCodeMapping displayStringForCode:zone forDefinitionName:ingredient.fishCatchZone.valueDefinition inItem:item]];
            }
            NSString *countryOfOrigin = [countriesOfOrigin componentsJoinedByString:@"\n"];
            aboveView = [self addTableRowWithStrings:@[sequenceNumber ? sequenceNumber : @"", ingredientName ? ingredientName : @"", fishCatchZone ? fishCatchZone : @"", countryOfOrigin ? countryOfOrigin : @""] bold:NO belowView:aboveView];
        }
    }
    
    
    //allergen statement
    aboveView = [self addLabelsForObjectDescription:item.allergenStatement inItem:item withTitle:@"Allergen Statement(s)" belowView:aboveView];
    
    //Net content
    aboveView = [self addLabelsForNetContent:item.netContent inItem:item withTitle:@"Net Content" belowView:aboveView];
    
    if (item.regulatedProductName) {
        aboveView = [self addLabelsWithTitle:@"Regulated Product Name" andBodyStrings:@[item.regulatedProductName] belowView:aboveView];
    }
    
    //health claims
    if (item.healthClaims.count) {
        [strings removeAllObjects];
        for (OWSObjectDescription *d in item.healthClaims) {
            for (OWSValue *value in d.values) {
                [strings addObject:value.value.firstObject];
            }
        }
        aboveView = [self addLabelsWithTitle:@"Health Claims" andBodyStrings:strings belowView:aboveView];
    }

    
    //Drained weight
    aboveView = [self addLabelsForNetContent:item.drainedWeight inItem:item withTitle:@"Drained Weight" belowView:aboveView];
    
    //Contact Name
    aboveView = [self addLabelsWithTitle:@"Contact Name" andBodyStrings:item.contactName.value belowView:aboveView];

    //Communication Address
    aboveView = [self addLabelsWithTitle:@"Communication Address" andBodyStrings:item.communicationAddress.value belowView:aboveView];

    //All the places
    aboveView = [self addLabelsWithTitle:@"Place of Provenance" andBodyStrings:item.placeOfProvenance.value belowView:aboveView];
    aboveView = [self addLabelsWithTitle:@"Place of Birth" andBodyStrings:item.placeOfBirth.value belowView:aboveView];
    aboveView = [self addLabelsWithTitle:@"Place of Rearing" andBodyStrings:item.placeOfRearing.value belowView:aboveView];
    aboveView = [self addLabelsWithTitle:@"Place of Slaughter" andBodyStrings:item.placeOfSlaughter.value belowView:aboveView];
    
    //% Alcohol per volume
    if (item.percentageOfAlcoholPerVolume) {
        aboveView = [self addLabelsWithTitle:@"Percentage of Alcohol per Volume" andBodyStrings:@[[NSString stringWithFormat:@"%.1f%@", item.percentageOfAlcoholPerVolume.floatValue, @"%"]] belowView:aboveView];
    }
    
    //Daily Value Intake Percent Measurement Precision Code
    aboveView = [self addLabelsForValue:item.dailyValueIntakePercentMeasurementPrecisionCode inItem:item withTitle:@"Daily Value Intake Percent Measurement Precision Code" belowView:aboveView];

    //Daily value intake reference statement
    if (item.foodAndBevNutrientInfo.count) {
        [strings removeAllObjects];
        for (OWSFoodBeverageNutrientInfo *nutrientInfo in item.foodAndBevNutrientInfo) {
            if (nutrientInfo.preparationState) {
                [strings addObject:nutrientInfo.preparationState];
            }
            for (OWSValue *value in nutrientInfo.dailyValueIntakeReference.values) {
                for (NSString *string in value.value) {
                    [strings addObject:[NSString stringWithFormat:@"   %@", string]];
                }
            }
        }
        aboveView = [self addLabelsWithTitle:@"Daily Value Intake Reference" andBodyStrings:strings belowView:aboveView];
    }


    //Compulsary Additives Label Information
    aboveView = [self addLabelsForObjectDescription:item.compulsoryAdditivesLabelInformation inItem:item withTitle:@"Compulsary Additives Label Information" belowView:aboveView];
    
    //Additives
    if (item.foodAndBevAdditiveInformation.count) {
        [strings removeAllObjects];
        for (OWSAdditive *additive in item.foodAndBevAdditiveInformation) {
            [strings addObject:[NSString stringWithFormat:@"%@ %@", [OWSCodeMapping displayStringForCode:additive.additiveLevelOfContainment.value.firstObject forDefinitionName:additive.additiveLevelOfContainment.valueDefinition inItem:item], additive.additiveName]];
        }
        aboveView = [self addLabelsWithTitle:@"Additives" andBodyStrings:strings belowView:aboveView];
    }
    
    //all package marks
    aboveView = [self addLabelsForValue:item.packageMarksDietAllergen inItem:item withTitle:@"Package Marks Diet Allergen" belowView:aboveView];
    aboveView = [self addLabelsForValue:item.packageMarksEthical inItem:item withTitle:@"Package Marks Ethical" belowView:aboveView];
    
    if (item.packagingMarkedLabelAccreditationCode.value.count) {
        [strings removeAllObjects];
        for (NSString *string in item.packagingMarkedLabelAccreditationCode.value) {
            [strings addObject:string];
        }
        aboveView = [self addLabelsWithTitle:@"Packaging Marked Label Accreditation Code" andBodyStrings:strings belowView:aboveView];
    }
    
    aboveView = [self addLabelsForValue:item.packageMarksEnvironment inItem:item withTitle:@"Packaging Marks Environment" belowView:aboveView];
    aboveView = [self addLabelsForValue:item.packageMarksHygienic inItem:item withTitle:@"Packaging Marks Hygienic" belowView:aboveView];
    aboveView = [self addLabelsForValue:item.packageMarksFreeFrom inItem:item withTitle:@"Packaging Marks Free From" belowView:aboveView];
    
    //Nutritional Claim
    aboveView = [self addLabelsForObjectDescription:item.nutritionalClaim inItem:item withTitle:@"Nutritional Claim" belowView:aboveView];

    //Nutritional Claim Code
    aboveView = [self addLabelsForValue:item.nutritionalClaimCode inItem:item withTitle:@"Nutritional Claim Code" belowView:aboveView];
    
    //Marketing Message
    aboveView = [self addLabelsForObjectDescription:item.tradeItemMarketingMessage inItem:item withTitle:@"Marketing Message" belowView:aboveView];
    
    //Office Component Information
    if (item.officeComponentInformation.count) {
        [strings removeAllObjects];
        for (OWSOfficeComponentInformation *d in item.officeComponentInformation) {
            [strings addObject:[NSString stringWithFormat:@"Component Number: %i", d.componentNumber.intValue]];
            
            for (OWSValue *value in d.componentDescription.values) {
                for (NSString *string in value.value) {
                    [strings addObject:[NSString stringWithFormat:@"   %@", string]];
                }
            }
        }
        aboveView = [self addLabelsWithTitle:@"Office Component Information" andBodyStrings:strings belowView:aboveView];
    }

    //Consumer Usage Storage Instructions
    aboveView = [self addLabelsForObjectDescription:item.consumerUsageStorageInstructions inItem:item withTitle:@"Consumer Usage Storage Instructions" belowView:aboveView];


    NSLayoutConstraint *bottomLC = [NSLayoutConstraint constraintWithItem:aboveView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f];
    [self addConstraint:bottomLC];
    
    
}

/**
 * Adds a label
 */
- (UIView *)addLabelsWithTitle:(NSString *)title andBodyStrings:(NSArray *)bodyStrings belowView:(UIView *)view {
    UILabel *label = [[UILabel alloc] init];
    
    if (!title || !bodyStrings || !bodyStrings.count) {
        return view;
    }
    //Make the title label
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:16.f],
                                                                                                         NSForegroundColorAttributeName : [UIColor darkGrayColor]} ];
    label.attributedText = attributedString;
    label.preferredMaxLayoutWidth = self.frame.size.width;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.backgroundColor = [UIColor clearColor];
    [self addSubview:label];
    
    NSLayoutConstraint *lc1 = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1.f constant:10.f];
    NSLayoutConstraint *lc2 = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1.f constant:0.f];
    
    [self addSubview:label];
    [self addConstraint:lc1];
    [self addConstraint:lc2];
    
    UIView *retView = label;
    for (NSString *body in bodyStrings) {
        //Add the body label
        //Make the title label
        attributedString = [[NSAttributedString alloc] initWithString:body attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14.f],
                                                                                        NSForegroundColorAttributeName : [UIColor darkGrayColor]} ];
        UILabel *bodyLabel = [[UILabel alloc] init];
        bodyLabel.attributedText = attributedString;
        bodyLabel.preferredMaxLayoutWidth = self.frame.size.width;
        bodyLabel.numberOfLines = 0;
        bodyLabel.lineBreakMode = NSLineBreakByWordWrapping;
        bodyLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:bodyLabel];
        
        lc1 = [NSLayoutConstraint constraintWithItem:bodyLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:retView attribute:NSLayoutAttributeBottom multiplier:1.f constant:5.f];
        lc2 = [NSLayoutConstraint constraintWithItem:bodyLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:retView attribute:NSLayoutAttributeLeft multiplier:1.f constant:0.f];
        
        [self addSubview:bodyLabel];
        [self addConstraint:lc1];
        [self addConstraint:lc2];
        retView = bodyLabel;
    }
    
    return retView;
}

- (UIView *)addLabelWithTitle:(NSString *)title belowView:(UIView *)view {
    UILabel *label = [[UILabel alloc] init];
    
    if (!title) {
        return view;
    }
    //Make the title label
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:16.f],
                                                                                                         NSForegroundColorAttributeName : [UIColor darkGrayColor]} ];
    label.attributedText = attributedString;
    label.preferredMaxLayoutWidth = self.frame.size.width;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.backgroundColor = [UIColor clearColor];
    [self addSubview:label];
    
    NSLayoutConstraint *lc1 = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1.f constant:10.f];
    NSLayoutConstraint *lc2 = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1.f constant:0.f];
    
    [self addSubview:label];
    [self addConstraint:lc1];
    [self addConstraint:lc2];
    
    return label;
}

/**
 * Helper for OWSNetContent types since the code is re-used for all of them
 */
- (UIView *)addLabelsForNetContent:(OWSNetContent *)netContent inItem:(OWSItem *)item withTitle:(NSString *)title belowView:(UIView *)view {
    if (!netContent.values.count) {
        return view;
    }
    
    NSMutableArray *strings = [NSMutableArray new];
    for (OWSQualValue *qualValue in netContent.values) {
        [strings addObject:[NSString stringWithFormat:@"%.1f %@", qualValue.value.floatValue, [OWSCodeMapping displayStringForCode:qualValue.qual forDefinitionName:netContent.qualDefinition inItem:item]]];
    }
    return [self addLabelsWithTitle:title andBodyStrings:strings belowView:view];
}

/**
 * Helper for OWSObjectDescription types since the code is re-used for all of them
 */
- (UIView *)addLabelsForObjectDescription:(OWSObjectDescription *)objectDescription inItem:(OWSItem *)item withTitle:(NSString *)title belowView:(UIView *)view {
    
    if (!objectDescription.values.count) {
        return view;
    }
    
    NSMutableArray *strings = [NSMutableArray new];
    for (OWSValue *value in objectDescription.values) {
        for (NSString *string in value.value) {
            [strings addObject:string];
        }
    }
    return [self addLabelsWithTitle:title andBodyStrings:strings belowView:view];
}

/**
 * Helper for OWSValue types since the code is re-used for all of them. This is for objects of type OWSValue that have a mapping for a code. Objects that just have plain text values should not use this
 */
- (UIView *)addLabelsForValue:(OWSValue *)value inItem:(OWSItem *)item withTitle:(NSString *)title belowView:(UIView *)view {
    if (!value.value.count) {
        return view;
    }
    
    NSMutableArray *strings = [NSMutableArray new];
    for (NSString *string in value.value) {
        [strings addObject:[NSString stringWithFormat:@"%@ (%@)", [OWSCodeMapping displayStringForCode:string forDefinitionName:value.valueDefinition inItem:item], string]];
    }
    return [self addLabelsWithTitle:title andBodyStrings:strings belowView:view];
}

/**
 * Helper to add a new table row below the given "above" view
 */
- (UIView *)addTableRowWithStrings:(NSArray *)strings bold:(BOOL)bold belowView:(UIView *)aboveView {
    TableRowView *row = [[TableRowView alloc] init];
    row.translatesAutoresizingMaskIntoConstraints = NO;
    row.backgroundColor = [UIColor clearColor];
    [row setupWithStrings:strings bold:bold];
    [self addSubview:row];
    
    NSLayoutConstraint *lc1 = [NSLayoutConstraint constraintWithItem:row attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:aboveView attribute:NSLayoutAttributeBottom multiplier:1.f constant:10.f];
    NSLayoutConstraint *lc2 = [NSLayoutConstraint constraintWithItem:row attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.f constant:0.f];
    NSLayoutConstraint *lc3 = [NSLayoutConstraint constraintWithItem:row attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.f constant:0.f];
    [self addConstraints:@[lc1, lc2, lc3]];
    
    return row;
}

@end
