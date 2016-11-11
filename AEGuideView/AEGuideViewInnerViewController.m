//
//  AEGuideViewInnerViewController.m
//  AEGuideViewDemo
//
//  Created by WangLin on 2016/11/11.
//  Copyright © 2016年 amberease. All rights reserved.
//

#import "AEGuideViewInnerViewController.h"
#import "AEGuideViewInnerCollectionViewCell.h"



@interface AEGuideViewInnerViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
{
}

@property (nonatomic,strong) UIPageControl* pageControl;
@property (nonatomic,strong) UICollectionView* collectionView;

@end

@implementation AEGuideViewInnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupCollectionView];
    [self setupPageControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.images count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AEGuideViewInnerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier_AEGuideViewCell forIndexPath:indexPath];
    
    UIImage *img = [self.images objectAtIndex:indexPath.row];
    CGSize size = [self adapterSizeImageSize:img.size compareSize:kAEGuideViewBounds.size];
    
    //自适应图片位置,图片可以是任意尺寸,会自动缩放.
    cell.imageView.frame = CGRectMake(0, 0, size.width, size.height);
    cell.imageView.image = img;
    cell.imageView.center = CGPointMake(kAEGuideViewBounds.size.width / 2, kAEGuideViewBounds.size.height / 2);
    
    if (indexPath.row == self.images.count - 1) {
        [cell.button setHidden:NO];
        [cell.button addTarget:self action:@selector(nextButtonHandler:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button setBackgroundColor:self.buttonBgColor];
        [cell.button setTitle:self.buttonTitle forState:UIControlStateNormal];
        [cell.button setTitleColor:self.titleColor forState:UIControlStateNormal];
        cell.button.layer.borderColor = [self.buttonBorderColor CGColor];
    } else {
        [cell.button setHidden:YES];
    }
    
    return cell;
}

/**
 *  计算自适应的图片
 *
 *  @param is 需要适应的尺寸
 *  @param cs 适应到的尺寸
 *
 *  @return 适应后的尺寸
 */
- (CGSize)adapterSizeImageSize:(CGSize)is compareSize:(CGSize)cs
{
    CGFloat w = cs.width;
    CGFloat h = cs.width / is.width * is.height;
    
    if (h < cs.height) {
        w = cs.height / h * w;
        h = cs.height;
    }
    return CGSizeMake(w, h);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    self.pageControl.currentPage = (scrollView.contentOffset.x / kAEGuideViewBounds.size.width);
}

/**
 *  点击立即体验按钮响应事件
 *
 *  @param sender sender
 */
- (void)nextButtonHandler:(id)sender {
    /*
    [self.pageControl removeFromSuperview];
    [self.view removeFromSuperview];
    [self setView:nil];
    [self setPageControl:nil];
    //*/
    if(self.completion){
        self.completion();
    }
}


#pragma mark - Help Methods
-(void)setupCollectionView{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = kAEGuideViewBounds.size;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:kAEGuideViewBounds collectionViewLayout:layout];
    _collectionView.bounces = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.pagingEnabled = YES;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    [_collectionView registerClass:[AEGuideViewInnerCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier_AEGuideViewCell];
    
    [self.view addSubview:_collectionView];
    
}


-(void)setupPageControl{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.frame = CGRectMake(0, 0, kAEGuideViewBounds.size.width, 44.0f);
        _pageControl.center = CGPointMake(kAEGuideViewBounds.size.width / 2, kAEGuideViewBounds.size.height - 60);
        
        _pageControl.numberOfPages = self.images.count;
        
        [self.view addSubview:_pageControl];
    }

}
@end
