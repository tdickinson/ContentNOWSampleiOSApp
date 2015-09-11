//
//  ViewController.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/25/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "ViewController.h"
#import "ScanViewController.h"
#import "SearchResultsTableViewController.h"
#import "DetailsViewController.h"
#import "OWSItem.h"
#import "SettingsManager.h"
#import "LookupManager.h"

@interface UIView (AutoLayout)

@end

@implementation UIView (AutoLayout)

- (void)addContraintsToFill:(UIView *)view {
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *con1 = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:0 toItem:view attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *con2 = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:0 toItem:view attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    NSLayoutConstraint *con3 = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:0 toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *con4 = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:0 toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSArray *constraints = @[con1,con2,con3,con4];
    [self addConstraints:constraints];
}

@end

@interface ViewController () <UISearchBarDelegate>
@property (nonatomic, strong) IBOutlet UIView *containerView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    UIImage *homeImage = [[UIImage imageNamed:@"Home_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *homeItem = [[UIBarButtonItem alloc] initWithImage:homeImage style:UIBarButtonItemStyleBordered target:self action:@selector(showHome)];
    
    UIImage *barcodeImage = [[UIImage imageNamed:@"barcodesmall"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *barcodeItem = [[UIBarButtonItem alloc] initWithImage:barcodeImage style:UIBarButtonItemStyleBordered target:self action:@selector(showScan)];

    [self.navigationItem setLeftBarButtonItems:@[homeItem, barcodeItem]];
    
    UISearchBar *bar = [[UISearchBar alloc] init];
    bar.delegate = self; 
    bar.placeholder = @"Search...";
    bar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    bar.autocorrectionType = UITextAutocorrectionTypeDefault;
    self.navigationItem.titleView = bar;
    
    switch (self.target) {
        case OWSTargetViewSettings:
            [self showSettings];
            break;
        case OWSTargetViewSearch:
            [self showSearch:(NSString *)self.targetViewControllerParam];
            break;
        case OWSTargetViewScan:
        default:
            //nothing to do, scan is already the default
            break;
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:122.f/255.f green:202.f/255.f blue:240.f/255.f alpha:1.f]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    //Do search
    [searchBar resignFirstResponder];
    
    if (searchBar.text.length > 0) {
        [self showSearch:searchBar.text];
    }
}

#pragma Transitions

- (void)showHome {
    [self performSegueWithIdentifier:@"unwind" sender:self];
}

- (void)showScan {
    [self swapToViewControllerWithName:@"ScanViewController"];
}

- (void)showSettings {
    [self swapToViewControllerWithName:@"SettingsViewController"];
}

- (void)showSearch:(NSString *)searchString {
    [LookupManager setMostRecentSearchString:searchString];
    
    [self swapToViewControllerWithName:@"SearchResultsTableViewController"];
    
    SearchResultsTableViewController *searchResultsTableViewController = (SearchResultsTableViewController *)self.childViewControllers.lastObject;
    [searchResultsTableViewController doSearch:searchString];
}

- (IBAction)unwindToContainerViewController:(UIStoryboardSegue *)unwindSegue {
    switch (self.target) {
        case OWSTargetViewSettings:
            [self showSettings];
            break;
        case OWSTargetViewSearch:
            [self showSearch:(NSString *)self.targetViewControllerParam];
            break;
        case OWSTargetViewScan:
        default:
            [self showScan];
            break;
    }
}

#pragma Container

- (void)swapToViewControllerWithName:(NSString *)storyboardIdentifier
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *toViewController = [storyboard instantiateViewControllerWithIdentifier:storyboardIdentifier];
    toViewController.view.frame = self.view.bounds;
    UIViewController *fromViewController = self.childViewControllers.firstObject;
    
    toViewController.view.autoresizingMask = UIViewAutoresizingNone;

    [fromViewController willMoveToParentViewController:nil];
    
    [self addChildViewController:toViewController];
    [self transitionFromViewController:fromViewController toViewController:toViewController duration:.5f options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        [fromViewController removeFromParentViewController];
        [toViewController didMoveToParentViewController:self];
        [self.containerView addContraintsToFill:toViewController.view];
    }];
}


@end
