//
//  ListViewController.m
//  LandDriller
//
//  Created by seta cheam on 4/6/17.
//  Copyright © 2017 seta cheam. All rights reserved.
//

#import "ListViewController.h"
#import "Services.h"
#import "HistoryTableViewCell.h"
#import "DetailView.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import "StoryViewController.h"
#import "WebViewController.h"

@interface ListViewController ()<UITableViewDelegate, UITableViewDataSource, HistoryDelegate, DetailDelegate>

@property (strong, nonatomic) Services * theService;
@property (strong, nonatomic) NSArray * historyArray;
@property (strong, nonatomic) DetailView * detailView;

@property (strong, nonatomic) IBOutlet UITableView *historyTableView;


@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationItem setTitle:@"បញ្ចី"];
    
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Close"] style:UIBarButtonItemStyleDone target:self action:@selector(closeAction)];
    [self.navigationItem setLeftBarButtonItem:barItem];
    
    [self retrieveData];
    
    [self.historyTableView setDelegate:self];
    [self.historyTableView setDataSource:self];
    [self.historyTableView registerNib:[UINib nibWithNibName:@"HistoryTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}

- (void)retrieveData {
    
    self.historyArray = @[
                      @{
                          @"name" : @"sample one",
                          @"position" : @[@11.5732817,@104.9190167],
                          @"mainPhoto" : @"https://cdn2.iconfinder.com/data/icons/humano2/128x128/actions/go-home.png",
                          @"address" : @"phnom penh cambodia",
                          @"note" : @"Hello every one here",
                          @"photos" : @[
                                  @"https://www.100resilientcities.org/wp-content/uploads/2017/06/cities-bangkok_optimized-450x300.jpg",
                                  @"https://www.100resilientcities.org/wp-content/uploads/2017/06/cities-bangkok_optimized-450x300.jpg",
                                  @"https://www.100resilientcities.org/wp-content/uploads/2017/06/cities-bangkok_optimized-450x300.jpg"
                                  ]
                          },
                      @{
                          @"name" : @"sample two",
                          @"position" : @[@11.5932417,@104.9190167],
                          @"mainPhoto" : @"https://cdn2.iconfinder.com/data/icons/humano2/128x128/actions/go-home.png",
                          @"address" : @"phnom penh cambodia",
                          @"note" : @"Hello every one here",
                          @"photos" : @[
                                  @"https://www.100resilientcities.org/wp-content/uploads/2017/06/cities-bangkok_optimized-450x300.jpg",
                                  @"https://www.100resilientcities.org/wp-content/uploads/2017/06/cities-bangkok_optimized-450x300.jpg",
                                  @"https://www.100resilientcities.org/wp-content/uploads/2017/06/cities-bangkok_optimized-450x300.jpg"
                                  ]
                          
                          },
                      @{
                          @"name" : @"sample tow",
                          @"position" : @[@11.5232517,@104.9190167],
                          @"mainPhoto" : @"https://cdn2.iconfinder.com/data/icons/humano2/128x128/actions/go-home.png",
                          @"address" : @"phnom penh cambodia",
                          @"note" : @"Hello every one here",
                          @"photos" : @[
                                  @"https://www.100resilientcities.org/wp-content/uploads/2017/06/cities-bangkok_optimized-450x300.jpg",
                                  @"https://www.100resilientcities.org/wp-content/uploads/2017/06/cities-bangkok_optimized-450x300.jpg",
                                  @"https://www.100resilientcities.org/wp-content/uploads/2017/06/cities-bangkok_optimized-450x300.jpg"
                                  ]
                          }
                      ];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)closeAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewStoryByImage:(NSArray *)image index:(NSInteger)i {
    StoryViewController * story = [[StoryViewController alloc] init];
    [story setMainImageUrls:image];
    [story setCurrentIndex:i];
    [self presentViewController:story animated:YES completion:nil];
}

#pragma mark - table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.historyArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary * dict = [self.historyArray objectAtIndex:indexPath.row];
    self.detailView = [[DetailView alloc] initWithFrame:self.navigationController.view.frame withDict:dict];
    [self.detailView setDelegate:self];
    [self.detailView setFrame:[UIScreen mainScreen].bounds];
    [self.navigationController.view addSubview:self.detailView];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 101;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HistoryTableViewCell * cell = [self.historyTableView dequeueReusableCellWithIdentifier:@"cell"];
 
    NSDictionary * dict =[self.historyArray objectAtIndex:indexPath.row];
    
    [cell.nameLabel setText:dict[@"name"]];
    [cell.addressLabel setText:dict[@"address"]];
    cell.urlString = dict[@"file"];
    [cell.mainImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"mainPhoto"]] placeholderImage:[UIImage imageNamed:@"House"]];
    
    if (!cell.delegate){
        cell.delegate = self;
    }

    return cell;
}

- (void)onPdfAction:(NSString *)url {
    [self onDocOpen:url];
}

- (void)onDocOpen:(NSString *)url {
    
    WebViewController * web = [[WebViewController alloc] init];
    [web setUrl:url];
    [self presentViewController:web animated:YES completion:nil];
    
}

@end
