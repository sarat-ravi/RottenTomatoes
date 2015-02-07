//
//  MovieDetailViewController.h
//  Rotten Tomatoes
//
//  Created by Sarat Tallamraju on 2/6/15.
//  Copyright (c) 2015 Sarat Tallamraju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *moviePosterImageView;
@property (strong, nonatomic) NSDictionary *movieData;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *movieSynopsisLabel;

@end
