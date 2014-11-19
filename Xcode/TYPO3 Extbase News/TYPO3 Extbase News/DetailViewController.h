//
//  DetailViewController.h
//  TYPO3 Extbase News
//
//  Created by Dirk on 18.11.14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *headlineLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@property (weak,nonatomic) NSDictionary *rowcontent;

@end
