//
//  WXSGithubNetWork.h
//  GithubDemo
//
//  Created by AlanWang on 17/3/1.
//  Copyright © 2017年 AlanWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RepoModel;

@interface WXSGithubNetWork : NSObject


+ (void)searchUserDataWithKeyStr:(NSString *)keyStr andPageCount:(int32_t)pageCount Commpletion:(void (^)(NSArray<RepoModel *> *items))completion;


@end
