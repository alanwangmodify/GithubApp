//
//  RepoCell.m
//  GithubDemo
//
//  Created by AlanWang on 17/3/1.
//  Copyright © 2017年 AlanWang. All rights reserved.
//

#import "RepoCell.h"
#import "RepoModel.h"

@implementation RepoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}
#pragma mark - View
- (void)setupView {
    
    [self.contentView addSubview:self.ownerAvatar];
    [self.contentView addSubview:self.repoLab];
    [self.contentView addSubview:self.nameLab];
    
    self.ownerAvatar.frame = CGRectMake(15, 10, 40, 40);
    self.repoLab.frame = CGRectMake(CGRectGetMaxX(self.ownerAvatar.frame) + 20, 15, 200, 18);
    self.nameLab.frame = CGRectMake(CGRectGetMaxX(self.ownerAvatar.frame) + 20, CGRectGetMaxY(self.repoLab.frame)+2, 200, 15);
    

}
#pragma mark - Setter
- (void)setRepoModel:(RepoModel *)repoModel {
    _repoModel = repoModel;
    if (!repoModel) {
        return;
    }
    
    self.nameLab.text = repoModel.owner.login;
    self.repoLab.text = repoModel.name;
    
    
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
    

    
}

#pragma mark - Getter
- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.font = [UIFont systemFontOfSize:14.0];
    }
    return _nameLab;
}
- (UILabel *)repoLab {
    if (!_repoLab) {
        _repoLab = [[UILabel alloc] init];
        _repoLab.font = [UIFont systemFontOfSize:17.0];
    }
    return _repoLab;
}
- (UIImageView *)ownerAvatar {
    if (!_ownerAvatar) {
        _ownerAvatar = [[UIImageView alloc] init];
    }
    return _ownerAvatar;
}
#pragma mark - Publick
+ (CGFloat)cellHeight {
    return 60.0;
}


@end
