//
//  MovieTableViewCell.h
//  Rotten Tomatoes
//
//  Created by Sarat Tallamraju on 2/6/15.
//  Copyright (c) 2015 Sarat Tallamraju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *movieTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *movieSynopsisLabel;
@property (strong, nonatomic) IBOutlet UIImageView *movieThumbnailImageView;

@end
