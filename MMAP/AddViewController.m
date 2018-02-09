//
//  AddViewController.m
//  LandDriller
//
//  Created by seta cheam on 4/6/17.
//  Copyright © 2017 seta cheam. All rights reserved.
//

#import "AddViewController.h"
#import "KeyValueTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Services.h"

@interface AddViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *addTableView;
@property (strong, nonatomic) IBOutlet UIView *tableHeaderView;
@property (strong, nonatomic) IBOutlet UIView *tableFooter;

@property (strong, nonatomic) NSArray * rowArray;
@property (strong, nonatomic) NSArray * imageArray;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"Add New"];
    [self.addTableView setTableHeaderView:self.tableHeaderView];
    [self.addTableView setTableFooterView:self.tableFooter];
    
    self.rowArray = @[
                      @{
                          @"key" : @"ឈ្មោះទីកន្លែង"
                          },
                      @{
                          @"key" : @"ចំណុចនៃផែនទី"
                          },
                      @{
                          @"key" : @"អាស័យដ្ថាន"
                          }
                      ];
    
    [self.addTableView registerNib:[UINib nibWithNibName:@"KeyValueTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.addTableView setDelegate:self];
    [self.addTableView setDataSource:self];
    
    
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Close"] style:UIBarButtonItemStyleDone target:self action:@selector(closeAction)];
    [self.navigationItem setLeftBarButtonItem:barItem];
    
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0){
        return @"";
    }else{
        return @"រូបភាព";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0){
        return self.rowArray.count;
    }else{
        return self.imageArray.count + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0){
        KeyValueTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        NSDictionary * dict = [self.rowArray objectAtIndex:indexPath.row];
        [cell.keyLabel setText:dict[@"key"]];
        
            return cell;
    }else{
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@""];
        
        if (!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellImg"];
        }
        
        if (indexPath.row == 0){
            [cell.textLabel setText:@"បញ្ចូលរូបភាព"];
            [cell.textLabel setFont:[Services defaultFontInSize:15]];
            [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
            [cell.imageView setImage:nil];
        }else{
            
            NSString * img = [self.imageArray objectAtIndex:indexPath.row - 1];
            
            [cell.textLabel setText:[NSString stringWithFormat:@"រូបភាព %ld", (long)indexPath.row]];
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:img]
                         placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        }
     
            return cell;
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)closeAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
