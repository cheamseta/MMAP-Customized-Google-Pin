//
//  DetailView.m
//  LandDriller
//
//  Created by seta cheam on 5/31/17.
//  Copyright © 2017 seta cheam. All rights reserved.
//

#import "DetailView.h"
#import "StoryViewController.h"

@implementation DetailView

- (instancetype)initWithFrame:(CGRect)frame withDict:(NSDictionary *)dict{
    self = [super initWithFrame:frame];
    if (self){
        self = [[[NSBundle mainBundle] loadNibNamed:@"DetailView"
                                              owner:self
                                            options:nil] lastObject];
        [self setFrame:frame];
        [self onLoadDetailView:dict];
        
        self.dict = dict;
        
        self.noteTextView.layer.shadowColor = [UIColor blackColor].CGColor;
        self.noteTextView.layer.shadowOpacity = 1;
        self.noteTextView.layer.shadowRadius = 1.0;
        
    }
    return self;
}

- (void)onLoadDetailView:(NSDictionary *)dict {
    [self.nameLabel setText:dict[@"name"]];
    [self.addressLabel setText:dict[@"address"]];
    [self.noteTextView setText:dict[@"note"]];
    [self.noteView setHidden:YES];
    [self setAlpha:0];
    [UIView animateWithDuration:0.5 animations:^{
        [self setAlpha:1];
    } completion:^(BOOL finished) {
        
        
        [self.mapImageView sd_setImageWithURL:[Services imageSnapShotMapInLate:[dict[@"position"][0] floatValue] Long:[dict[@"position"][1] floatValue] imageSize:self.mapImageView.frame.size]];
        
        NSArray * imageArray = [dict objectForKey:@"photos"];
        self.imageArray = imageArray;
        
        CGFloat hieght = self.photoScrollView.frame.size.height;
        CGFloat width = self.photoScrollView.frame.size.width;
        
        for (int i = 0 ; i < imageArray.count; i ++ ){
            
            CGRect rectButton = CGRectZero;
            rectButton.origin.x = (width * i );
            rectButton.origin.y = 0;
            rectButton.size = CGSizeMake(width, hieght);
            
            NSString * imgString = [imageArray objectAtIndex:i];
            
            UIImageView * img = [[UIImageView alloc] initWithFrame:rectButton];
            [img setContentMode:UIViewContentModeScaleAspectFill];
            [img setClipsToBounds:YES];
            [img sd_setImageWithURL:[NSURL URLWithString:imgString]
                   placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
            [self.photoScrollView addSubview:img];
            
            UIButton * btn = [[UIButton alloc] initWithFrame:rectButton];
            [btn setTag:i];
            [btn addTarget:self action:@selector(showImageFullScreen:) forControlEvents:UIControlEventTouchUpInside];
            [self.photoScrollView addSubview:btn];
            
        }
        
        [self.photoScrollView setContentSize:CGSizeMake((width * imageArray.count ), hieght)];
        
        [self.noteView setHidden:NO];
        [self.noteView setFrame:CGRectMake(0, self.frame.size.height - 100, self.frame.size.width, self.frame.size.height)];
        
    }];
    
    
}

- (IBAction)dimissMapDetailView:(id)sender {
    
    [UIView animateWithDuration:0.5 animations:^{
        [self setAlpha:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    
}

- (void)showImageFullScreen:(UIButton *)sender {
    [self.delegate viewStoryByImage:self.imageArray index:sender.tag];
}


- (IBAction)viewOnMap:(id)sender {
    NSString* directionsURL = [NSString stringWithFormat:@"http://maps.apple.com/?saddr=%f,%f&daddr=%f,%f",[self.dict[@"position"][0] floatValue], [self.dict[@"position"][1] floatValue], [self.dict[@"position"][0] floatValue], [self.dict[@"position"][1] floatValue]];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: directionsURL]];
}

- (IBAction)onViewNote:(id)sender {
    
    if (self.noteView.frame.origin.y != 0){
        [UIView animateWithDuration:0.5 animations:^{
            [self.noteView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            [self.noteView setFrame:CGRectMake(0, self.frame.size.height - 100, self.frame.size.width, self.frame.size.height)];
        }];
        
    }
    
    
}

@end
