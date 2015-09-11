//
//  ImagesView.h
//  1WorldSync
//
//  Created by OpenPath Products on 9/29/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OWSImage;

/**
 * A given OWSImage was selected
 */
@protocol ImagesViewDelegate <NSObject>

- (void)selectedImage:(OWSImage *)image;

@end

/**
 * Shows links (buttons) to all images/media associated with the item
 */
@interface ImagesView : UIView
@property (nonatomic, weak) id<ImagesViewDelegate>delegate;

/**
 * Shows the media assets for this item
 * @param assets NSArray of OWSImage objects
 */
- (void)showAssets:(NSArray *)assets;

@end
