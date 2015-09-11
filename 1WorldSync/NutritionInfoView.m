//
//  NutritionInfoView.m
//  1WorldSync
//
//  Created by OpenPath Products on 9/4/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "NutritionInfoView.h"
#import "OWSFoodBeverageNutrientInfo.h"
#import "OWSQualValue.h"
#import "OWSCodeMapping.h"
#import "OWSNutrient.h"
#import "SettingsManager.h"

@interface NutritionInfoView()

@property (nonatomic, strong) OWSItem *item;

@end

@implementation NutritionInfoView

- (void)showItem:(OWSItem *)item {
    self.item = item;

    //Don't do anything if we don't actually have any foot and nutrient info
    if (item.foodAndBevNutrientInfo.count < 1) {
        return;
    }
    
    UIFont *normalFont = [UIFont systemFontOfSize:14.f];
    
    //create all the necessary views
    UIView *titleLabel = [self addLabelWithText:@"Nutrition Facts" andFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.f]];
    NSLayoutConstraint *lc1 = [NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.f constant:0.f];
    NSLayoutConstraint *lc2 = [NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.f constant:0.f];
    [self addConstraints:@[lc1, lc2]];

    UIView *spacer = [[UIView alloc] initWithFrame:CGRectZero];
    spacer.translatesAutoresizingMaskIntoConstraints = NO;
    spacer.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:spacer];
    lc1 = [NSLayoutConstraint constraintWithItem:spacer attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:titleLabel attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f];
    lc2 = [NSLayoutConstraint constraintWithItem:spacer attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:titleLabel attribute:NSLayoutAttributeLeft multiplier:1.f constant:0.f];
    NSLayoutConstraint *lc3 = [NSLayoutConstraint constraintWithItem:spacer attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.f constant:0.f];
    NSLayoutConstraint *lc4 = [NSLayoutConstraint constraintWithItem:spacer attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:5.f];
    [self addConstraints:@[lc1, lc2, lc3]];
    [spacer addConstraint:lc4];

    UIView *aboveView = spacer;
    
    for (OWSFoodBeverageNutrientInfo *nutrientInfo in item.foodAndBevNutrientInfo) {
        UIView *servingSizeLabel = [self addLabelWithText:[NSString stringWithFormat:@"Serving Size: %@ %@", [((OWSQualValue *)nutrientInfo.servingSize.values.firstObject).value stringValue], [OWSCodeMapping displayStringForCode:((OWSQualValue *)nutrientInfo.servingSize.values.firstObject).qual forDefinitionName:nutrientInfo.servingSize.qualDefinition inItem:item]] andFont:normalFont];
        lc1 = [NSLayoutConstraint constraintWithItem:servingSizeLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:aboveView attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f];
        lc2 = [NSLayoutConstraint constraintWithItem:servingSizeLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:aboveView attribute:NSLayoutAttributeLeft multiplier:1.f constant:0.f];
        [self addConstraints:@[lc1, lc2]];
        
        spacer = [[UIView alloc] initWithFrame:CGRectZero];
        spacer.translatesAutoresizingMaskIntoConstraints = NO;
        spacer.backgroundColor = [UIColor darkGrayColor];
        [self addSubview:spacer];
        lc1 = [NSLayoutConstraint constraintWithItem:spacer attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:servingSizeLabel attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f];
        lc2 = [NSLayoutConstraint constraintWithItem:spacer attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:titleLabel attribute:NSLayoutAttributeLeft multiplier:1.f constant:0.f];
        lc3 = [NSLayoutConstraint constraintWithItem:spacer attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.f constant:0.f];
        lc4 = [NSLayoutConstraint constraintWithItem:spacer attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:2.f];
        [self addConstraints:@[lc1, lc2, lc3]];
        [spacer addConstraint:lc4];

        UIView *preparationTypeTitle = [self addLabelWithText:nutrientInfo.preparationState ? nutrientInfo.preparationState : @"" andFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:16.f]];
        lc1 = [NSLayoutConstraint constraintWithItem:preparationTypeTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:servingSizeLabel attribute:NSLayoutAttributeBottom multiplier:1.f constant:4.f];
        lc2 = [NSLayoutConstraint constraintWithItem:preparationTypeTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:servingSizeLabel attribute:NSLayoutAttributeLeft multiplier:1.f constant:0.f];
        [self addConstraints:@[lc1, lc2]];
        
        UIView *amountPerTitle = [self addLabelWithText:@"Amount Per Serving" andFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:16.f]];
        lc1 = [NSLayoutConstraint constraintWithItem:amountPerTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:preparationTypeTitle attribute:NSLayoutAttributeBottom multiplier:1.f constant:4.f];
        lc2 = [NSLayoutConstraint constraintWithItem:amountPerTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:preparationTypeTitle attribute:NSLayoutAttributeLeft multiplier:1.f constant:0.f];
        [self addConstraints:@[lc1, lc2]];
        
        UIView *percentDV = [self addLabelWithText:@"Percent DV" andFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:16.f]];
        lc1 = [NSLayoutConstraint constraintWithItem:percentDV attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:amountPerTitle attribute:NSLayoutAttributeTop multiplier:1.f constant:0.f];
        lc2 = [NSLayoutConstraint constraintWithItem:percentDV attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.f constant:0.f];
        [self addConstraints:@[lc1, lc2]];


        aboveView = amountPerTitle;
        
        for (OWSFoodBeverageNutrientInfo *info in item.foodAndBevNutrientInfo) {
            for (OWSNutrient *nutrient in info.foodAndBeverageNutrient) {
                aboveView = [self addLabelsForNutrient:nutrient belowView:aboveView];
            }
        }
    }
    
    NSLayoutConstraint *bottomLC = [NSLayoutConstraint constraintWithItem:aboveView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f];
    [self addConstraint:bottomLC];

    
}

/**
 * Adds a label
 */
- (UILabel *)addLabelWithText:(NSString *)text andFont:(UIFont *)font {
    UILabel *label = [[UILabel alloc] init];
    
    if (text && font) {
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName : font,
                                                                                                            NSForegroundColorAttributeName : [UIColor darkGrayColor]} ];
        label.attributedText = attributedString;
    }
    label.preferredMaxLayoutWidth = self.frame.size.width;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:label];
    return label;
}

/**
 * Returns the lowest view of the pair
 */
-(UIView *)addLabelsForNutrient:(OWSNutrient *)nutrient belowView:(UIView *)view {
    UILabel *leftLabel = [self addLabelWithText:nil andFont:nil];
    leftLabel.numberOfLines = 0;
    leftLabel.lineBreakMode = NSLineBreakByWordWrapping;

    NSString *nutrientCodeValue = nutrient.nutrientTypeCode.value.firstObject ? nutrient.nutrientTypeCode.value.firstObject : @"";
    NSMutableAttributedString *leftString = [[NSMutableAttributedString alloc] initWithString:[OWSCodeMapping displayStringForCode:nutrientCodeValue forDefinitionName:nutrient.nutrientTypeCode.valueDefinition inItem:self.item] attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:12.f], NSForegroundColorAttributeName : [UIColor darkGrayColor]}];

    [leftString appendAttributedString:[[NSAttributedString alloc] initWithString:@" " attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.f], NSForegroundColorAttributeName : [UIColor darkGrayColor]}]];

    OWSQualValue *quantityContainedValue = nutrient.nutrientQuantityContained.values.firstObject;
    NSString *quantityContainedValueString = [quantityContainedValue.value stringValue] ? [quantityContainedValue.value stringValue] : @"";
    [leftString appendAttributedString:[[NSAttributedString alloc] initWithString:quantityContainedValueString attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.f], NSForegroundColorAttributeName : [UIColor darkGrayColor]}]];
    [leftString appendAttributedString:[[NSAttributedString alloc] initWithString:@" " attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.f], NSForegroundColorAttributeName : [UIColor darkGrayColor]}]];
    [leftString appendAttributedString:[[NSAttributedString alloc] initWithString:[OWSCodeMapping displayStringForCode:quantityContainedValue.qual forDefinitionName:nutrient.nutrientQuantityContained.qualDefinition inItem:self.item] attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.f], NSForegroundColorAttributeName : [UIColor darkGrayColor]}]];
    leftLabel.attributedText = leftString;
    
    NSLayoutConstraint *lc1 = [NSLayoutConstraint constraintWithItem:leftLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f];
    NSLayoutConstraint *lc2 = [NSLayoutConstraint constraintWithItem:leftLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1.f constant:0.f];
    
    UILabel *rightLabel = [self addLabelWithText:nil andFont:nil];
    rightLabel.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %.0f%@", [nutrient.percentageOfDailyValueIntake floatValue], @"%"] attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:12.f], NSForegroundColorAttributeName : [UIColor darkGrayColor]}];
    NSLayoutConstraint *lc3 = [NSLayoutConstraint constraintWithItem:rightLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:leftLabel attribute:NSLayoutAttributeTop multiplier:1.f constant:0.f];
    NSLayoutConstraint *lc4 = [NSLayoutConstraint constraintWithItem:rightLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.f constant:0.f];
    [self addConstraints:@[lc1, lc2, lc3, lc4]];
    
    //make sure the left label is always to the right of the right label
    [self addConstraint:[NSLayoutConstraint constraintWithItem:leftLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:rightLabel attribute:NSLayoutAttributeLeft multiplier:1.f constant:-10.f]];
    
    UIView *spacer = [[UIView alloc] initWithFrame:CGRectZero];
    spacer.translatesAutoresizingMaskIntoConstraints = NO;
    spacer.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:spacer];
    lc1 = [NSLayoutConstraint constraintWithItem:spacer attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:leftLabel attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f];
    lc2 = [NSLayoutConstraint constraintWithItem:spacer attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:leftLabel attribute:NSLayoutAttributeLeft multiplier:1.f constant:0.f];
    lc3 = [NSLayoutConstraint constraintWithItem:spacer attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:rightLabel attribute:NSLayoutAttributeRight multiplier:1.f constant:0.f];
    lc4 = [NSLayoutConstraint constraintWithItem:spacer attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:2.f];
    [self addConstraints:@[lc1, lc2, lc3]];
    [spacer addConstraint:lc4];
    
    return spacer;
}


@end
