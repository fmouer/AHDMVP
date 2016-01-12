//
//  AHDCollectionControl.m
//  MVPDemo
//
//  Created by ihotdo on 15/12/28.
//  Copyright © 2015年 ihotdo. All rights reserved.
//

#import "AHDCollectionControl.h"
#import "AHDCollectionControlLayout.h"

#import "AHDCollectionControlModel.h"
#import "AHDActionProtocol.h"
#import "AHDControlActionHandler.h"

#import "UICollectionView+RegisterClass.h"
#import "AHDTransferModel.h"
#import "AHDShowModel.h"
#import <objc/runtime.h>

#import "MJRefresh.h"

#define EstimatedItemSizeHeight     (60.0f)

@interface AHDCollectionControl ()<UICollectionViewDelegateFlowLayout,AHDActionHandlerDelegate>
{
    UILabel                     * _alertLabel;
}

@property (nonatomic, assign)CGSize estimatedItemSize;

@property (nonatomic, strong)AHDCollectionControlModel * controlModel;

@property (nonatomic, strong)AHDControlActionHandler * controlActionHandler;

@property (nonatomic, strong)id<AHDHelperProtocol>helperModel;

@property (nonatomic, strong)NSMutableDictionary   * cellClassCaches;

@property (nonatomic, strong)AHDCollectionControlLayout * flowLayout;

@end

@implementation AHDCollectionControl
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 属性
-(void)setHelperModel:(id<AHDHelperProtocol>)helperModel
{
    _helperModel = helperModel;
    self.controlModel.helperModel = helperModel;
}

/*
-(void)setEstimatedItemSize:(CGSize)estimatedItemSize
{
    _flowLayout.estimatedItemSize = estimatedItemSize;
    _estimatedItemSize = estimatedItemSize;
}*/

- (void)setControlHeaderModel:(id<AHDModelProtocol>)headerModel
{
    self.controlModel.headerModel = headerModel;
}

- (void)showAlertLabelWith:(NSString *)text
{
    if (_alertLabel == nil) {
        _alertLabel = [[UILabel alloc] init];
//        _alertLabel.font = AHDFontMid;
        _alertLabel.textAlignment = NSTextAlignmentCenter;
//        _alertLabel.textColor = AHDBaseColor;
        [_collectionView addSubview:_alertLabel];
        _alertLabel.frame = CGRectMake(0, 100,CGRectGetWidth(self.frame), 20);
        
    }
    _alertLabel.hidden = NO;
    _alertLabel.text = text;
}

#pragma mark - 初始化
-(UICollectionViewFlowLayout *)flowLayout
{
    if (_flowLayout == nil) {
        _flowLayout = [[AHDCollectionControlLayout alloc] init];

        /*
        if (!CGSizeEqualToSize(self.sectionHeaderSize, CGSizeZero)){
            _flowLayout.headerReferenceSize = self.sectionHeaderSize;
        }
        */
        if (_minimumLineSpacing) {
            _flowLayout.minimumLineSpacing = _minimumLineSpacing;
        }
        
        if (_minimumInteritemSpacing) {
            _flowLayout.minimumInteritemSpacing = _minimumInteritemSpacing;
        }

        /*
        if (CGSizeEqualToSize(self.estimatedItemSize, CGSizeZero)){
            self.estimatedItemSize = CGSizeMake(CGRectGetWidth(self.frame), EstimatedItemSizeHeight);
        }

        //cell item size 的估值，等cell显示时再进行cell size的精确计算。
        _flowLayout.estimatedItemSize = self.estimatedItemSize;
         */
    }
    return _flowLayout;
}



- (instancetype)initWithFrame:(CGRect)frame
                  helperModel:(id<AHDHelperProtocol>)helperModel
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeModel];
        self.helperModel = helperModel;
    }
    return self;
}

- (instancetype)initWithHelperModel:(id<AHDHelperProtocol>)helperModel
{
    self = [super init];
    if (self) {
        [self initializeModel];
        self.helperModel = helperModel;
    }
    return self;
}
- (void)layoutSubviews
{
    [self initCollectionView];
}


- (void)initCollectionView
{
    if (!_collectionView) {
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor redColor];

        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        if (_flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
            _collectionView.alwaysBounceHorizontal = YES;
        }else{
            _collectionView.alwaysBounceVertical = YES;
        }
        
        [self addSubview:_collectionView];
        _collectionView.backgroundColor = [UIColor clearColor];
        
        //注册Cell class
        if ([_helperModel respondsToSelector:@selector(helperGetItemNibCell)]) {
            self.cellClassCaches = [_collectionView registerModelNib:[_helperModel helperGetItemNibCell]];
        }else{
           self.cellClassCaches =  [_collectionView registerModelClass:[_helperModel helperGetItemCell]];
        }
        
        //注册cell section class
        if ([_helperModel respondsToSelector:@selector(helperGetItemSectionHeader)]) {
            [_collectionView registerModelClass:[_helperModel helperGetItemSectionHeader] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader];
        }
        
        if (_flowLayout.scrollDirection == UICollectionViewScrollDirectionVertical) {
            //下拉刷新
            if (_refreshType == AHDRefreshTypeRefresh ||
                _refreshType == AHDRefreshTypeRefreshAndLoading) {
                _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
            }
            if (_beginRefreshing) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [_collectionView.mj_header beginRefreshing];
                });
            }
            //上拉加载更多
            if (_refreshType == AHDRefreshTypeLoading ||
                _refreshType == AHDRefreshTypeRefreshAndLoading) {
                _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loading)];
                _collectionView.mj_footer.automaticallyHidden = YES;
            }
        }
        
        
        //注册cell footer class, 未实现，后续完善
        /*
        if ([_helperModel respondsToSelector:@selector(helperGetItemSectionFooter)]) {
            [_collectionView registerModelClass:[_helperModel helperGetItemSectionFooter] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter];
        }
         */
    }
}

- (void)initializeModel
{
    self.controlModel = [[AHDCollectionControlModel alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivesUpdateNotification:) name:@"collectionControlNotification" object:nil];
}


#pragma mark - cell block
- (CellOperationBlock)operationBlock:(id<AHDModelProtocol>)model
{
    __weak typeof(AHDControlActionHandler *) wActionHandler = self.controlActionHandler;
    return ^(id actionInfo) {
        if ([model conformsToProtocol:@protocol(AHDActionProtocol) ]) {
            AHDBaseDataAction * action = [(id<AHDActionProtocol>)model jumpActionModel:actionInfo];
            [wActionHandler performAction:action];
        }
    };
}

- (CellSizeBlock)sizeWith:(id)model
{
    __weak typeof(AHDCollectionControlModel *) wControl = self.controlModel;
    return ^(CGSize size) {
        NSLog(@"size %@",NSStringFromCGSize(size));
        [wControl setCellSizeWith:model size:size];
    };
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.controlModel sectionCount];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.controlModel rowModelCount:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    //获取model
    id<AHDModelProtocol>model = [self.controlModel rowModelAtIndexPath:indexPath];

    //通过model cellIdentifier 获取Identifier
    UICollectionViewCell<AHDCellProtocol> * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[model cellIdentifier] forIndexPath:indexPath];
    //设置model
    [cell setCellModel:model];
    
    //设置可操作的回调 block
    if ([cell respondsToSelector:@selector(setCellOpeationBlock:)]) {
        [cell setCellOpeationBlock:[self operationBlock:model]];
    }
    
    NSLog(@"cell index is %ld",(long)indexPath.row);
    
    /* 此方法暂时不用，该方法是collectionView采用estimatedItemSize属性时，在实例化的cell中通过sizeBlock返回size用于缓存，采用此方法可提高计算效率，只在cell展示之前计算高度。
     但是当采用此方法时，对cell进行刷新/删除/插入等操作时会出现cell错位等情况，所以暂时弃用改方法。等找到解决办法时再考虑启用。
     
    if ([cell respondsToSelector:@selector(setCellSize:getActualSize:)]) {
        CGSize size = [self.controlModel getCellSizeWith:model];
        [cell setCellSize:CGSizeEqualToSize(size, CGSizeZero)?CGSizeMake(_flowLayout.estimatedItemSize.width, 0):size
            getActualSize:[self sizeWith:model]];
    }
     */
    NSAssert(cell, @"cell 不存在！");
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    id<AHDModelProtocol>headerModel = self.controlModel.headerModel;
    UICollectionReusableView<AHDCellProtocol> * resuableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[headerModel cellIdentifier] forIndexPath:indexPath];
    [resuableView setCellModel:headerModel];
    
    return resuableView;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return _collectionEdgeInsets;
}

#pragma mark item size 计算
/**
 *  计算 itemCell 的size
 *  1，判断是否是设置固定的size，是则直接返回itemSize
 *  2，读取缓存size，如果存在则读取缓存size
 *  3，判断是否通过类方法+(CGSize)getCellSizeWith: 计算size
 *  4，实例化cell后，通过-(CGSize)getCellSize 计算size
 *  5，步骤3，4 获取到size后，会通过controlModel 缓存size
 *
 *  @return cell Size
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!CGSizeEqualToSize(CGSizeZero, self.itemSize)) {
        //item size是 固定大小
        return self.itemSize;
    }
    
    id<AHDModelProtocol>model = [self.controlModel rowModelAtIndexPath:indexPath];
    CGSize size = [self.controlModel getCellSizeWith:model];
    
    //判断是否有缓存size，有则直接返回
    if (!CGSizeEqualToSize(CGSizeZero, size)) {
        NSLog(@"读取缓存 size");
        return size;
    }
    NSString * cellIdentifer = [model cellIdentifier];
    UICollectionViewCell<AHDCellProtocol> * cell = [_cellClassCaches objectForKey:cellIdentifer];
    if ([cell isKindOfClass:[NSString class]]) {
        Class cellClass = NSClassFromString(cellIdentifer);
        
        //通过类方法计算cell的size
        if([self checkIsExistClassMethod:cellClass verifySEL:NSSelectorFromString(@"getCellSizeWith:cellWidth:")]){
            size =  [cellClass getCellSizeWith:model cellWidth:CGRectGetWidth(collectionView.frame)];
            NSLog(@"cell 静态方法计算 cell size");
            [self.controlModel setCellSizeWith:model size:size];
            return size;
        }
        NSString * nibCell = (NSString *)cell;
        
        if ([nibCell isEqualToString:@"Nib"]) {
            //通过Nib 生成的Cell
            cell = [[[NSBundle mainBundle] loadNibNamed:cellIdentifer owner:self options:nil] firstObject];
        }else{
            cell = [[cellClass alloc] initWithFrame:(CGRect){CGPointZero,collectionView.frame.size.width}];
        }
        
        [_cellClassCaches setObject:cell forKey:cellIdentifer];
    }
    
    [cell setCellModel:model];
    [cell layoutIfNeeded];
    
     size =[cell getCellSize];
    NSLog(@"cell 实例计算 cell size");

    [self.controlModel setCellSizeWith:model size:size];
    return size;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (self.controlModel.headerModel) {
        return self.sectionHeaderSize;
    }else{
        return CGSizeZero;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<AHDModelProtocol>model = [self.controlModel rowModelAtIndexPath:indexPath];
    if ([model conformsToProtocol:@protocol(AHDActionProtocol)]) {
        AHDBaseDataAction * action = [(id<AHDActionProtocol>)model jumpActionModel:@"didSelectedCell"];
        [self.controlActionHandler performAction:action];
    }
}

#pragma mark - AHDControlActionHandler

- (AHDControlActionHandler *)controlActionHandler
{
    if (_controlActionHandler == nil) {
        _controlActionHandler = [[AHDControlActionHandler alloc] init];
        _controlActionHandler.delegate = self;
    }
    return _controlActionHandler;
}

#pragma mark AHDActionHandlerDelegate
/**
 * AHDActionHandlerDelegate，当cell点击执行action事件时会通过该方法回调返回
 *
 *  @param actionHandler action管理类
 *  @param dataAction   DataAction
 *  @param result        action携带的信息，携带action额外的信息
 */
-(void)actionHandler:(AHDControlActionHandler *)actionHandler actionCompletion:(AHDBaseDataAction *)dataAction result:(NSDictionary *)result
{
    NSUInteger index = [self.controlModel indexOfModel:dataAction.model];
    if (index != NSNotFound) {
        [self.controlModel replaceModel:dataAction.model atIndex:index];
        
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        UICollectionViewCell<AHDCellProtocol> * cell = (UICollectionViewCell<AHDCellProtocol> *)[_collectionView cellForItemAtIndexPath:indexPath];
        if (cell) {
            [cell updatePartOfCell:dataAction result:result];
        }
    }
    
    //代理回调
    if (_delegate && [_delegate respondsToSelector:@selector(collectionControl:didDataAction:)]) {
        [_delegate collectionControl:self didDataAction:dataAction];
    }
}

- (BOOL)shouldActionHandler:(AHDControlActionHandler *)actionHandler willDataAction:(AHDBaseDataAction *)dataAction
{
    //代理回调
    BOOL willShould  = YES;
    if (_delegate && [_delegate respondsToSelector:@selector(shouldCollectionControl:willDataAction:)]) {
      willShould = [_delegate shouldCollectionControl:self willDataAction:dataAction];
    }
    return willShould;
}

#pragma mark -
#pragma mark 加载数据
/**
 *  加载数据
 *
 *  @param objectInfo 数据信息
 *  @param page       页码
 */
-(void)setControlData:(id)objectInfo page:(NSInteger)page
{
    __weak typeof(UICollectionView *)wCollectionView = _collectionView;
    __weak typeof(AHDCollectionControl *)wSelf = self;
    
    if ([_collectionView.mj_header isRefreshing]) {
        [_collectionView.mj_header endRefreshing];
    }else{
        [_collectionView.mj_footer endRefreshing];
    }
    
    [self.controlModel tableViewControlLoadDatas:objectInfo pages:page insertCompletion:^(NSArray<NSIndexPath *> *insertIndexPaths) {
        //插入新数据
        [wCollectionView insertItemsAtIndexPaths:insertIndexPaths];
    } reloadCompletion:^{
        //第一页刷新
        [UIView performWithoutAnimation:^{
            [wCollectionView reloadData];
        }];
    } message:^(NSString *message) {
        //提示信息
        [wSelf showAlertLabelWith:message];
    }];
    
}

#pragma mark 接收到更新通知
- (void)receivesUpdateNotification:(NSNotification *)notification
{
    AHDTransferModel * transferModel = notification.object;
    
    if (![self.controlModel hasSubCellModelClass:[transferModel.model class]]) {
        //不存在该model类型，则直接返回。
        return;
    }
    
    __weak typeof(UICollectionView *) wCollectionView = _collectionView;
    
    if (transferModel.transerType == TranserTypeUpdate) {
        //数据更新
        if (transferModel.updateKeys.count) {
            [_controlModel updateModel:transferModel.model keys:transferModel.updateKeys completion:^(NSArray *updateIndexPaths) {
                [wCollectionView reloadItemsAtIndexPaths:updateIndexPaths];
            }];
        }else{
            [_controlModel updateModel:transferModel.model completion:^(NSIndexPath *updateIndexPath) {
                [wCollectionView reloadItemsAtIndexPaths:@[updateIndexPath]];
            }];
        }
        
    }else if (transferModel.transerType == TranserTypeInsert){
        //有数据插入
        [_controlModel insertModel:transferModel.model atIndex:0 completion:^(NSIndexPath *insertIdexPath) {
            [wCollectionView setContentOffset:CGPointZero animated:YES];
            [wCollectionView insertItemsAtIndexPaths:@[insertIdexPath]];
        }];
        
    }else if (transferModel.transerType == TranserTypeDelete){
        //有数据删除
        [_controlModel deleteModel:transferModel.model completion:^(NSArray *deleteIndexPaths) {
            _flowLayout.changeCollectionLayout = YES;
                [wCollectionView deleteItemsAtIndexPaths:deleteIndexPaths];
        }];
    }
}

#pragma mark - 上拉加载 ，下拉刷新
- (void)refresh
{
    if (_delegate && [_delegate respondsToSelector:@selector(collectionControl:requestPage:)]) {
        [_delegate collectionControl:self requestPage:0];
    }
}

- (void)loading
{
    if (_delegate && [_delegate respondsToSelector:@selector(collectionControl:requestPage:)]) {
        [_delegate collectionControl:self requestPage:_controlModel.currentPage + 1];
    }
}

#pragma mark -

///判断className 类中是否存在类方法selector
- (BOOL)checkIsExistClassMethod:(Class )class verifySEL:(SEL)selector
{
    Method  classMethod = class_getClassMethod(class, selector);
    BOOL existMethod = NO;
    if (classMethod) {
        existMethod = YES;
    }
    return existMethod;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
