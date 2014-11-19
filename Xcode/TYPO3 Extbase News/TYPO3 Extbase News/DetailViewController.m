//
//  DetailViewController.m
//  TYPO3 Extbase News
//
//  Created by Dirk on 18.11.14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController

@synthesize imageView;
@synthesize headlineLabel;
@synthesize dateLabel;
@synthesize textLabel;


-(void)viewDidLoad{
    
    [super viewDidLoad];
    

    //Load Image asynchron
    self.imageView.image = [UIImage imageNamed:@"placeholder.png"];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSURL *url = [NSURL URLWithString:self.rowcontent[@"image"]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });
    });

    //InsertText
    self.headlineLabel.text = self.rowcontent[@"title"];
    self.headlineLabel.textColor = [UIColor colorWithRed:0 green:0.478 blue:1 alpha:1];
    self.dateLabel.text = self.rowcontent[@"date"];
    self.dateLabel.textColor = [UIColor grayColor];
    NSMutableString *textRaw;
    textRaw = [NSMutableString stringWithFormat:@"%@", self.rowcontent[@"text"]];
    textRaw = [[textRaw stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n\n"]mutableCopy];
    self.textLabel.text = textRaw;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}


@end
