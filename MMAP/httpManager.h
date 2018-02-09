//
//  httpManager.h
//  VRecommend
//
//  Created by cheamseta on 6/26/14.
//  Copyright (c) 2014 cheamseta. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface httpManager : AFHTTPSessionManager

- (void)GetHttpWithUrl:(NSString *)url
           andComplete:(void(^)(id object, NSError * error))complete;


- (void)PostHttpWithUrl:(NSString *)url param:(NSDictionary *)dict
            andComplete:(void(^)(id object, NSError * error))complete;

@end
