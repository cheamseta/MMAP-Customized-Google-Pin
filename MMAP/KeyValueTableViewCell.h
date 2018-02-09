//
//  KeyValueTableViewCell.h
//  GoOutTe
//
//  Created by seta cheam on 9/5/16.
//  Copyright © 2016 seta cheam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyValueTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *keyLabel;
@property (strong, nonatomic) IBOutlet UITextField *valueTextField;
@property (strong, nonatomic) IBOutlet UILabel *isRequireLabel;

@end
