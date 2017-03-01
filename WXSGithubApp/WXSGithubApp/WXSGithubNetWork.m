//
//  WXSGithubNetWork.m
//  GithubDemo
//
//  Created by AlanWang on 17/3/1.
//  Copyright © 2017年 AlanWang. All rights reserved.
//

#import "WXSGithubNetWork.h"
#import "RepoModel.h"

NSString *const k_repos_search_url = @"https://api.github.com/search/repositories";
NSString *const k_q = @"q";
NSString *const k_page = @"page";
NSString *const k_per_page = @"per_page";
NSString *const k_sort = @"sort";
NSString *const k_order = @"order";


@implementation WXSGithubNetWork



+ (void)searchUserDataWithKeyStr:(NSString *)keyStr andPageCount:(int32_t)pageCount Commpletion:(void (^)(NSArray<RepoModel *> *items))completion {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //GET
        NSString *urlStr = [NSString stringWithFormat:@"%@?%@=%@&%@=%@&per_page=20",k_repos_search_url,k_q,keyStr,k_page,@(pageCount).stringValue];
        NSURL *url = [NSURL URLWithString:urlStr];
        NSData *jsonData = [NSData dataWithContentsOfURL:url];
        
        //resolve
        if (!jsonData) {
            completion(nil);
            return ;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
        
            if (jsonData) {
                NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
                if ([resultDic objectForKey:@"items"]) {
                    NSArray *dicts = [resultDic objectForKey:@"items"];
                    NSMutableArray *tempArr = [NSMutableArray new];
                    for (NSDictionary *tempDict in dicts) {
                        RepoModel *model = [[RepoModel alloc] initWithDict:tempDict];
                        if (![tempArr containsObject:model]) {
                            [tempArr addObject:model];
                        }
                        NSLog(@"---- %@----%@",model.owner.login,model.name);

                    }
                    completion([tempArr copy]);
                }else {
                    completion(@[]);
                }
                
                
            }
        });
        
    });
}



@end
