//
//  ViewController.m
//  YBWaterFlowLayoutDemo
//
//  Created by yangbin on 2017/6/16.
//  Copyright © 2017年 yangbin. All rights reserved.
//

#import "ViewController.h"
#import "MemoryFlowLayout.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, MemoryFlowLayoutDelegate>

@property (nonatomic, strong) UICollectionView *mCollectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mCollectionView];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

#pragma mark - FlowLayoutDelegate

/**
 *  行间距
 */
- (CGFloat)rowMarginInWaterflowLayout:(UICollectionViewLayout*)layout {
    
    return 12;
}
/**
 *  列间距
 */
- (CGFloat)columnMarginInWaterflowLayout:(UICollectionViewLayout*)layout {
    
    return 15;
}
/**
 *  列数
 */
- (NSInteger)columnCountInWaterflowLayout:(UICollectionViewLayout*)layout {
    
    return 2;
}
/**
 *  collectionView内边距
 */
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(UICollectionViewLayout*)layout {
    
    return UIEdgeInsetsMake(0, 16, 16, 16);
}

- (CGFloat)heightForWaterLayout:(UICollectionViewLayout *)waterLayout indexPath:(NSIndexPath *)indexPath {
    
    return arc4random() % 200 + 80;
}

- (UICollectionView *)mCollectionView {
    
    if (!_mCollectionView) {
        MemoryFlowLayout *flowLayout = [[MemoryFlowLayout alloc] init];
        flowLayout.delegate = self;
        _mCollectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
        _mCollectionView.delegate = self;
        _mCollectionView.dataSource = self;
        _mCollectionView.backgroundColor = [UIColor whiteColor];
        [_mCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
    }
    return _mCollectionView;
}


@end
