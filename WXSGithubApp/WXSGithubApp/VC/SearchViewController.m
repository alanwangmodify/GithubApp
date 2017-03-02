//
//  SearchViewController.m
//  WXSGithubApp
//
//  Created by 王小树 on 17/3/1.
//  Copyright © 2017年 王小树. All rights reserved.
//

#import "SearchViewController.h"
#import "WXSGithubNetWork.h"
#import "RepoCell.h"
#import "RepoModel.h"
#import "DetailViewController.h"

CGFloat const k_animaton_time = 0.4;

@interface SearchViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchResultsUpdating,UINavigationControllerDelegate,UIViewControllerAnimatedTransitioning>
{
    int32_t _page;
    NSIndexPath *_selectIndepath;
    
}
@property (nonatomic, strong) UITableView *resultTableView;
@property (nonatomic, strong) UIButton *dismissBtn;
@property (nonatomic, strong) NSArray<RepoModel *> *items;
@property (nonatomic, strong) UISearchController *searchController;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:41.0/255.0 green:41.0/255.0 blue:47.0/255.0 alpha:1.0];
    [self setupView];
    
}
#pragma mark - View
- (void)setupView {
    [self.view addSubview:self.resultTableView];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.dismissBtn];
    self.resultTableView.tableHeaderView = self.searchController.searchBar;
}
#pragma mark - data and action
- (void)getReposData {
    
    [WXSGithubNetWork searchUserDataWithKeyStr:self.searchController.searchBar.text andPageCount:_page Commpletion:^(NSArray<RepoModel *> *items) {
        self.items = items;
        [self.resultTableView reloadData];

    }];
    
}
-(void)refreshData{
    _page=0;
    self.items = nil;
    [self getReposData];
}
-(void)loadMoreData {
    _page++;
    [self getReposData];
    
}
- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"identifier";
    RepoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[RepoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (indexPath.row < _items.count) {
        RepoModel *model = _items[indexPath.row];
        cell.repoModel = model;
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [RepoCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.searchController resignFirstResponder];
    if (indexPath.row < _items.count) {
        RepoModel *model = _items[indexPath.row];
        DetailViewController *vc = [[DetailViewController alloc] initWithRepoModel:model];
        self.navigationController.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        _selectIndepath = indexPath;
    }
    
}

//翻页
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
//     if (scrollView.contentOffset.y > scrollView.contentSize.height - 100) {
//         scrollView.contentInset = UIEdgeInsetsMake(scrollView.contentInset.top, scrollView.contentInset.left, scrollView.contentInset.bottom + 40, scrollView.contentInset.right);
//         _page++;
//         [self loadMoreData];
//     }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if (UINavigationControllerOperationPush) {
        return self;
    }else{
        return nil;
    }
}


- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return k_animaton_time;
    
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    DetailViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    RepoCell *cell = [self.resultTableView cellForRowAtIndexPath:_selectIndepath];
    CGRect rect = [cell.ownerAvatar convertRect:cell.ownerAvatar.bounds toView:containerView];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:cell.ownerAvatar.image];
    imgView.frame = rect;
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:imgView];
    
    UIView *toView = toVC.ownerAvatar;
    CGRect toRect = [toView convertRect:toView.bounds toView:containerView];
    fromVC.view.hidden = YES;
    toVC.view.alpha = 0.0;
    toView.hidden = YES;
    [UIView animateWithDuration:k_animaton_time animations:^{
        imgView.frame = toRect;
    } completion:^(BOOL finished) {
        toView.hidden = NO;
        toVC.view.alpha = 1.0;
        fromVC.view.hidden = NO;
        [imgView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}


//UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {

    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshData) object:nil];
    [self refreshData];
    [self.searchController.searchBar resignFirstResponder];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshData) object:nil];
    if (searchText.length > 0) {
        [self performSelector:@selector(refreshData) withObject:nil afterDelay:0.2];
    }
}

// UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
}


#pragma mark - Getter

- (UIButton *)dismissBtn {
    if (!_dismissBtn) {
        _dismissBtn = [[UIButton alloc] init];
        _dismissBtn.frame = CGRectMake(0, 0, 50,50);
        [_dismissBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_dismissBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dismissBtn;
}
- (UITableView *)resultTableView {
    if (!_resultTableView) {
        _resultTableView = [[UITableView alloc] init];
        _resultTableView.delegate = self;
        _resultTableView.dataSource = self;
        _resultTableView.frame = self.view.bounds;
    }
    return _resultTableView;
}
- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.searchBar.placeholder = @"";
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.searchBar.delegate = self;
        [_searchController.searchBar sizeToFit];
    }
    return _searchController;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
