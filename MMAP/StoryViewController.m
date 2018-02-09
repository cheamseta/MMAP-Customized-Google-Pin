//
//  StoryViewController.m
//  Lindana
//
//  Created by seta cheam on 4/13/17.
//  Copyright © 2017 seta cheam. All rights reserved.
//

#import "StoryViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface StoryViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *mainImageView;
@property (strong, nonatomic) UILongPressGestureRecognizer *longHoldGuesture;


@end

@implementation StoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:self.mainImageUrls[self.currentIndex]]
                          placeholderImage:[UIImage imageNamed:@"ImagePlaceholder"]];

    UISwipeGestureRecognizer * swip = [[UISwipeGestureRecognizer alloc] init];
    [swip setDirection:UISwipeGestureRecognizerDirectionDown];
    [swip addTarget:self action:@selector(swipeToDismiss)];
    [self.view addGestureRecognizer:swip];
    
    UISwipeGestureRecognizer * swipLeft = [[UISwipeGestureRecognizer alloc] init];
    [swipLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipLeft addTarget:self action:@selector(swipeToLeft)];
    [self.view addGestureRecognizer:swipLeft];
    
    UISwipeGestureRecognizer * swipRight = [[UISwipeGestureRecognizer alloc] init];
    [swipRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [swipRight addTarget:self action:@selector(swipeToRight)];
    [self.view addGestureRecognizer:swipRight];
    
}

- (void)swipeToRight {
    
    NSInteger index = self.currentIndex - 1;
    
    if (index >=  0 ){
        
        [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:self.mainImageUrls[index]]
                              placeholderImage:[UIImage imageNamed:@"ImagePlaceholder"]];
        
        CATransition *transition = [CATransition animation];
        transition.duration = 0.4f;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
        
        [self.mainImageView.layer addAnimation:transition forKey:nil];
        
        self.currentIndex = index;
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)swipeToLeft {
    
    NSInteger index = self.currentIndex + 1;
    
    if (index <  self.mainImageUrls.count){
        

        [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:self.mainImageUrls[index]]
                              placeholderImage:[UIImage imageNamed:@"ImagePlaceholder"]];
        
        CATransition *transition = [CATransition animation];
        transition.duration = 0.4f;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
        
        [self.mainImageView.layer addAnimation:transition forKey:nil];

        self.currentIndex = index;
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (void)swipeToDismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
