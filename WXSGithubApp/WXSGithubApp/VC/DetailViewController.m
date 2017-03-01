//
//  DetailViewController.m
//  WXSGithubApp
//
//  Created by 王小树 on 17/3/1.
//  Copyright © 2017年 王小树. All rights reserved.
//

#import "DetailViewController.h"
#import "RepoModel.h"

@interface DetailViewController ()


@end

@implementation DetailViewController

- (instancetype)initWithRepoModel:(RepoModel *)repoModel {
    self = [super init];
    if (self) {
        self.repoModel = repoModel;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupView];
}

#pragma mak - View
- (void)setupView {
    [self.view addSubview:self.ownerAvatar];
    [self.view addSubview:self.ownerLab];
    [self.view addSubview:self.repoNameLab];
    
    
    self.ownerAvatar.frame = CGRectMake(0, 0, 40, 40);
    self.ownerAvatar.center = CGPointMake(self.view.center.x, 100);
    
    self.repoNameLab.frame = CGRectMake(0, 0, self.view.bounds.size.width, 20);
    self.repoNameLab.center = CGPointMake(self.view.center.x, CGRectGetMaxY(self.ownerAvatar.frame)+ 20);
    
    self.ownerLab.frame = CGRectMake(0, 0, self.view.bounds.size.width, 40);
    self.ownerLab.center = CGPointMake(self.view.center.x, CGRectGetMaxY(self.repoNameLab.frame)+ 20);
     
}

#pragma mark - Setter
- (void)setRepoModel:(RepoModel *)repoModel {
    _repoModel = repoModel;
    
    //avatar
    NSData *loacalData = [[NSUserDefaults standardUserDefaults] objectForKey:repoModel.owner.avatar_url];
    if (loacalData) {
        UIImage *localImg = [UIImage imageWithData:loacalData];
        self.ownerAvatar.image = localImg;
    }else{
        self.ownerAvatar.image = nil;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:repoModel.owner.avatar_url]];
            UIImage *img = [UIImage imageWithData:data];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.ownerAvatar.image = img;
                
                [[NSUserDefaults standardUserDefaults] setObject:data forKey:repoModel.owner.avatar_url];
                [[NSUserDefaults standardUserDefaults] synchronize];
            });
            
        });
    }
    //names
    self.repoNameLab.text = repoModel.name;
    self.ownerLab.text = repoModel.owner.login;
    
}
#pragma mark - Getter
- (UIImageView *)ownerAvatar {
    if (!_ownerAvatar) {
        _ownerAvatar = [[UIImageView alloc] init];
    }
    return _ownerAvatar;
}

- (UILabel *)ownerLab {
    if (!_ownerLab) {
        _ownerLab = [[UILabel alloc] init];
        _ownerLab.textAlignment = NSTextAlignmentCenter;
        _ownerLab.font = [UIFont systemFontOfSize:14.0];

    }
    return _ownerLab;
}

- (UILabel *)repoNameLab {
    if (!_repoNameLab) {
        _repoNameLab = [[UILabel alloc] init];
        _repoNameLab.textAlignment = NSTextAlignmentCenter;
        _repoNameLab.font = [UIFont systemFontOfSize:17.0];

    }
    return _repoNameLab;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
