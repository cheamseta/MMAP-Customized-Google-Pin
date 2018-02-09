//
//  StoryViewController.h
//  Lindana
//
//  Created by seta cheam on 4/13/17.
//  Copyright © 2017 seta cheam. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StoryDelegate <NSObject>

- (void)didRefreshStory;

@end

@interface StoryViewController : UIViewController

@property (weak, nonatomic) id<StoryDelegate> delegate;

@property (strong, nonatomic) NSArray * mainImageUrls;
@property (nonatomic) NSInteger  currentIndex;


@end
