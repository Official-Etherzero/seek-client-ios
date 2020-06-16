//
//  WDAddTokenController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/23.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDAddTokenController.h"
#import "YYViewHeader.h"
#import "ClientServer.h"
#import "TokensCell.h"
#import "YYInterfaceMacro.h"
#import "CSStickyHeaderFlowLayout.h"

static NSString *kAddTokenController = @"kAddTokenController";

@interface WDAddTokenController ()
<UICollectionViewDelegate,
UICollectionViewDataSource>

@property (nonatomic, strong) TokenList          *listModel;
@property (nonatomic, strong) UICollectionView   *listView;

@end

@implementation WDAddTokenController  {
    CSStickyHeaderFlowLayout      *_layout;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_00d998;
    self.navigationItem.title = YYStringWithKey(@"添加代币");
    self.listModel = [[TokenList alloc] init];
    self.listModel.tokenList = [TokenList getCacheTokenList].copy;
    [self initSubViews];
    WDWeakify(self);
    [[ClientServer sharedInstance] getTokenListComplete:^(TokenList * _Nonnull list) {
        NSLog(@"%@",list);
        WDStrongify(self);
        self.listModel = list;
        [self.listView reloadData];
    }];
}

- (void)initSubViews {
    _layout = [[CSStickyHeaderFlowLayout alloc] init];
    _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _layout.minimumLineSpacing = 0;
    self.listView = ({
        UICollectionView *cv = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
        cv.showsVerticalScrollIndicator = YES;
        cv.dataSource = self;
        cv.delegate = self;
        cv.backgroundColor = COLOR_ffffff;
        [self.view addSubview:cv];
        [cv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
        //注册不同类型的cell
        [cv registerClass:[TokensCell class] forCellWithReuseIdentifier:kAddTokenController];
        cv;
    });
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    if (@available(iOS 11.0, *)) {
        if ([self.listView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            self.listView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
}

#pragma mark - UICollectionViewDataSource && delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.listModel.tokenList.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TokensCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAddTokenController forIndexPath:indexPath];
    TokenModel *model = self.listModel.tokenList[indexPath.row];
    cell.model = model;
    WDWeakify(self);
    cell.addTokenBlock = ^(TokenModel * _Nonnull model) {
        // 添加代币了
        WDStrongify(self);
        // 移除这个代币
        [self.listView reloadItemsAtIndexPaths:@[indexPath]];
    };
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(YYSCREEN_WIDTH, 78);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
