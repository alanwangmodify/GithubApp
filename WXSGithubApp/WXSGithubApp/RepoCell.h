//
//  RepoCell.h
//  GithubDemo
//
//  Created by AlanWang on 17/3/1.
//  Copyright © 2017年 AlanWang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RepoModel;
@interface RepoCell : UITableViewCell

@property (nonatomic, strong) UIImageView *ownerAvatar;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *repoLab;
@property (nonatomic, strong) RepoModel *repoModel;


+ (CGFloat)cellHeight;


@end
