//
//  MemoryFlowLayout.m
//  MrsYoung
//
//  Created by yangbin on 2017/6/3.
//  Copyright © 2017年 yangbin. All rights reserved.
//

#import "MemoryFlowLayout.h"

/** 默认的列数 */
static const NSInteger MDefaultColumnCount = 2;
/** 每一列之间的间距 */
static const CGFloat MDefaultColumnMargin = 10;
/** 每一行之间的间距 */
static const CGFloat MDefaultRowMargin = 10;
/** 边缘间距 */
static const UIEdgeInsets MDefaultEdgeInsets = {0, 10, 10, 10};

@interface MemoryFlowLayout ()

/** 存放所有cell的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;
/** 存放所有列的当前高度 */
@property (nonatomic, strong) NSMutableArray *columnHeights;
/** 内容的高度 */
@property (nonatomic, assign) CGFloat contentHeight;
@end

@implementation MemoryFlowLayout

#pragma mark - 代理数据处理
- (CGFloat)rowMargin
{
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterflowLayout:)]) {
        return [self.delegate rowMarginInWaterflowLayout:self];
    } else {
        return MDefaultRowMargin;
    }
}

- (CGFloat)columnMargin
{
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterflowLayout:)]) {
        return [self.delegate columnMarginInWaterflowLayout:self];
    } else {
        return MDefaultColumnMargin;
    }
}

- (NSInteger)columnCount
{
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterflowLayout:)]) {
        return [self.delegate columnCountInWaterflowLayout:self];
    } else {
        return MDefaultColumnCount;
    }
}

- (UIEdgeInsets)edgeInsets
{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterflowLayout:)]) {
        return [self.delegate edgeInsetsInWaterflowLayout:self];
    } else {
        return MDefaultEdgeInsets;
    }
}

- (NSMutableArray *)columnHeights
{
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

/**
 * 初始化
 */
- (void)prepareLayout
{
    [super prepareLayout];
    
    // 清除以前计算的所有高度
    [self.columnHeights removeAllObjects];
    for (NSInteger i = 0; i < MDefaultColumnCount; i++) {
        //重新布局时，给出默认高度
        [self.columnHeights addObject:@(MDefaultEdgeInsets.top)];
    }
    
    // 清除之前所有的布局属性
    [self.attrsArray removeAllObjects];
    // 开始创建每一个cell对应的布局属性
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i++) {
        // 创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        // 获取indexPath位置cell对应的布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
}

/**
 * 决定cell的排布
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}

/**
 * 返回indexPath位置cell对应的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // collectionView的宽度
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    
    // 设置布局属性的frame
    CGFloat Width = (collectionViewW - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
    
    CGFloat Height = [self.delegate heightForWaterLayout:self indexPath:indexPath];
    
    // 找出高度最短的那一列
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i < self.columnCount; i++) {
        // 取得第i列的高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    
    CGFloat X = self.edgeInsets.left + destColumn * (Width + self.columnMargin);
    CGFloat Y = minColumnHeight;
    if (Y != self.edgeInsets.top) {
        Y += self.rowMargin;
    }
    attrs.frame = CGRectMake(X, Y, Width, Height);
    
    // 更新最短那列的高度(然后调此方法会重新计算)
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attrs.frame));
    
    // 记录内容的高度
    CGFloat columnHeight = [self.columnHeights[destColumn] doubleValue];
    if (self.contentHeight < columnHeight) {
        self.contentHeight = columnHeight;
    }
    return attrs;
}

- (CGSize)collectionViewContentSize
{
    
    return CGSizeMake(0, self.contentHeight + self.edgeInsets.bottom);
}


@end
