//
//  ViewController.m
//  AHDMVP
//
//  Created by fmouer on 16/1/3.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSArray         *   _cellArrays;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"CollectionControl";
    
    _cellArrays =@[@{@"title":@"活动",@"class":@"AHDActivityViewController"},
                   @{@"title":@"晒晒",@"class":@"AHDShowViewController"},
                   @{@"title":@"微活动",@"class":@"AHDMiniActivityViewController"},
                   @{@"title":@"标签",@"class":@"AHDTagViewController"}];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cellArrays.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSDictionary * cellInfo = _cellArrays[indexPath.row];
    cell.textLabel.text = cellInfo[@"title"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary * cellInfo = _cellArrays[indexPath.row];
    NSString * className = cellInfo[@"class"];
    Class controllerClass = NSClassFromString(className);
    UIViewController * controller = [[controllerClass alloc] init];
    if (controller) {
        controller.view.backgroundColor = [UIColor whiteColor];
        controller.title = cellInfo[@"title"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
