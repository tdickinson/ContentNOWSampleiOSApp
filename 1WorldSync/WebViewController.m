//
//  WebViewController.m
//  1WorldSync
//
//  Created by OpenPath Products on 9/29/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSURL *urlToLoad;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.urlToLoad]];
    
    //Set up the nav bar (need to add two left bar button items so we can't do it in code)
    UIImage *backImage = [[UIImage imageNamed:@"back_arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStyleBordered target:self action:@selector(goBack)];
    
    [self.navigationItem setLeftBarButtonItems:@[backItem]];
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadURL:(NSURL *)url {
    self.urlToLoad = url;
}
@end
