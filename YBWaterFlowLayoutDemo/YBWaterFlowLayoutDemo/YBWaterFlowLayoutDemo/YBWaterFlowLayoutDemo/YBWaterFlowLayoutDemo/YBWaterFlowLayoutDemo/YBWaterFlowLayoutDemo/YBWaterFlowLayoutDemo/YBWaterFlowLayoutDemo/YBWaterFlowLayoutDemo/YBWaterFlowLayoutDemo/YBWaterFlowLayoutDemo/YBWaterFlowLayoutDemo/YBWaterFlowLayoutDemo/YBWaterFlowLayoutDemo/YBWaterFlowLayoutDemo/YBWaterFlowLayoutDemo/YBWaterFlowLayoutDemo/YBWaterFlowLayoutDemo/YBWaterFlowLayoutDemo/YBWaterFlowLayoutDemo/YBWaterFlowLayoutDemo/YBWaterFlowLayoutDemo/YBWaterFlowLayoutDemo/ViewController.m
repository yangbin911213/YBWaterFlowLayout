//
//  ViewController.m
//  YBWaterFlowLayoutDemo
//
//  Created by yangbin on 2017/6/16.
//  Copyright © 2017年 yangbin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UICollectionView *mCollectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UICollectionView *)mCollectionView {
    
    if (!_mCollectionView) {
        MemoryFlowLayout *flowLayout = [[MemoryFlowLayout alloc] init];
        flowLayout.delegate = self;
        _mCollectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
        _mCollectionView.delegate = self;
        _mCollectionView.dataSource = self;
        _mCollectionView.backgroundColor = RGBCOLOR(255, 251, 251);
        [_mCollectionView registerClass:[MemoryCollectionViewCell class] forCellWithReuseIdentifier:kMemoryCollectionViewCell_Identifier];
        
    }
    return _mCollectionView;
}


@end
