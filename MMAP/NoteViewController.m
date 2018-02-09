//
//  NoteViewController.m
//  LandDriller
//
//  Created by seta cheam on 4/6/17.
//  Copyright © 2017 seta cheam. All rights reserved.
//

#import "NoteViewController.h"

@interface NoteViewController ()
@property (strong, nonatomic) IBOutlet UIView *inputView;

@end

@implementation NoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"កត់សំគាល់"];

    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithTitle:@"បង្កើត"
                                                                 style:UIBarButtonItemStyleDone
                                                                target:self
                                                                action:@selector(showCreate)];
    [self.navigationItem setRightBarButtonItem:barItem];

}

- (void)showCreate {
    
    if (self.inputView.isHidden){
        [self.inputView setHidden:NO];
        [self.inputView setAlpha:0];
        [UIView animateWithDuration:0.4 animations:^{
            [self.inputView setAlpha:1];
        }];
    }else{
        [UIView animateWithDuration:0.4 animations:^{
            [self.inputView setAlpha:0];
        } completion:^(BOOL finished) {
              [self.inputView setHidden:YES];
        }];
    }
    
}

- (IBAction)cancelAction:(id)sender {
}

- (IBAction)okAction:(id)sender {
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
