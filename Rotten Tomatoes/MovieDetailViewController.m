//
//  MovieDetailViewController.m
//  Rotten Tomatoes
//
//  Created by Sarat Tallamraju on 2/6/15.
//  Copyright (c) 2015 Sarat Tallamraju. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailViewController ()

@end

@implementation MovieDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set title
    NSString *movieTitle = self.movieData[@"title"];
    [self.navigationItem setTitle: movieTitle];
    
    // Set image
    NSString *posterUrlString = self.movieData[@"posters"][@"detailed"];
    posterUrlString = [posterUrlString stringByReplacingOccurrencesOfString: @"tmb" withString:@"ori"];
    NSURL *posterUrl = [NSURL URLWithString: posterUrlString];
    [self.moviePosterImageView setImageWithURL: posterUrl];
    
    // Set synopsis
    NSInteger y = 20;
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenFrame.size.width;
    
    NSInteger labelWidth = screenWidth - 40;
    CGRect frame = CGRectMake(20, y, labelWidth, 10);
    
    self.movieSynopsisLabel = [[UILabel alloc] initWithFrame:frame];
    self.movieSynopsisLabel.text = self.movieData[@"synopsis"];
    self.movieSynopsisLabel.numberOfLines = 0;
    self.movieSynopsisLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self.movieSynopsisLabel sizeToFit];
    frame.size.height = self.movieSynopsisLabel.frame.size.height;
    self.movieSynopsisLabel.frame = CGRectMake(20, y, labelWidth, self.movieSynopsisLabel.frame.size.height);
    
    CGRect viewFrame = CGRectMake(0, y - 100, screenWidth, frame.size.height + 500);
    UIView *view = [[UIView alloc] initWithFrame: viewFrame];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[[UIColor colorWithWhite: 0.0 alpha:0.0] CGColor],
                       (id)[[UIColor colorWithWhite: 0.0 alpha:0.8] CGColor], nil];
    gradient.startPoint = CGPointMake(0.5, 0.0); // default; bottom of the view
    gradient.endPoint = CGPointMake(0.5, 0.15);   // default; top of the view
    [view.layer insertSublayer:gradient atIndex:0];
    
    
    
    
    [self.scrollView addSubview: view];
    [self.scrollView addSubview: self.movieSynopsisLabel];
    CGSize contentSize = CGSizeMake(screenWidth, self.movieSynopsisLabel.frame.size.height);
    
    self.scrollView.contentSize = contentSize;
    self.scrollView.contentInset=UIEdgeInsetsMake(400,0.0,50.0,0.0);
    
    
    [self.scrollView setContentOffset: CGPointMake(0, -self.scrollView.contentInset.top) animated:YES];
    // CGPoint bottomOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height);
    // [self.scrollView setContentOffset:bottomOffset animated:YES];
}

- (void)oldViewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Set title
    NSString *movieTitle = self.movieData[@"title"];
    [self.navigationItem setTitle: movieTitle];
    
    // Set image
    NSString *posterUrlString = self.movieData[@"posters"][@"detailed"];
    posterUrlString = [posterUrlString stringByReplacingOccurrencesOfString: @"tmb" withString:@"ori"];
    NSURL *posterUrl = [NSURL URLWithString: posterUrlString];
    [self.moviePosterImageView setImageWithURL: posterUrl];
    
    // self.movieSynopsisLabel.text = self.movieData[@"synopsis"];
    self.movieSynopsisLabel.text = [NSString stringWithFormat: @"%@", self.movieData[@"synopsis"]];
    [self.movieSynopsisLabel sizeToFit];
    CGRect frame = self.movieSynopsisLabel.frame;
    CGFloat y = 400;
    frame = CGRectMake(20, y, 280, frame.size.height + 40);
    self.movieSynopsisLabel.frame = frame;
    self.movieSynopsisLabel.textAlignment = NSTextAlignmentJustified;
    
    UIView *view = [[UIView alloc] initWithFrame: CGRectMake(0, 300, 320, frame.size.height + 500)];
    // [view setBackgroundColor: [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75]];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[[UIColor colorWithWhite: 0.0 alpha:0.0] CGColor],
                       (id)[[UIColor colorWithWhite: 0.0 alpha:0.8] CGColor], nil];
    gradient.startPoint = CGPointMake(0.5, 0.0); // default; bottom of the view
    gradient.endPoint = CGPointMake(0.5, 0.15);   // default; top of the view
    [view.layer insertSublayer:gradient atIndex:0];
    
    
    NSLog(@"height of the label: %f", self.movieSynopsisLabel.frame.size.height);
    [self.scrollView setContentSize: CGSizeMake(320, self.movieSynopsisLabel.frame.size.height + y + 40)];
    // [self.scrollView addSubview: self.movieSynopsisLabel];
    
    // self.scrollView.contentInset=UIEdgeInsetsMake(400,0.0,50.0,0.0);
    
    // self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.scrollView setScrollEnabled: YES];
    [self.scrollView addSubview: view];
    [self.scrollView addSubview: self.movieSynopsisLabel];
    
}

@end
