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

@interface MoviesViewController ()

@property (strong, nonatomic) NSString *apiKey;
@property (strong, nonatomic) NSString *cellName;
@property (strong, nonatomic) NSArray *boxOfficeMovies;
@property (strong, nonatomic) IBOutlet UITableView *moviesTableView;

@end

@implementation MoviesViewController

#pragma mark Application Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // State
    self.apiKey = @"pbxv42978s4rh7tacnzwx669";
    self.cellName = @"MovieTableViewCell";
    
    [self.navigationItem setTitle:@"Movies"];
    [self requestMoviesList];
    
    // Wire up the table to this class.
    self.moviesTableView.delegate = self;
    self.moviesTableView.dataSource = self;
    self.moviesTableView.rowHeight = 115;
    UINib *movieCellNib = [UINib nibWithNibName:self.cellName bundle:nil];
    [self.moviesTableView registerNib:movieCellNib forCellReuseIdentifier:self.cellName];
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
    
    MovieDetailViewController *mdvc = [[MovieDetailViewController alloc] init];
    mdvc.movieData = self.boxOfficeMovies[indexPath.row];
    
    [self.navigationController pushViewController:mdvc animated:YES];
}

#pragma mark Requests

- (void)requestMoviesList {
    NSString *urlString = [NSString stringWithFormat: @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=%@", self.apiKey];
    
    [SaratUtils makeRequestToUrl: urlString
         completionHandler: ^(NSURLResponse *response, NSData *data, NSError *connectionError) {
             
             if (connectionError) {
                 // Handle connection error.
                 NSLog(@"Connection error, failed to request: %@", urlString);
             } else {
                 
                 // The Response.
                 NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                 // NSLog(@"JSON response: %@", jsonResponse);
                 
                 self.boxOfficeMovies = jsonResponse[@"movies"];
                 [self.moviesTableView reloadData];
             }
    }];
}

@end
