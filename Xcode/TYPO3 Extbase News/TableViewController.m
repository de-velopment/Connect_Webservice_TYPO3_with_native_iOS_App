//
//  TableViewController.m
//  TYPO3 Extbase News
//
//  Created by Dirk on 18.11.14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import "TableViewController.h"
#import "DetailViewController.h"

//Important 
//Insert here your json File URL "www.yourdomain.com/pathToJson"
#define jsonUrl @"http://"

@interface TableViewController(){
    

    NSMutableArray *arrayData;
    NSMutableDictionary *myDictionary;
    NSString *newsHeadline;
    NSString *newsDate;
    NSString *newsText;
    NSString *newsImage;
    UIImageView *test;

}

@end

@implementation TableViewController
@synthesize mytableview;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self start];
    
    //Refresh
    UIRefreshControl * refresh = [[UIRefreshControl alloc] init];
    NSAttributedString *loadtext = [[NSAttributedString alloc] initWithString:@"aktualisieren" attributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithAttributedString:loadtext];
    
    refresh.backgroundColor = [UIColor colorWithRed:0 green:0.478 blue:1 alpha:1];
    refresh.tintColor = [UIColor whiteColor];
    
    
    
    [refresh addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    self.title = @"TYPO3 Extbase";
    
    
}

- (void)start
{
    NSData *jsonSource = [NSData dataWithContentsOfURL:[NSURL URLWithString:jsonUrl]];
    
    [self getData:jsonSource];
    
}



- (void)getData:(NSData *)jsonSource
{
 
    
    newsHeadline = @"title";
    newsDate = @"date";
    newsText = @"text";
    newsImage = @"image";
    
 
    
    arrayData = [[NSMutableArray alloc]init];
    
    id jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonSource options:NSJSONReadingMutableContainers error:nil];
    
    for(NSMutableDictionary *data in jsonObjects){
        
        NSString *headline_value = [data objectForKey:@"title"];
        NSString *newsDate_value = [data objectForKey:@"date"];
        NSString *newsText_value = [data objectForKey:@"text"];
        NSString *newsImage_value = [data objectForKey:@"image"];
        
    
        
        myDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                        headline_value , newsHeadline,
                        newsDate_value, newsDate,
                        newsText_value , newsText,
                        newsImage_value, newsImage
                        , nil];
        
        [arrayData addObject:myDictionary];
        
      }
    

        
       [mytableview reloadData];
   
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableIdentifier];
    
    if(cell == nil){
        cell=[[UITableViewCell alloc]initWithStyle:
              UITableViewCellStyleDefault reuseIdentifier:TableIdentifier];
        
    }
   tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tableView.estimatedRowHeight = 54.0;
    tableView.rowHeight = UITableViewAutomaticDimension;
    
    NSDictionary *tmpDict = [arrayData objectAtIndex:indexPath.row];
    

    
    
    NSMutableString *cellHeadline;
    cellHeadline = [NSMutableString stringWithFormat:@"%@",
                [tmpDict objectForKeyedSubscript:newsHeadline]];
    
    NSMutableString *cellDate;
    cellDate = [NSMutableString stringWithFormat:@"%@",
                    [tmpDict objectForKeyedSubscript:newsDate]];
    
//Insert Image
    
    UIImage *image = [UIImage imageNamed:@"placeholder.png"];
    CGSize itemSize = CGSizeMake(40, 40);
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSURL *url = [NSURL URLWithString:[tmpDict objectForKey:newsImage]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{

            CGSize itemSize = CGSizeMake(40, 40);
            UIGraphicsBeginImageContext(itemSize);
            CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
            [image drawInRect:imageRect];
            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        });
    });
    
    
    //Insert text
    cell.textLabel.text = cellHeadline;
    cell.textLabel.textColor = [UIColor colorWithRed:0 green:0.478 blue:1 alpha:1];
    cell.detailTextLabel.text = cellDate;
    cell.detailTextLabel.numberOfLines = 1;
    cell.detailTextLabel.textColor = [UIColor grayColor];
    //adding Arrow
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([segue.identifier isEqualToString:@"detailviewsegue"])
    {
        
        NSIndexPath *indexpath = nil;
        
        indexpath = [mytableview indexPathForSelectedRow];
        
        NSDictionary *rowdict = [arrayData objectAtIndex:indexpath.row];
    
        [[segue destinationViewController] setRowcontent:rowdict];
        
        
    }
    
}

- (void)refreshView:(UIRefreshControl *)refresh{
    
    refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"Tabelle wird aktualisiert"];
    //NSLog(@"Refresh");
    [self start];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@" dd.MM.YYYY, HH:MM"];
    
    NSString *lastUpdate = [NSString stringWithFormat:@"aktualisiert am %@ Uhr", [formatter stringFromDate:[NSDate date]]];
    NSAttributedString *lastUpdateText = [[NSAttributedString alloc] initWithString:lastUpdate attributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    refresh.attributedTitle = [[NSAttributedString alloc] initWithAttributedString:lastUpdateText];
    [refresh endRefreshing];
    
}



- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    
}




@end
