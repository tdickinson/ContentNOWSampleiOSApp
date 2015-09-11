//
//  ScanViewController.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/25/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "ScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ViewController.h"
#import "LookupManager.h"
#import "SettingsManager.h"
#import "DetailsViewController.h"
#import "OWSSearchResult.h"

@interface ScanViewController () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, strong) IBOutlet UIView *previewView;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) IBOutlet UIButton *startButton;
@property (nonatomic, strong) IBOutlet UIButton *closePreviewButton;
@property (nonatomic, strong) OWSSearchResult *foundSearchResult;
@property (nonatomic, strong) NSString *foundCode;

@end

@implementation ScanViewController

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
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
#if !(TARGET_IPHONE_SIMULATOR)
    [self startReading];
#endif
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self cancelReading];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetails"]) {
        DetailsViewController *destViewController = segue.destinationViewController;
        destViewController.item = self.foundSearchResult.item;
    }
}

- (IBAction)settingsPressed:(id)sender {
    [((ViewController *)self.parentViewController) showSettings];
}

#pragma mark - Reading

- (IBAction)scanPressed:(id)sender {
#if (TARGET_IPHONE_SIMULATOR)
    [self searchForCode:nil];
#else
    //Do the scan
    [self searchForCode:self.foundCode];
#endif
}

- (IBAction)closePreviewPressed:(id)sender {
    [self startReading];
}

- (void)startReading {
    //remove any old session
    [self cancelReading];
    
    self.closePreviewButton.hidden = YES;
    
    //Start reading right away
    NSError *error = nil;
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (error) {
        [LookupManager showError:error];
        [self stopReading];
        return;
    }
    
    self.captureSession = [[AVCaptureSession alloc] init];
    [self.captureSession addInput:input];
    
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [self.captureSession addOutput:captureMetadataOutput];
    
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("scanQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    
    //Support all machine readable types (i.e. everything but faces)
    NSMutableArray *supportedTypes = [NSMutableArray array];
    for (NSString *machineType in captureMetadataOutput.availableMetadataObjectTypes) {
        if (![@"face" isEqualToString:machineType]) {//everything but face
            [supportedTypes addObject:machineType];
        }
    }
    [captureMetadataOutput setMetadataObjectTypes:supportedTypes];
    
    self.videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [self.videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.videoPreviewLayer setFrame:self.previewView.layer.bounds];
    [self.previewView.layer addSublayer:self.videoPreviewLayer];
    
    [self.captureSession startRunning];
}

- (void)stopReading {
    self.closePreviewButton.hidden = NO;
    
    //pauses the preview
    _videoPreviewLayer.connection.enabled = NO;
}

- (void)cancelReading {
    self.foundCode = nil;
    self.closePreviewButton.hidden = YES;
    [self.captureSession stopRunning];
    self.captureSession = nil;
    [_videoPreviewLayer removeFromSuperlayer];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if ([metadataObjects count]) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([metadataObj respondsToSelector:@selector(stringValue)]) {
            dispatch_sync(dispatch_get_main_queue(), ^(void){
                self.foundCode = metadataObj.stringValue;
                
                //check for 13-digit UPC and add extra 0 in front
                if (metadataObj.stringValue.length == 13) {
                    self.foundCode = [NSString stringWithFormat:@"0%@", self.foundCode];
                }
                [self stopReading];
            });
        }
    }
}

#pragma mark - Lookup

- (void)searchForCode:(NSString *)code {

    //Use a hardcoded code only if one is entered in settings
    NSString *hardcodedCode = [SettingsManager hardcodedProductId];
    if (hardcodedCode.length) {
        code = hardcodedCode;
    }

    if (code.length < 1) {
        return;
    }    
    
    [self stopReading];
    
    [self showLoading];
    

    [[LookupManager sharedInstance] lookupCode:code completion:^(NSArray *responseObjects, NSError *error) {
        [self hideLoading];
        
        if (error && error.code != 1001) {
            //show error
            [LookupManager showError:error];
        }
        else if (responseObjects.count < 1) {
            //if no objects, make an error that means no results found (restkit error 1001 does this) and pass that through
            [LookupManager showError:[NSError errorWithDomain:@"OWS.Scan" code:1001 userInfo:@{NSLocalizedDescriptionKey : [NSString stringWithFormat:@"%@ did not return any matching products in ContentNOW", code]}]];
        }
        else {
            //handle success, push details screen
            self.foundSearchResult = [responseObjects firstObject];
            [self performSegueWithIdentifier:@"showDetails" sender:self];
        }
    }];
}

- (void)showLoading {
    [self.activityIndicator startAnimating];
    self.previewView.hidden = YES;
    //use alpha so we don't mess with hidden/visible state that's based on preview existing or not
    self.closePreviewButton.alpha = 0;
}

- (void)hideLoading {
    [self.activityIndicator stopAnimating];
    self.previewView.hidden = NO;
    self.closePreviewButton.alpha = 1;
}

@end
