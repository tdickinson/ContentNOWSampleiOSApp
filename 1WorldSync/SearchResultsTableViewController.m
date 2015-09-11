//
//  SearchResultsTableViewController.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/27/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "SearchResultsTableViewController.h"
#import <RestKit/RestKit.h>
#import "SearchResultTableViewCell.h"
#import "DetailsViewController.h"
#import "LookupManager.h"

@interface SearchResultsTableViewController ()
@property (nonatomic, strong) NSArray *searchResults;

@property (nonatomic, strong) IBOutlet UIButton *settingsButton;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *loadingView;
@end

@implementation SearchResultsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)settingsPressed:(id)sender {
    [((ViewController *)self.parentViewController) showSettings];
}

- (void)doSearch:(NSString *)searchString {
    [self showLoading];
    
    [[LookupManager sharedInstance] search:searchString completion:^(NSArray *responseObjects, NSError *error) {
        [self hideLoading];
        if (error && error.code != 1001) {
            //show error
            [LookupManager showError:error];
        }
        else if (responseObjects.count < 1) {
            //if no objects, make an error that means no results found (restkit error 1001 does this) and pass that through
            [LookupManager showError:[NSError errorWithDomain:@"OWS.Scan" code:1001 userInfo:@{NSLocalizedDescriptionKey : [NSString stringWithFormat:@"%@ did not return any matching products in ContentNOW", searchString]}]];
        }
        else {
            self.searchResults = responseObjects;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - Loading 

- (void)showLoading {
    [self.loadingView startAnimating];
    self.settingsButton.hidden = YES;
}

- (void)hideLoading {
    [self.loadingView stopAnimating];
    self.settingsButton.hidden = NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResults.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchResultCell" forIndexPath:indexPath];
    [cell setUpWithResultItem:self.searchResults[indexPath.row]];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetails"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailsViewController *destViewController = segue.destinationViewController;
        destViewController.item = ((OWSSearchResult *)self.searchResults[indexPath.row]).item;
    }
}

@end
