//
//  MoviesViewController.m
//  Rotten Tomatoes
//
//  Created by Sarat Tallamraju on 2/5/15.
//  Copyright (c) 2015 Sarat Tallamraju. All rights reserved.
//

#import "MoviesViewController.h"
#import "SaratUtils.h"
#import "MovieTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailViewController.h"
#import "SVProgressHUD.h"

@interface MoviesViewController ()

@property (strong, nonatomic) NSString *apiKey;

@property (strong, nonatomic) NSString *currentUrlString;
@property (strong, nonatomic) NSString *boxOfficeUrlString;
@property (strong, nonatomic) NSString *dvdUrlString;

@property (strong, nonatomic) NSString *cellName;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) NSArray *boxOfficeMovies;
@property (strong, nonatomic) IBOutlet UITableView *moviesTableView;
@property (strong, nonatomic) IBOutlet UILabel *networkErrorLabel;
@property (strong, nonatomic) IBOutlet UITabBar *tabBar;
@property (nonatomic) NSInteger tabId;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation MoviesViewController

#pragma mark Application Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabId = 0;
    
    // State
    self.apiKey = @"pbxv42978s4rh7tacnzwx669";
    self.cellName = @"MovieTableViewCell";
    
    self.boxOfficeUrlString = [NSString stringWithFormat: @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=%@", self.apiKey];
    
    self.currentUrlString = self.boxOfficeUrlString;
    self.dvdUrlString = [NSString stringWithFormat: @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=%@", self.apiKey];
    
    [self.navigationItem setTitle:@"Box Office"];
    [self onRefresh];
    
    // Wire up the table to this class.
    self.moviesTableView.delegate = self;
    self.moviesTableView.dataSource = self;
    self.moviesTableView.rowHeight = 115;
    UINib *movieCellNib = [UINib nibWithNibName:self.cellName bundle:nil];
    [self.moviesTableView registerNib:movieCellNib forCellReuseIdentifier:self.cellName];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.moviesTableView addSubview:self.refreshControl];
    // [self.refreshControl beginRefreshing];
    
    self.networkErrorLabel.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.7];
    self.networkErrorLabel.textColor = [UIColor whiteColor];
    
    // self.tabBar.tintColor = [UIColor whiteColor];
    
    self.tabBar.delegate = self;
    self.tabBar.selectedItem = [self.tabBar.items objectAtIndex: self.tabId];
    
    self.searchBar.delegate = self;
    
    // [SVProgressHUD show];
}

-(void) executeSearch: (UISearchBar *)searchBar {
    NSString *escaped = [searchBar.text stringByAddingPercentEncodingWithAllowedCharacters: [NSCharacterSet URLHostAllowedCharacterSet]];
    self.currentUrlString = [NSString stringWithFormat: @"http://api.rottentomatoes.com/api/public/v1.0/movies.json?q=%@&page_limit=20&page=1&apikey=%@", escaped, self.apiKey];
    self.tabId = 3;
    [self onRefresh];
    // [self cancelSearch:searchBar];
}

-(void) cancelSearch: (UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

-(void) searchBarDidEndEditing: (UISearchBar *)searchBar {
    NSLog(@"search bar done editing");
    [self executeSearch:searchBar];
}

-(void) searchBarSearchButtonClicked: (UISearchBar *)searchBar {
    NSLog(@"search bar search button clicked");
    [self executeSearch:searchBar];
}

-(void) searchBarCancelButtonClicked: (UISearchBar *)searchBar {
    NSLog(@"search bar cancel button clicked");
    [self cancelSearch:searchBar];
}

-(void)requestMoviesWithSearchString: (NSString *) searchString {
    [SVProgressHUD show];
    NSString *urlString = [NSString stringWithFormat: @"http://api.rottentomatoes.com/api/public/v1.0/movies.json?q=%@&page_limit=20&page=1&apikey=%@", searchString, self.apiKey];
    [self requestMoviesWithURL:urlString];
}

-(void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if (item.tag == 0) {
        NSLog(@"Box Office tab selected");
        if (self.tabId == 0) {
            NSLog(@"Tab already selected, not doing anything");
            return;
        }
        self.tabId = 0;
        self.currentUrlString = self.boxOfficeUrlString;
        [self onRefresh];
    } else {
        NSLog(@"DVD tab selected");
        if (self.tabId == 1) {
            NSLog(@"Tab already selected, not doing anything");
            return;
        }
        self.tabId = 1;
        self.currentUrlString = self.dvdUrlString;
        [self onRefresh];
    }
}

- (void)onRefresh {
    NSLog(@"onRefresh");
    [SVProgressHUD show];
    if (self.tabId != 3) {
        self.searchBar.text = @"";
    }
    [self.searchBar resignFirstResponder];
    [self requestMoviesWithURL: self.currentUrlString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table Listeners

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableViewCell *mtvc = [self.moviesTableView dequeueReusableCellWithIdentifier: self.cellName forIndexPath:indexPath];
    // UIImageView *uiv = ptvc.photoView;
    
    // Get data
    NSDictionary *movieData = self.boxOfficeMovies[indexPath.row];
    NSString *movieTitle = movieData[@"title"];
    NSString *movieSynopsis = movieData[@"synopsis"];
    NSString *thumbnailUrl = movieData[@"posters"][@"thumbnail"];
    NSURL *url = [NSURL URLWithString: thumbnailUrl];
    
    // Set cell view.
    mtvc.movieTitleLabel.text = movieTitle;
    mtvc.movieTitleLabel.textColor = [UIColor blackColor];
    mtvc.movieSynopsisLabel.text = movieSynopsis;
    [mtvc.movieThumbnailImageView setImageWithURL:url];
    
    return mtvc;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.boxOfficeMovies count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected row %ld in section %ld", (long)indexPath.row, (long)indexPath.section);
    
    [self.moviesTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (!self.networkErrorLabel.hidden) {
        NSLog(@"network is down, can't segue");
        return;
    }
    
    MovieDetailViewController *mdvc = [[MovieDetailViewController alloc] init];
    mdvc.movieData = self.boxOfficeMovies[indexPath.row];
    
    [self.navigationController pushViewController:mdvc animated:YES];
}

#pragma mark Requests

- (void)requestDVDList {
    [SVProgressHUD show];
    [self requestMoviesWithURL:self.dvdUrlString];
}

- (void)requestMoviesList {
    [SVProgressHUD show];
    [self requestMoviesWithURL:self.boxOfficeUrlString];
}

- (void)requestMoviesWithURL: (NSString *) urlString {
    [SaratUtils makeRequestToUrl: urlString
         completionHandler: ^(NSURLResponse *response, NSData *data, NSError *connectionError) {
             
             if (connectionError) {
                 // Handle connection error.
                 NSLog(@"Connection error, failed to request: %@", urlString);
                 self.networkErrorLabel.hidden = NO;
                 [self.refreshControl endRefreshing];
                 [SVProgressHUD dismiss];
             } else {
                 
                 // The Response.
                 NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                 // NSLog(@"JSON response: %@", jsonResponse);
                 
                 self.boxOfficeMovies = jsonResponse[@"movies"];
                 
                 NSMutableArray *temp = [[NSMutableArray alloc] initWithCapacity:0];
                 for (int i = 0; i < self.boxOfficeMovies.count; i++) {
                     NSDictionary *data = [self.boxOfficeMovies objectAtIndex:i];
                     if ([data[@"synopsis"] length] > 0) {
                         [temp addObject:data];
                     }
                 }
                 self.boxOfficeMovies = temp;
                 
                 [self.moviesTableView reloadData];
                 [self.refreshControl endRefreshing];
                 self.networkErrorLabel.hidden = YES;
                 [SVProgressHUD dismiss];
             }
    }];
}

@end
