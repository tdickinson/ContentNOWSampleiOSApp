//
//  ImagesView.m
//  1WorldSync
//
//  Created by OpenPath Products on 9/29/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "ImagesView.h"
#import "OWSImage.h"

@interface ImagesView()
@property (nonatomic, strong) NSArray *assets;
@end

@implementation ImagesView

- (void)showAssets:(NSArray *)assets {
    //Don't do anything if we don't actually have any assets. That way this view will have 0 height
    if (assets.count < 1) {
        return;
    }
    
    self.assets = assets;
    
    //create the title
    UILabel *label = [[UILabel alloc] init];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"Additional Media" attributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.f], NSForegroundColorAttributeName : [UIColor darkGrayColor]} ];
    label.attributedText = attributedString;
    label.preferredMaxLayoutWidth = self.frame.size.width;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:label];
    
    NSLayoutConstraint *lc1 = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.f constant:0.f];
    NSLayoutConstraint *lc2 = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.f constant:0.f];
    [self addConstraints:@[lc1, lc2]];
    
    UIView *aboveView = label;
    
    //create buttons for each image
    int i = 0;
    for (OWSImage *image in assets) {
        aboveView = [self addButtonForImage:image belowView:aboveView atIndex:i++];
    }

    //add the bottom constraint to this view will know its intrinsic size
    NSLayoutConstraint *bottomLC = [NSLayoutConstraint constraintWithItem:aboveView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f];
    [self addConstraint:bottomLC];
}

/**
 * Returns the newly added view
 */
-(UIView *)addButtonForImage:(OWSImage *)image belowView:(UIView *)view atIndex:(NSUInteger)index {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    button.titleLabel.lineBreakMode = NSLineBreakByTruncatingHead;
    [button setTitle:image.displayString forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.tag = index;
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];

    NSLayoutConstraint *lc1 = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f];
    NSLayoutConstraint *lc2 = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1.f constant:0.f];
    
    [self addConstraints:@[lc1, lc2]];
    
    //don't let button get too large
    lc1 = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:300.f];
    [button addConstraint:lc1];
    
    return button;
}

- (void)buttonPressed:(id)sender {
    [self.delegate selectedImage:self.assets[((UIButton *)sender).tag]];
}

@end
