//
//  VerticalLabel.m
//  AHDMVP
//
//  Created by ihotdo on 16/1/8.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "VerticalLabel.h"
#import <CoreText/CoreText.h>
static inline double radians (double degrees) {return degrees * M_PI/180;}

@implementation VerticalLabel
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
//        self.image = [VerticalLabel imageWithString:@"（" size:CGSizeMake(30, 30)];

    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //获取图形上下文
//    CGContextRef ctx=UIGraphicsGetCurrentContext();
////    CGContextRotateCTM(ctx, radians(70));
//    
//    CGContextTranslateCTM(ctx, rect.size.width/2, rect.size.height/2);
//    [@"测试旋转" drawAtPoint:(CGPoint){200,50} withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor redColor]}];
//    CGContextRotateCTM(ctx, radians(30));
//    
//  //渲染
//     CGContextStrokePath(ctx);
//
//    return;
    
    NSString * content = @"今天—是(星期五）";
    float y = 10;

    NSArray * signArr = @[@"(",@")",@"（",@"）",@"—",@"",@""];

    for (int i = 0; i < content.length; i ++) {
        
        
        NSString * str = [content substringWithRange:(NSRange){i,1}];
       CGSize size =  [str boundingRectWithSize:(CGSize){20,20} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]} context:nil].size;

        NSDictionary * attributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor redColor]};
        CGFloat margin = 0;
        
        if ([signArr containsObject:str] ) {
            if ([str isEqual:@"("]) {
                CGFloat maxL = MAX(size.width,size.height);
                margin = size.height - size.width;
                
                UIImage * image = [self imageWithString:str size:CGSizeMake(maxL,maxL) fontNumber:16 color:[attributes objectForKey:NSForegroundColorAttributeName]];
                [image drawInRect:(CGRect){100-1.5,y,CGSizeMake(maxL,maxL)}];
                size = CGSizeMake(maxL,maxL);
            }else{
                UIImage * image = [self imageWithString:str size:CGSizeMake(MAX(size.width, [UIFont boldSystemFontOfSize:16].lineHeight),size.height) fontNumber:16 color:[attributes objectForKey:NSForegroundColorAttributeName]];
                [image drawInRect:(CGRect){100,y,size}];

            }
        }else{
            [str drawAtPoint:(CGPoint){100,y} withAttributes:attributes];
 
        }
        
        y += size.height + 3 - margin;
    }
}

+ (UIImage *)imageWithString:(NSString *)str size:(CGSize)size
{
//    UIImage * aImage = [UIImage imageNamed:@"22"];

    CGContextRef ctx=UIGraphicsGetCurrentContext();
    UIGraphicsBeginImageContext(size);

    //矩阵操作
    //注意点：设置矩阵操作必须要在添加绘图信息之前
    //旋转45度
    CGContextRotateCTM(ctx, M_PI_4);
    
    //绘图
    //画四边形
//    CGContextAddRect(ctx, CGRectMake(150, 100, 100, 100));
    //画一个圆
//    CGContextAddEllipseInRect(ctx, CGRectMake(200, 200, 50, 50));
    //渲染
    CGContextStrokePath(ctx);
    UIImage * image3 = UIGraphicsGetImageFromCurrentImageContext();

    return image3;
    
    CGSize drectSize = CGSizeMake(size.width , size.height );

    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsBeginImageContext(drectSize);
    
    CGContextRotateCTM(context, M_PI_4);

    [str drawAtPoint:CGPointZero withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]}];
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformRotate(transform, M_PI_2);

//    CGContextConcatCTM(context, transform);
//    CGContextDrawImage(context, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);

//     CGContextRotateCTM(context, radius);
//    CGContextSaveGState(context);
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (UIImage *)imageWithString:(NSString *)str size:(CGSize)size fontNumber:(float)number color:(UIColor *)color
{
    
    NSInteger scale = 2;
    CGSize drectSize = CGSizeMake(size.width * scale , size.height * scale);
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsBeginImageContext(drectSize);
    [[UIColor blackColor] set];
    
    [str drawAtPoint:CGPointZero withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:number * scale],NSForegroundColorAttributeName:color}];
    
    CGContextSaveGState(context);
    
    
    UIImage * tmpImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
    CGRect rect = CGRectMake(0, 0, tmpImage.size.width, tmpImage.size.height);
    rect = CGRectApplyAffineTransform(rect, CGAffineTransformMakeRotation(M_PI_2));
    CGSize outputSize = CGSizeMake(CGRectGetWidth(rect), CGRectGetHeight(rect));
    
    
    
    UIGraphicsBeginImageContextWithOptions(outputSize, NO, 0);
    CGContextRef context0 = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context0, outputSize.width / 2, outputSize.height / 2);
    CGContextRotateCTM(context0, M_PI_2);
    CGContextTranslateCTM(context0, -tmpImage.size.width / 2, -tmpImage.size.height / 2);
    
    
    [[UIColor blackColor] set];
    [tmpImage drawInRect:CGRectMake(0, 0, tmpImage.size.width, tmpImage.size.height)];
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
