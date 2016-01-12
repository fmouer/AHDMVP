//
//  AHDMiniActivityViewController.m
//  AHDMVP
//
//  Created by ihotdo on 16/1/5.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "AHDMiniActivityViewController.h"
#import "AHDCollectionControl.h"
#import "AHDMiniActivityHelper.h"

@interface AHDMiniActivityViewController ()<AHDCollectionControlDelegate>
{
    AHDCollectionControl    * _collectionControl ;
}
@end

@implementation AHDMiniActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect rect = self.view.bounds;
    rect.origin.y = 64;
    rect.size.height -= 64;

    _collectionControl = [[AHDCollectionControl alloc] initWithFrame:rect helperModel:[[AHDMiniActivityHelper alloc] init]];
    
    _collectionControl.itemSize = CGSizeMake(rect.size.width/2, 350);
    _collectionControl.delegate =  self;
    [self.view addSubview:_collectionControl];

}

-(void)viewDidAppear:(BOOL)animated
{
    [_collectionControl setControlData:[self getData] page:0];
}


- (NSArray * )getData
{
    NSMutableArray * data = [[NSMutableArray alloc] init];
    NSDictionary * user = @{@"userId":@"1",@"imgUrl":@"image",@"sex":@"0",@"nameNote":@"fmouer",@"nickName":@"昵称"};
    
    for (int i = 0; i < 24; i ++) {
        [data addObject:@{@"time":@"2015-10-20",
                          @"address":@"海淀区上地五街",
                          @"title":@"my love",
                          @"tag":@"标签",
                          @"fee":@"1",
                          @"number":@"求105人",
                          @"creator":user,
                          @"member":@[user,user,user,user,user]}];
    }
    return data;
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
