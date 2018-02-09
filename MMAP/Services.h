//
//  Services.h
//  LandDriller
//
//  Created by seta cheam on 4/21/17.
//  Copyright © 2017 seta cheam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "httpManager.h"

@interface Services : NSObject { httpManager *managerHttp; }

+ (UIFont *)defaultFontInSize:(CGFloat)size;
+ (NSURL *)imageSnapShotMapInLate:(CGFloat)latitute
                             Long:(CGFloat)longtitue
                        imageSize:(CGSize)size;

@end
