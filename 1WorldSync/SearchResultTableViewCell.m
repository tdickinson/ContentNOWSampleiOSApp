//
//  SearchResultTableViewCell.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/27/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "SearchResultTableViewCell.h"
#import <RestKit/RestKit.h>
#import "OWSImage.h"

@interface SearchResultTableViewCell()
@property (nonatomic, strong) IBOutlet UIImageView *detailsImageView;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;

@end
@implementation SearchResultTableViewCell

- (void)setUpWithResultItem:(OWSSearchResult *)result {
    //try to load the first image
    self.detailsImageView.image = nil;//clear out old image
    if (result.item.imageInformation.count) {
        [self.detailsImageView setImageWithURL:[NSURL URLWithString:[result.item itemImageUrl:YES]] placeholderImage:[UIImage imageNamed:@"ImagePlaceholder"]];
    } else {
        self.detailsImageView.image = [UIImage imageNamed:@"ImagePlaceholder"];
    }
    
    self.titleLabel.text = ((OWSValue *)result.item.productName.values.firstObject).value.firstObject;
    self.descriptionLabel.text = result.item.itemDescription;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
