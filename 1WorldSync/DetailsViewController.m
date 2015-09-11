//
//  DetailsViewController.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/27/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "DetailsViewController.h"
#import <RestKit/RestKit.h>
#import "LookupManager.h"
#import "NutritionInfoView.h"
#import "OWSImage.h"
#import "WebViewController.h"
#import "ImagesView.h"
#import "SettingsManager.h"
#import "EU1169View.h"
#import <MessageUI/MessageUI.h>

@interface DetailsViewController () <ImagesViewDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UIView *brandingView;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *brandingViewHeightConstraint;
@property (nonatomic, strong) IBOutlet UIImageView *brandingImageView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *productNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *descriptionTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, strong) IBOutlet UILabel *ingredientsTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *ingredientsLabel;
@property (nonatomic, strong) IBOutlet NutritionInfoView *nutritionInfoView;
@property (nonatomic, strong) IBOutlet UILabel *allergensTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *allergensLabel;
@property (nonatomic, strong) IBOutlet UILabel *digitalIdTitleLabel;
@property (nonatomic, strong) IBOutlet UITextView *digitalIdTextView;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *digitalIdTextViewHeightConstraint;
@property (nonatomic, strong) IBOutlet UIImageView *detailsImageView;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *detailsImageViewHeightConstraint;
@property (nonatomic, strong) IBOutlet UIImageView *consumerHandlingImageView;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *consumerHandlingImageViewHeightConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *labelLeadingConstraint;
@property (nonatomic, strong) IBOutlet UIButton *brandOwnerButton;
@property (nonatomic, strong) IBOutlet UIButton *emailProductDetailsPageButton;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *brandOwnerButtonHeightConstraint;
@property (nonatomic, strong) IBOutlet ImagesView *imagesView;
@property (nonatomic, strong) IBOutlet UIView *loadingView;
@property (nonatomic, strong) IBOutlet EU1169View *eu1169View;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *loadingViewActivityIndicator;
@property (nonatomic, strong) UIBarButtonItem *scanBarButton;
@property (nonatomic, strong) NSString *searchString;
@end

@implementation DetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Set up the nav bar (need to add two left bar button items so we can't do it in code)
    UIImage *backImage = [[UIImage imageNamed:@"back_arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStyleBordered target:self action:@selector(goBack)];
    
    UIImage *barcodeImage = [[UIImage imageNamed:@"barcodesmall"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.scanBarButton = [[UIBarButtonItem alloc] initWithImage:barcodeImage style:UIBarButtonItemStyleBordered target:self action:@selector(showScan)];
    
    [self.navigationItem setLeftBarButtonItems:@[backItem, self.scanBarButton]];
    
    //Load the full details via the details API, then show the results
    [self showLoading];
    
    [[LookupManager sharedInstance] getDetails:self.item.itemId completion:^(NSArray *responseObjects, NSError *error) {
        [self hideLoading];
        if (error && error.code != 1001) {
            [LookupManager showError:error];
        }
        else if (responseObjects.count < 1) {
            //if no objects, make an error that means no results found (restkit error 1001 does this) and pass that through
            [LookupManager showError:[NSError errorWithDomain:@"OWS.Scan" code:1001 userInfo:@{NSLocalizedDescriptionKey : [NSString stringWithFormat:@"%@ did not return any matching products in ContentNOW", self.item.itemId]}]];
        }
        else {
            //set the current item to be the first in the response, show details
            self.item = responseObjects.firstObject;
            [self showDetails];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.brandingView.backgroundColor = [UIColor clearColor];
    
    //if there is a branding logo, set it. if not, hide the entire branding view
    UIImage *detailsBrandingImage = [SettingsManager detailsBrandingImage];
    if (detailsBrandingImage) {
        self.brandingImageView.image = detailsBrandingImage;
    } else {
        self.brandingViewHeightConstraint.constant = 0.f;
    }

    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)] && [SettingsManager detailsBrandingColor]) {
        [self.navigationController.navigationBar setBarTintColor:[SettingsManager detailsBrandingColor]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showDetails {
    //set the label's preferred max layout widths so they will expand vertically properly. Calculate it to be
    //the full size of the parent scrollview
    CGFloat preferredMaxLayoutWidth = self.scrollView.bounds.size.width;
    self.titleLabel.preferredMaxLayoutWidth = preferredMaxLayoutWidth;
    self.productNameLabel.preferredMaxLayoutWidth = preferredMaxLayoutWidth;
    self.descriptionLabel.preferredMaxLayoutWidth = preferredMaxLayoutWidth;
    self.ingredientsLabel.preferredMaxLayoutWidth = preferredMaxLayoutWidth;
    self.allergensLabel.preferredMaxLayoutWidth = preferredMaxLayoutWidth;
    
    
    
    // Do any additional setup after loading the view.
    self.title = self.item.brandName;
    self.titleLabel.text = self.item.brandName;
    self.productNameLabel.text = ((OWSValue *)self.item.productName.values.firstObject).value.firstObject;
    
    if (!self.item.itemDescription.length) {
        self.descriptionTitleLabel.text = @"";
    }
    self.descriptionLabel.text = self.item.itemDescription;
    
    if ([SettingsManager eu1169Mode] || !self.item.itemIngredients.length) {
        self.ingredientsTitleLabel.text = @"";
        self.ingredientsLabel.text = @"";
    } else {
        self.ingredientsLabel.text = self.item.itemIngredients;
    }
    
    if (!self.item.itemAllergens.length) {
        self.allergensTitleLabel.text = @"";
    }
    self.allergensLabel.text = self.item.itemAllergens;

    if (!self.item.digitalId.length) {
        self.digitalIdTitleLabel.text = @"";
        self.digitalIdTextViewHeightConstraint.constant = 0;
    }
    self.digitalIdTextView.text = self.item.digitalId;
    
    [self.nutritionInfoView showItem:self.item];
    
    if ([SettingsManager eu1169Mode]) {
        [self.eu1169View showItem:self.item];
    }

    NSString *imageUrlString = [self.item itemImageUrl:NO];
    if (imageUrlString.length) {
        [self.detailsImageView setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:[UIImage imageNamed:@"ImagePlaceholder"]];
    } else {
        self.detailsImageView.hidden = YES;
        self.detailsImageViewHeightConstraint.constant = 0.f;
    }
    
    //If not show additional media, then show brand owner link. If show additional media, brand owner link will be shown in that
    BOOL hideBrandOwnerLink = NO;
    if ([SettingsManager showAdditionalMedia]) {
        hideBrandOwnerLink = YES;
    }
    if (!self.item.brandOwnerLink) {
        hideBrandOwnerLink = YES;
    }
    if (hideBrandOwnerLink) {
        self.brandOwnerButtonHeightConstraint.constant = 0;
        self.brandOwnerButton.hidden = YES;
    }

    OWSImage *storageImage = nil;
    
    //find the consumer handling and storage image and show it
    for (OWSImage *image in self.item.imageInformation) {
        if ([image.productImageType.value.firstObject isEqualToString:@"CONSUMER_HANDLING_AND_STORAGE"]) {
            storageImage = image;
            break;
        }
    }
    
    if (storageImage) {
        NSURL *storageImageUrl = [storageImage urlForSize:self.consumerHandlingImageView.bounds.size];
        [self.consumerHandlingImageView setImageWithURL:storageImageUrl];
    } else {
        self.consumerHandlingImageView.hidden = YES;
        self.consumerHandlingImageViewHeightConstraint.constant = 0.f;
    }
    
    //show all image links. this will show duplicates of the primary image and the consumer handling and storage.
    //Hide if not supposed to show them
    if ([SettingsManager showAdditionalMedia]) {
        self.imagesView.delegate = self;
        [self.imagesView showAssets:self.item.imageInformation];
    }
}

- (void)showLoading {
    self.loadingView.hidden = NO;
    [self.loadingViewActivityIndicator startAnimating];
}

- (void)hideLoading {
    self.loadingView.hidden = YES;
    [self.loadingViewActivityIndicator stopAnimating];
}

- (void)showScan {
    [self performSegueWithIdentifier:@"unwindToContainerViewController" sender:self.scanBarButton];
}

- (void)showSettings {

}

- (void)showSearch:(NSString *)searchString {
    [LookupManager setMostRecentSearchString:searchString];
    
    self.searchString = searchString;
    [self performSegueWithIdentifier:@"unwindToContainerViewController" sender:self];
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[OWSImage class]]) {
        //show details for the image
        [((WebViewController *)segue.destinationViewController) loadURL:[NSURL URLWithString:((OWSImage *)sender).uniformResourceIdentifier]];
    } else if ([sender isEqual:self.brandOwnerButton]) {
        [((WebViewController *)segue.destinationViewController) loadURL:self.item.brandOwnerLink];
    } else {
        ViewController *destination = ((ViewController *)segue.destinationViewController);
        if ([sender isEqual:self.scanBarButton]) {
            destination.target = OWSTargetViewScan;
        }
        else {
            //search
            destination.target = OWSTargetViewSearch;
            destination.targetViewControllerParam = self.searchString;
        }
    }
}

#pragma mark - ImagesViewDelegate

- (void)selectedImage:(OWSImage *)image {
    //using the sender as the image so we can pass the url along with it
    [self performSegueWithIdentifier:@"showDetails" sender:image];
    
}

#pragma mark - Email

- (IBAction)emailProductDetailsPage:(id)sender {
    MFMailComposeViewController *composeVC = [[MFMailComposeViewController alloc] init];
    
    composeVC.mailComposeDelegate = self;
    [composeVC setSubject:[NSString stringWithFormat:@"%@ product details", self.item.brandName]];
    [composeVC setMessageBody:[SettingsManager urlStringForItem:self.item] isHTML:NO];
    
    [self presentViewController:composeVC animated:YES completion:^(void){
        
    }];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
