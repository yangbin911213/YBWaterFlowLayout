//
//  MemoryFlowLayout.h
//  MrsYoung
//
//  Created by yangbin on 2017/6/3.
//  Copyright © 2017年 yangbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MemoryFlowLayoutDelegate <NSObject>

@required

- (CGFloat)heightForWaterLayout:(UICollectionViewLayout *)waterLayout indexPath:(NSIndexPath *)indexPath;

@optional
/**
 *  行间距
 */
- (CGFloat)rowMarginInWaterflowLayout:(UICollectionViewLayout*)layout;
/**
 *  列间距
 */
- (CGFloat)columnMarginInWaterflowLayout:(UICollectionViewLayout*)layout;
/**
 *  列数
 */
- (NSInteger)columnCountInWaterflowLayout:(UICollectionViewLayout*)layout;
/**
 *  collectionView内边距
 */
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(UICollectionViewLayout*)layout;

@end

@interface MemoryFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<MemoryFlowLayoutDelegate> delegate;

@end
