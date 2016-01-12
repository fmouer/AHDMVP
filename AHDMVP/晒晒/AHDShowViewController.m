//
//  AHDShowViewController.m
//  AHDMVP
//
//  Created by ihotdo on 16/1/5.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "AHDShowViewController.h"
#import "AHDCollectionControl.h"
#import "AHDShowHelper.h"
#import "AHDHeaderModel.h"

@interface AHDShowViewController ()<AHDCollectionControlDelegate>
{
    AHDCollectionControl    * _collectionControl;
    
}
@end

@implementation AHDShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect rect = self.view.bounds;
    rect.origin.y = 64;
    rect.size.height -= 64;
    
    _collectionControl = [[AHDCollectionControl alloc] initWithFrame:rect helperModel:[[AHDShowHelper alloc] init]];
//    _collectionControl.itemSize = CGSizeMake(rect.size.width, 420);
    _collectionControl.delegate =  self;
    [self.view addSubview:_collectionControl];
    
    _collectionControl.sectionHeaderSize = CGSizeMake(rect.size.width, 250);

    
}

-(void)viewDidAppear:(BOOL)animated
{
    [_collectionControl setControlHeaderModel:[[AHDHeaderModel alloc] init]];
    [_collectionControl setControlData:[self getData] page:0];
}

- (NSArray * )getData
{
    NSMutableArray * data = [[NSMutableArray alloc] init];
    for (int i = 0; i < 24; i ++) {
        [data addObject:@{}];
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
