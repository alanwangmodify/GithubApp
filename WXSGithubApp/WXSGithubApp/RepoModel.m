//
//  RepoModel.m
//  GithubDemo
//
//  Created by AlanWang on 17/3/1.
//  Copyright © 2017年 AlanWang. All rights reserved.
//

#import "RepoModel.h"

@implementation UserModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.avatar_url = dict[@"avatar_url"];
        self.login = dict[@"login"];
        
    }
    return self;
}



@end


@implementation RepoModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        if (dict[@"owner"] && ![dict[@"owner"] isKindOfClass:[NSNull class]] ) {
            self.owner = [[UserModel alloc] initWithDict:dict[@"owner"]];
        }
        self.name = dict[@"name"];
        self.stargazers_count = dict[@"stargazers_count"];
        self.watchers_count = dict[@"watchers_count"];
        self.forks_count = dict[@"forks_count"];
    }
    return self;
}

@end
