//
//  TableViewController.h
//  TYPO3 Extbase News
//
//  Created by Dirk on 18.11.14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface TableViewController : UITableViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mytableview;

- (void)start;
- (void)getData: (NSData *)jsonSource;
- (void)refreshView: (UIRefreshControl *)refresh;

@end
