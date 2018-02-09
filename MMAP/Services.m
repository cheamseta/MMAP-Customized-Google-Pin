//
//  Services.m
//  LandDriller
//
//  Created by seta cheam on 4/21/17.
//  Copyright © 2017 seta cheam. All rights reserved.
//

#import "Services.h"

@implementation Services

- (id)init{
    self = [super init];
    if(!self)return nil;
    managerHttp = [[httpManager alloc] init];
    return self;
}

+ (UIFont *)defaultFontInSize:(CGFloat)size {
    return [UIFont fontWithName:@"Timbre Kampuchea" size:size];
}

+ (NSURL *)imageSnapShotMapInLate:(CGFloat)latitute
                             Long:(CGFloat)longtitue
                        imageSize:(CGSize)size {
    
    NSString * urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/staticmap?center=%f,%f&zoom=15.5&scale=2&size=%.0fx%.0f&maptype=terrain&markers=%f,%f&sensor=true&style=feature:all&Celement:all&visual_refresh=true", latitute, longtitue, size.width, size.height, latitute, longtitue];
    
    return [NSURL URLWithString:urlString];
}

@end
