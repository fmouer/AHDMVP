//
//  CellMemberView.h
//  AHDMVP
//
//  Created by ihotdo on 16/1/11.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AHDUserModel.h"

typedef void (^SelectedMember)(AHDUserModel * userModel);

@interface CellMemberView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *   _tableView;
}

@property (nonatomic, strong)NSArray * members;

@property (nonatomic, copy)SelectedMember  selectedMemberBlock;

@end


