//
//  RepoModel.h
//  GithubDemo
//
//  Created by AlanWang on 17/3/1.
//  Copyright © 2017年 AlanWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic,copy) NSString                 *avatar_url;
@property (nonatomic,copy) NSString                 *login;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end

@interface RepoModel : NSObject

@property (nonatomic, copy) NSString                *name;
@property (nonatomic, strong) UserModel             *owner;
@property (nonatomic, copy) NSString                *id;
@property (nonatomic, copy) NSString                *forks_count;
@property (nonatomic, copy) NSString                *stargazers_count;
@property (nonatomic, copy) NSString                *watchers_count;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
