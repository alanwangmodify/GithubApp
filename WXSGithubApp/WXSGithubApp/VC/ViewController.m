//
//  ViewController.m
//  WXSGithubApp
//
//  Created by 王小树 on 17/3/1.
//  Copyright © 2017年 王小树. All rights reserved.
//

#import "ViewController.h"
#import "SearchViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *searchBtn = [[UIButton alloc] init];
    [searchBtn addTarget:self action:@selector(toSearch) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.frame = CGRectMake(100, 100, 200, 40);
    searchBtn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:searchBtn];
    
}
- (void)toSearch {
    
    
    SearchViewController *vc = [[SearchViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:^{
    }];
}
@end
