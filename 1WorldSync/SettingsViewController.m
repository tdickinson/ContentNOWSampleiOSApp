//
//  SettingsViewController.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/25/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsManager.h"

@interface SettingsViewController () <UITextFieldDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) IBOutlet UITextField *apiKeyTextField;
@property (nonatomic, strong) IBOutlet UITextField *appIdTextField;
@property (nonatomic, strong) IBOutlet UITextField *baseUrlTextField;
@property (nonatomic, strong) IBOutlet UITextField *hardcodedProductIdTextField;
@property (nonatomic, strong) IBOutlet UISwitch *offlineSwitch;
@property (nonatomic, strong) IBOutlet UISwitch *showAdditionalMediaSwitch;
@property (nonatomic, strong) IBOutlet UISwitch *detailsModeSwitch;//between ITI mode and EU1169 mode
@property (nonatomic, strong) IBOutlet UIPickerView *languagePicker;

@property (nonatomic, strong) IBOutlet UILabel *versionLabel;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *keyboardProxyHeightConstraint;
@end

@implementation SettingsViewController

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
    self.apiKeyTextField.text = [SettingsManager apiKey];
    self.appIdTextField.text = [SettingsManager appId];
    self.baseUrlTextField.text = [SettingsManager baseUrl];
    self.hardcodedProductIdTextField.text = [SettingsManager hardcodedProductId];
    self.offlineSwitch.on = [SettingsManager offlineMode];
    self.showAdditionalMediaSwitch.on = [SettingsManager showAdditionalMedia];
    self.detailsModeSwitch.on = [SettingsManager eu1169Mode];//ON is eu1169 mode, OFF is ITI mode
    [self.languagePicker selectRow:[self rowForLanguage:[SettingsManager language]] inComponent:0 animated:NO];
    
    NSDictionary *bundleDict = [[NSBundle mainBundle] infoDictionary];
    self.versionLabel.text = [NSString stringWithFormat:@"%@ build %@", bundleDict[@"CFBundleShortVersionString"], bundleDict[@"CFBundleVersion"]];
    
    //Make sure buttons stay above keyboard
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"saveSegue"]) {
        //save settings
        [SettingsManager setApiKey:self.apiKeyTextField.text];
        [SettingsManager setAppId:self.appIdTextField.text];
        [SettingsManager setBaseUrl:self.baseUrlTextField.text];
        [SettingsManager setHardcodedProductId:self.hardcodedProductIdTextField.text];
        [SettingsManager setOfflineMode:self.offlineSwitch.on];
        [SettingsManager setLanguage:[self languageForRow:[self.languagePicker selectedRowInComponent:0]]];
        [SettingsManager setShowAdditionalMedia:self.showAdditionalMediaSwitch.on];
        [SettingsManager setEu1169Mode:self.detailsModeSwitch.on];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - Keyboard handling

-(void)keyboardWillChangeFrame:(NSNotification*)notification
{
    [self handleUpdatedKeyboard:notification];
}

- (void)keyboardDidChangeFrame:(NSNotification *)notification {
    [self handleUpdatedKeyboard:notification];
}

- (void)handleUpdatedKeyboard:(NSNotification *)notification {
    NSDictionary * userInfo = notification.userInfo;
    UIViewAnimationCurve animationCurve  = [userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    NSValue *endFrameValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    //Don't do anything if there is no end frame value (which could happen in split keyboard)
    if (endFrameValue) {
        // convert the keyboard's CGRect from screen coords to view coords
        CGRect kbEndFrame = [self.view convertRect:[endFrameValue CGRectValue]
                                          fromView:self.view.window];
        // update the constant factor of the constraint governing the tracking view
        CGFloat newConstant = self.view.bounds.size.height - kbEndFrame.origin.y;
        if (newConstant != self.keyboardProxyHeightConstraint.constant) {
            self.keyboardProxyHeightConstraint.constant = newConstant;
            // tell the constraint solver it needs to re-solve other constraints.
            [self.view setNeedsUpdateConstraints];
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:duration];
            [UIView setAnimationCurve:animationCurve];
            [UIView setAnimationBeginsFromCurrentState:YES];
            //Use old UIView animations to set the curve type
            [self.view layoutIfNeeded];
            [UIView commitAnimations];
        }
    }
}

#pragma mark - Language

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (row) {
        case 0:
        default:
            return @"All";
        case 1:
            return @"English";
        case 2:
            return @"German";
    }
}

- (OWSLanguage)languageForRow:(int)row {
    switch (row) {
        case 0:
        default:
            return OWSLanguageAll;
        case 1:
            return OWSLanguageEnglish;
        case 2:
            return OWSLanguageGerman;
    }
}

- (int)rowForLanguage:(OWSLanguage)language {
    switch (language) {
        case OWSLanguageAll:
        default:
            return 0;
        case OWSLanguageEnglish:
            return 1;
        case OWSLanguageGerman:
            return 2;
    }
}


@end
