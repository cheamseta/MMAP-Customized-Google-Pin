//
//  DetailView.h
//  LandDriller
//
//  Created by seta cheam on 5/31/17.
//  Copyright © 2017 seta cheam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Services.h"
#import <SDWebImage/UIImageView+WebCache.h>

@protocol DetailDelegate <NSObject>

- (void)viewStoryByImage:(NSArray *)image index:(NSInteger)i;
@end

@interface DetailView : UIView

@property (weak, nonatomic) id<DetailDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UIImageView *mapImageView;
@property (strong, nonatomic) IBOutlet UIScrollView *photoScrollView;
@property (strong, nonatomic) IBOutlet UIView *noteView;
@property (strong, nonatomic) IBOutlet UITextView *noteTextView;

@property (strong, nonatomic) Services * theService;
@property (strong, nonatomic) NSArray * imageArray;
@property (strong, nonatomic) NSDictionary * dict;

- (instancetype)initWithFrame:(CGRect)frame withDict:(NSDictionary *)dict;


@end
