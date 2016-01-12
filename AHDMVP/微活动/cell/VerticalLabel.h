//
//  VerticalLabel.h
//  AHDMVP
//
//  Created by ihotdo on 16/1/8.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerticalLabel : UIView
{
    NSInteger _top;
    UIImageView     * _flagImageView;
}

/**
 *  设置字体大小
 */
@property (nonatomic, strong)UIFont * font;

@property (nonatomic, strong)UIColor * textColor;

@property (nonatomic, strong)NSString * labelText;

/**
 *  设置标志图标
 *
 *  @param imageName
 */
- (void)setTitleImageName:(NSString *)imageName;

+ (VerticalLabel *)verticalLabel:(UIFont *)font color:(UIColor *)color;

@end
