//
//  TransferListView.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/24.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "TransferListView.h"
#import "CSStickyHeaderFlowLayout.h"
#import "YYViewHeader.h"
#import "TransferCell.h"
#import "YYInterfaceMacro.h"
#import "TransferHeaderView.h"

static NSString *kTransferIdentifier = @"kTransferIdentifier";
static NSString *kTransferHeaderIdentifier = @"kTransferHeaderIdentifier";

@interface TransferListView ()
<UICollectionViewDelegate,
UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end


@implementation TransferListView {
    CSStickyHeaderFlowLayout      *_layout;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    _layout = [[CSStickyHeaderFlowLayout alloc] init];
    _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _layout.minimumLineSpacing = 0;
    self.collectionView = ({
        UICollectionView *cv = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
        cv.showsVerticalScrollIndicator = YES;
        cv.dataSource = self;
        cv.delegate = self;
        cv.backgroundColor = COLOR_ffffff;
        [self addSubview:cv];
        [cv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        //注册不同类型的cell
        [cv registerClass:[TransferCell class] forCellWithReuseIdentifier:kTransferIdentifier];
        [cv registerClass:[TransferHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kTransferHeaderIdentifier];
        cv;
    });
}

- (void)setItems:(NSArray<TransferItem *> *)items {
    _items = items;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource && delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TransferCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTransferIdentifier forIndexPath:indexPath];
    TransferItem *item = self.items[indexPath.row];
    cell.item = item;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    TransferHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kTransferHeaderIdentifier forIndexPath:indexPath];
    return header;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TransferItem *item = self.items[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(yy_openTransferDetailControllerWithItem:)]) {
        [self.delegate yy_openTransferDetailControllerWithItem:item];
    }
    return YES;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(YYSCREEN_WIDTH, 78);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(YYSCREEN_WIDTH, 60);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
