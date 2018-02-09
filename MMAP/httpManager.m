//
//  httpManager.m
//  VRecommend
//
//  Created by cheamseta on 6/26/14.
//  Copyright (c) 2014 cheamseta. All rights reserved.
//

#import "httpManager.h"

@interface httpManager()

@end

@implementation httpManager

#pragma mark - GET HTTP --

- (void)GetHttpWithUrl:(NSString *)url
           andComplete:(void(^)(id object, NSError * error))complete {
  
  [self GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
    complete(responseObject, nil);
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    complete(nil, error);
  }];

}

- (void)PostHttpWithUrl:(NSString *)url param:(NSDictionary *)dict
           andComplete:(void(^)(id object, NSError * error))complete {
    
    [self POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        complete(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(nil, error);
    }];
    
}




@end
