//
//  WebViewController.m
//  LandDriller
//
//  Created by seta cheam on 5/31/17.
//  Copyright © 2017 seta cheam. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *theWebView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *active;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL* url = [NSURL URLWithString:self.url];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.theWebView setDelegate:self];
    [self.theWebView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    [self.active setHidden:NO];
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.active setHidden:NO];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
     [self.active setHidden:YES];
}



@end
