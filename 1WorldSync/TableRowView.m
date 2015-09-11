//
//  TableRowView.m
//  1WorldSync
//
//  Created by OpenPath Products on 11/21/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "TableRowView.h"

@implementation TableRowView

- (void)setupWithStrings:(NSArray *)strings bold:(BOOL)bold {
    NSMutableArray *labels = [NSMutableArray new];
    
    UIView *previousLabel = nil;
    
    for (NSString *string in strings) {
        UILabel *label = [[UILabel alloc] init];
        label.text = string;
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor darkGrayColor];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        if (bold) {
            label.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:14.f];
        } else {
            label.font = [UIFont systemFontOfSize:12.f];
        }
        
        [self addSubview:label];
        [labels addObject:label];
        
        if ([label isEqual:labels.firstObject]) {
            //set first label to fill self top to bottom, and to align to left
            [self addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.f constant:0.f]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.f constant:0.f]];
                [self addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f]];
            
        } else {
            //set all other labels equal in width, height to first label
            [self addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:labels.firstObject attribute:NSLayoutAttributeWidth multiplier:1.f constant:0.f]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:labels.firstObject attribute:NSLayoutAttributeHeight multiplier:1.f constant:0.f]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:labels.firstObject attribute:NSLayoutAttributeTop multiplier:1.f constant:0.f]];
            //constrain this label to the right of the previous one
            [self addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:previousLabel attribute:NSLayoutAttributeRight multiplier:1.f constant:0.f]];
        }
        
        previousLabel = label;
    }
    

    
    //now align the last label to the right of the view
    [self addConstraint:[NSLayoutConstraint constraintWithItem:labels.lastObject attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.f constant:0.f]];
}

@end
