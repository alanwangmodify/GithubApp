//
//  DetailViewController.h
//  WXSGithubApp
//
//  Created by 王小树 on 17/3/1.
//  Copyright © 2017年 王小树. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RepoModel;

@interface DetailViewController : UIViewController

@property (nonatomic,strong) RepoModel *repoModel;
@property (nonatomic,strong) UIImageView *ownerAvatar;
@property (nonatomic,strong) UILabel *ownerLab;
@property (nonatomic,strong) UILabel *repoNameLab;
@property (nonatomic,strong) UILabel *starNumLab;
@property (nonatomic,strong) UILabel *watchNumLab;
@property (nonatomic,strong) UILabel *forkNumLab;
@property (nonatomic,strong) UILabel *descLab;

- (instancetype)initWithRepoModel:(RepoModel *)repoModel;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;

@end
