//
//  AHDActivityViewController.m
//  AHDMVP
//
//  Created by ihotdo on 16/1/5.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "AHDActivityViewController.h"
#import "AHDCollectionControl.h"
#import "AHDActivityHelper.h"

@interface AHDActivityViewController ()<AHDCollectionControlDelegate>
{
    AHDCollectionControl *  _collectionControl;
}
@end

@implementation AHDActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect rect = self.view.bounds;
    rect.origin.y = 64;
    rect.size.height -= 64;
    _collectionControl = [[AHDCollectionControl alloc] initWithFrame:rect helperModel:[[AHDActivityHelper alloc] init]];
    _collectionControl.refreshType = AHDRefreshTypeRefreshAndLoading;
    _collectionControl.itemSize = CGSizeMake(rect.size.width, 100);
    _collectionControl.delegate =  self;
    _collectionControl.collectionEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [self.view addSubview:_collectionControl];
    
    _collectionControl.beginRefreshing = YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor redColor];
}

- (NSArray * )getData
{
    NSMutableArray * data = [[NSMutableArray alloc] init];
    for (int i = 0; i < 12; i ++) {
        [data addObject:@""];
    }
    return data;
}

-(void)collectionControl:(AHDCollectionControl *)collectionControl requestPage:(NSInteger)page
{
    NSLog(@"刷新 page %d",page);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_collectionControl setControlData:[self getData] page:page];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
