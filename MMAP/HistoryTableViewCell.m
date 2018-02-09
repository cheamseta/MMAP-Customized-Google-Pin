//
//  HistoryTableViewCell.m
//  LandDriller
//
//  Created by seta cheam on 4/25/17.
//  Copyright © 2017 seta cheam. All rights reserved.
//

#import "HistoryTableViewCell.h"

@implementation HistoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    [self.mainImageView.layer setCornerRadius:40];
    [self.mainImageView setClipsToBounds:YES];
}

- (IBAction)pdfAction:(id)sender {
    [self.delegate onPdfAction:self.urlString];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
