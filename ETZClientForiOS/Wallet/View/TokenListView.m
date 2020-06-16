//
//  TokenListView.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/23.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "TokenListView.h"
#import "CSStickyHeaderFlowLayout.h"
#import "YYViewHeader.h"
#import "TokenCell.h"
#import "TokenHeaderView.h"
#import "YYInterfaceMacro.h"
#import "TokenItem.h"
#import "YYAdvertView.h"
#import "YYDateModel.h"
#import "TokenDataManager.h"


static NSString *kTokenIdentifier = @"kTokenIdentifier";
static NSString *kWalletHeaderIdentifier = @"kWalletHeaderIdentifier";

@interface TokenListView ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
YYAdvertViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray   *items;
@property (nonatomic, strong) YYAdvertView     *advertView;

@end

@implementation TokenListView {
    CSStickyHeaderFlowLayout      *_layout;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initSubViews];
        [self initDatas];
    }
    return self;
}

- (void)initSubViews {
    _layout = [[CSStickyHeaderFlowLayout alloc] init];
    _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _layout.minimumLineSpacing = 0;
    self.collectionView = ({
        UICollectionView *cv = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
        cv.showsVerticalScrollIndicator = NO;
        cv.dataSource = self;
        cv.delegate = self;
        cv.backgroundColor = COLOR_ffffff;
        [self addSubview:cv];
        [cv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        //注册不同类型的cell
        [cv registerClass:[TokenCell class] forCellWithReuseIdentifier:kTokenIdentifier];
        [cv registerClass:[TokenHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kWalletHeaderIdentifier];
        cv;
    });
    
//    self.advertView = ({
//        YYAdvertView *v = [[YYAdvertView alloc] init];
//        [self addSubview:v];
//        v.delegate = self;
//        v.hidden = [self advertViewIsHidden];
//        [v mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(self.mas_bottom).offset(-YYSIZE_19);
//            make.centerX.mas_equalTo(self.mas_centerX);
//            make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_100));
//        }];
//        v;
//    });
}

- (void)initDatas {
    self.items = [NSMutableArray array];
//    NSArray *arr = @[@"SEEK",@"BTC",@"ETH"];
//    NSArray *codes = @[@"SeekChain",@"Bitcoin",@"Ethereum"];
//    NSArray *images = @[@"SEEK",@"btc",@"ETH"];
//    NSArray *nums= @[@"35678",@"3698",@"4567"];
//    NSArray *prices = @[@"3546.22344",@"36346363463463.2",@"37453436.2"];
//    for (int i = 0; i < arr.count; i ++) {
//        TokenItem *item = [[TokenItem alloc] init];
//        item.name = arr[i];
//        item.code = codes[i];
//        item.imageUrl = images[i];
//        item.num = nums[i];
//        item.price = prices[i];
//        [self.items addObject:item];
//    }
    self.items = [NSMutableArray arrayWithArray:[TokenDataManager getTokenList]];
}

- (void)setModel:(AccountModel *)model {
    _model = model;
    [self.items removeAllObjects];
    TokenItem *item = [TokenDataManager updateDefaultTokenItemByModel:model];
    [self.items addObject:item];
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
    TokenCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTokenIdentifier forIndexPath:indexPath];
    TokenItem *item = self.items[indexPath.row];
    cell.item = item;
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    TokenHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kWalletHeaderIdentifier forIndexPath:indexPath];
    WDWeakify(self)
    header.addTokenBlock = ^{
      // 添加代币
        WDStrongify(self)
        if ([self.delegate respondsToSelector:@selector(yy_openAddTokenViewController)]) {
            [self.delegate yy_openAddTokenViewController];
        }
    };
    return header;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TokenItem *item = self.items[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(yy_openTokenDetailsViewControllerWithItem:)]) {
        [self.delegate yy_openTokenDetailsViewControllerWithItem:item];
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

#pragma mark - YYAdvertViewDelegate

- (void)yy_hideAdvertView {
    [self.advertView setHidden:YES];
    // 记录下时间
    [[NSUserDefaults standardUserDefaults] setObject:[YYDateModel yy_currentTime] forKey:kMarkCurrentTime];
}

#pragma mark - time tool

- (BOOL)advertViewIsHidden {
    NSDate *markDate = [[NSUserDefaults standardUserDefaults] valueForKey:kMarkCurrentTime];
    if (!markDate) {
        return NO;
    }
    return [YYDateModel yy_compareDate:[YYDateModel yy_markTimeByCurrentTime:markDate] withDate:[YYDateModel yy_currentTime]];
}

@end
