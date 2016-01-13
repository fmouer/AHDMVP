//
//  AHDModelProtocol.h
//  MVPDemo
//
//  Created by ihotdo on 15/12/28.
//  Copyright © 2015年 ihotdo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AHDModelProtocol <NSObject>

@required
/**
 *  获取UICollectionView 的cell identifier，注意：必须和cell 类名相同
 *
 *  @return cell类名的 NSString
 */
- (NSString *)cellIdentifier;


/**********
 *
 **该方法可通过runtime 编写一个通用类，读取类中的属性列表，从model中读取相对应的value
 *
 ***********/

/**
 *  通过modelInfo 设置初始化信息
 *
 *  @param modelInfo NSDictionary
 */
- (void)loadModelInfo:(NSDictionary *)modelInfo;

@optional


- (NSString *)updateFilterKeyPath;

@end
