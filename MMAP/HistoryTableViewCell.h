//
//  HistoryTableViewCell.h
//  LandDriller
//
//  Created by seta cheam on 4/25/17.
//  Copyright © 2017 seta cheam. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HistoryDelegate <NSObject>

- (void)onPdfAction:(NSString *)url;

@end

@interface HistoryTableViewCell : UITableViewCell

@property (weak, nonatomic) id<HistoryDelegate> delegate;
@property (strong, nonatomic) NSString *urlString;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *mainImageView;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

@end
