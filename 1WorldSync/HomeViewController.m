//
//  HomeViewController.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/25/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "HomeViewController.h"
#import "ViewController.h"
#import "SettingsManager.h"
#import "LookupManager.h"

#define kShowScanSegueIdentifier @"showScan"
#define kShowSearchSegueIdentifier @"showSearch"
#define kShowSettingsSegueIdentifier @"showSettings"

@interface HomeViewController () <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *searchTextField;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) IBOutlet UIImageView *logoImageView;
@property (nonatomic, strong) IBOutlet UIImageView *tagImageView;
@end

@implementation HomeViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    //load the images every view will appear to make sure they update asap if changes are made
    [self.activityIndicator startAnimating];
    self.logoImageView.hidden = YES;
    self.tagImageView.hidden = YES;
    [SettingsManager loadImagesIfNecessary:^(void){
        [self.activityIndicator stopAnimating];
        self.logoImageView.hidden = NO;
        self.tagImageView.hidden = NO;
        [self.logoImageView setImage:[SettingsManager logoImage]];
        [self.tagImageView setImage:[SettingsManager tagImage]];
    }];
    
    self.searchTextField.text = [LookupManager mostRecentSearchString];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ViewController *destination = ((ViewController *)segue.destinationViewController);
    
    if ([segue.identifier isEqualToString:kShowScanSegueIdentifier]) {
        destination.target = OWSTargetViewScan;
    }
    else if ([segue.identifier isEqualToString:kShowSearchSegueIdentifier]) {
        destination.target = OWSTargetViewSearch;
        destination.targetViewControllerParam = self.searchTextField.text;
        [LookupManager setMostRecentSearchString:self.searchTextField.text];
    }
    else if ([segue.identifier isEqualToString:kShowSettingsSegueIdentifier]) {
        destination.target = OWSTargetViewSettings;
    }
}


- (IBAction)unwindToThisViewController:(UIStoryboardSegue *)unwindSegue
{
    
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if (textField.text.length) {
        //do search
        [self performSegueWithIdentifier:@"showSearch" sender:self];
    }
    return NO;
}

@end


