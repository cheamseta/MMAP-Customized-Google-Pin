//
//  ViewController.m
//  LandDriller
//
//  Created by seta cheam on 4/5/17.
//  Copyright © 2017 seta cheam. All rights reserved.
//

#import "ViewController.h"
#import "NoteViewController.h"
#import "AddViewController.h"
#import "ListViewController.h"
#import "Services.h"
#import "DetailView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "StoryViewController.h"

@import GoogleMaps;

@interface ViewController ()<GMSMapViewDelegate, DetailDelegate>

@property (strong, nonatomic) UIView * mapHolderView;
@property (nonatomic, strong) GMSMapView * mapView;

@property (nonatomic, strong) UIButton * listButton;
@property (nonatomic, strong) UIButton * addButton;
@property (nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, strong) NSArray * provinceArray;
@property (nonatomic, strong) Services * theService;
@property (nonatomic, strong) NSArray * imageArray;
@property (nonatomic, strong) DetailView * detailView;
@property (nonatomic, strong) NSDictionary * selectedDict;

@property (strong, nonatomic) IBOutlet UIView *detailSubView;
@property (strong, nonatomic) IBOutlet UILabel *currentNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentAddressLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *currentImageScrollview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"Land Driller"];
    [self initialProject];
    
}

- (void)initialProject {
    
    self.theService = [[Services alloc] init];
    
    self.mapHolderView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.mapHolderView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.mapHolderView];

    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:11.57547578
                                             longitude:104.92689658
                                                  zoom:13];

    self.mapView = [GMSMapView mapWithFrame:self.mapHolderView.frame camera:camera];
    self.mapView.delegate = self;
    self.mapView.myLocationEnabled = NO;
    self.mapView.settings.compassButton = NO;
    self.mapView.settings.myLocationButton = NO;
    [self.mapHolderView addSubview:self.mapView];
    
    self.listButton = [[UIButton alloc] initWithFrame:CGRectMake([self ultiScreenWidth] - 80, [self ultiScreenHeight] - 80, 60, 60)];
    [self.listButton setImage:[UIImage imageNamed:@"List"] forState:UIControlStateNormal];
    [self.listButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.listButton addTarget:self action:@selector(showListAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mapHolderView addSubview:self.listButton];
    [self shadowButton:self.listButton];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 65, [self ultiScreenWidth], 50)];
    [self.scrollView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.8]];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.mapHolderView addSubview:self.scrollView];
    
    [self scrollViewLoop];
    
    [self.detailSubView setFrame:CGRectMake(0,  [self ultiScreenHeight] - 200, [self ultiScreenWidth], 200)];
    [self.detailSubView setHidden:YES];
    [self shadowButton:self.detailSubView];
    [self.view addSubview:self.detailSubView];

    
    NSArray * arr = @[
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

        for (NSDictionary * dict in arr){
            CGFloat lat = [dict[@"position"][0] floatValue];
            CGFloat lng = [dict[@"position"][1] floatValue];

            UIImageView * pinImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
            [pinImageView setImage:[UIImage imageNamed:@"Pin"]];
            
            UIImageView * theImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 3, 40, 40)];
            [theImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"mainPhoto"]] placeholderImage:[UIImage imageNamed:@"House"]];
            [theImageView.layer setCornerRadius:20];
            [theImageView setClipsToBounds:YES];
            [pinImageView addSubview:theImageView];
            
            CLLocationCoordinate2D position = CLLocationCoordinate2DMake(lat, lng);
            GMSMarker *marker = [GMSMarker markerWithPosition:position];
            marker.title = dict[@"name"];
            marker.iconView = pinImageView;
            marker.userData = dict;
            marker.map = self.mapView;
        }
    
}

- (void)scrollViewLoop {
    
    self.provinceArray = @[
                                @{
                                    @"name" : @"ភ្នំពេញ",
                                    @"position" : @[@11.5607474,@104.9089495]
                                    },
                                @{
                                    @"name" : @"កណ្តាល",
                                    @"position" : @[@11.4875682,@104.9421608]
                                    },
                                @{
                                    @"name" : @"កំពត",
                                    @"position" : @[@10.6094291,@104.1770572]
                                    },
                                @{
                                    @"name" : @"កំពង់ធំ",
                                    @"position" : @[@10.6094291,@104.1770572]
                                    },
                                @{
                                    @"name" : @"កំពង់ធំ",
                                    @"position" : @[@12.9639232,@104.4074259]
                                    },
                                @{
                                    @"name" : @"ព្រៃវែង",
                                    @"position" : @[@11.357393,@104.9098059]
                                    },
                                @{
                                    @"name" : @"កំពង់ចាម",
                                    @"position" : @[@11.9893534,@105.4004392]
                                    },
                                @{
                                    @"name" : @"កាកែវ",
                                    @"position" : @[@10.936398,@104.4884942]
                                    },
                                @{
                                    @"name" : @"សៀមរាប",
                                    @"position" : @[@13.364047, @103.860313]
                                    }
                                ];

    for (int i = 0 ; i < self.provinceArray.count; i ++ ){
        
        CGRect rectButton = CGRectZero;
        rectButton.origin.x = (105 * i ) + 5;
        rectButton.origin.y = 10;
        rectButton.size = CGSizeMake(100, 30);
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:rectButton];
        [titleLabel setBackgroundColor:[UIColor darkGrayColor]];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel.layer setCornerRadius:10];
        [titleLabel setClipsToBounds:YES];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setFont:[Services defaultFontInSize:12]];
        [titleLabel setText:self.provinceArray[i][@"name"]];
        [self.scrollView addSubview:titleLabel];
        
        UIButton * btn = [[UIButton alloc] initWithFrame:rectButton];
        [btn setTag:i];
        [btn addTarget:self action:@selector(showProvince:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btn];
        
    }
    
    [self.scrollView setContentSize:CGSizeMake((105 * self.provinceArray.count ) + 5, 50)];
    
}

- (void)showProvince:(UIButton *)sender {
    
    NSDictionary * dict = [self.provinceArray objectAtIndex:sender.tag];
    CGFloat lat = [dict[@"position"][0] floatValue];
    CGFloat lng = [dict[@"position"][1] floatValue];
    [self.mapView animateToLocation:CLLocationCoordinate2DMake(lat, lng)];
    [self.mapView animateToZoom:15];
    
}


- (void)showNote {
    
    NoteViewController * noteView = [[NoteViewController alloc] init];
    [self.navigationController pushViewController:noteView animated:YES];
    
}

- (void)showListAction:(id)sender {
    ListViewController * listView = [[ListViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:listView];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)showAddAction:(id)sender {
    AddViewController * addView = [[AddViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:addView];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position{
    if (self.listButton.alpha != 0){
        [UIView animateWithDuration:0.5 animations:^{
            [self.listButton setAlpha:0];
            [self.addButton setAlpha:0];
        }];
    }
}

- (void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position {
    [UIView animateWithDuration:0.5 animations:^{
        [self.listButton setAlpha:1];
        [self.addButton setAlpha:1];
    }];
}

- (void)mapView:(GMSMapView *)mapView didCloseInfoWindowOfMarker:(GMSMarker *)marker {
     [self.detailSubView setHidden:YES];
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    
    [self.detailSubView setHidden:NO];
    NSDictionary * dict = marker.userData;
    self.selectedDict = dict;

    [self.currentNameLabel setText:dict[@"name"]];
    [self.currentAddressLabel setText:dict[@"address"]];
    
    NSArray * imageArray = [dict objectForKey:@"photos"];
    self.imageArray = imageArray;
    
    CGFloat hieght = self.currentImageScrollview.frame.size.height;
    
    for (int i = 0 ; i < imageArray.count; i ++ ){
        
        CGRect rectButton = CGRectZero;
        rectButton.origin.x = ((hieght + 5) * i ) + 5;
        rectButton.origin.y = 0;
        rectButton.size = CGSizeMake(hieght, hieght);
        
        NSString * imgString = [imageArray objectAtIndex:i];
        
        UIImageView * img = [[UIImageView alloc] initWithFrame:rectButton];
        [img setContentMode:UIViewContentModeScaleAspectFill];
        [img setClipsToBounds:YES];
        [img.layer setCornerRadius:10];
        [img sd_setImageWithURL:[NSURL URLWithString:imgString]
               placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        [self.currentImageScrollview addSubview:img];
        
        UIButton * btn = [[UIButton alloc] initWithFrame:rectButton];
        [btn setTag:i];
        [btn addTarget:self action:@selector(showImageFullScreen:) forControlEvents:UIControlEventTouchUpInside];
        [self.currentImageScrollview addSubview:btn];
        
    }
    
    [self.currentImageScrollview setContentSize:CGSizeMake(((hieght + 5) * imageArray.count ) + 5, hieght)];
    
}

- (void)showDataAll {
    
}

- (void)showImageFullScreen:(UIButton *)sender {

    StoryViewController * story = [[StoryViewController alloc] init];
    [story setMainImageUrls:self.imageArray];
    [story setCurrentIndex:sender.tag];
    [self presentViewController:story animated:YES completion:nil];
    
}

- (BOOL)isAllowCurrentLocation {
    
    if (TARGET_IPHONE_SIMULATOR) {
        return NO;
    }else{
        if ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
            return NO;
        }else{
            return YES;
        }
    }
    
}

- (NSArray *)myCurrentLocation {
    if (TARGET_IPHONE_SIMULATOR) {
        return @[@11.57547578,@104.92689658];
    }else{
    return @[@11.57547578,@104.92689658];
    }
}

- (CGRect)ultiFullScreen {
    return [[UIScreen mainScreen] bounds];
}

- (CGFloat)ultiScreenWidth {
    return [[UIScreen mainScreen] bounds].size.width;
}

- (CGFloat)ultiScreenHeight {
    return [[UIScreen mainScreen] bounds].size.height;
}

- (UIFont *)fontInSize:(CGFloat)size {
    return [UIFont fontWithName:@"Avenir-Book" size:size];
}

- (void)shadowButton:(UIView *)btn {
    btn.layer.cornerRadius = 2;
    btn.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    btn.layer.shadowOffset = CGSizeMake(0.5, 4.0);
    btn.layer.shadowOpacity = 0.8;
    btn.layer.shadowRadius = 5.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)detailAction:(id)sender {

    self.detailView = [[DetailView alloc] initWithFrame:self.navigationController.view.frame withDict:self.selectedDict];
    [self.detailView setDelegate:self];
    [self.detailView setFrame:[UIScreen mainScreen].bounds];
    [self.navigationController.view addSubview:self.detailView];
    
}

- (void)viewStoryByImage:(NSArray *)image index:(NSInteger)i {
    StoryViewController * story = [[StoryViewController alloc] init];
    [story setMainImageUrls:image];
    [story setCurrentIndex:i];
    [self presentViewController:story animated:YES completion:nil];
}


@end
