//
//  VerticalLabel.m
//  AHDMVP
//
//  Created by ihotdo on 16/1/8.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "VerticalLabel.h"

@implementation VerticalLabel

+(VerticalLabel *)verticalLabel:(UIFont *)font color:(UIColor *)color
{
    VerticalLabel * label = [[self alloc] init];
    label.textColor = color;
    label.font = font;
    return label;
}


-(void)setLabelText:(NSString *)labelText
{
    if (_labelText != labelText) {
        _labelText = labelText;
        [self setNeedsDisplay];
    }
}

-(void)setTitleImageName:(NSString *)imageName
{
    if (_flagImageView == nil) {
        _flagImageView = [[UIImageView alloc] initWithFrame:(CGRect){5,_top,20,20}];
        [self addSubview:_flagImageView];
        _flagImageView.backgroundColor = [UIColor blackColor];
    }
    _top = CGRectGetHeight(_flagImageView.frame) + 3;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _top = 3;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    NSString * content = _labelText;
    float y = _top + 3;

    float x = 5;
    
    float lineSpace = 2;
    
    //修正英文字母过宽问题
    float enSpace = 9;
    
    NSArray * cnArr = @[@"（",@"）",@"—"];
    NSArray * enArr = @[@"(",@")"];

    //获取数字，两个相连数字同行显示
    NSString * match = @"(\\d+)"; //(\\d+)   [^0-9]
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:match options:0 error:nil];
    NSArray<NSTextCheckingResult *> * results =  [regex matchesInString:content options:NSMatchingReportCompletion range:(NSRange){0,content.length}];
    
    NSMutableArray * indexs = [[NSMutableArray alloc]init];
    for (NSTextCheckingResult * result in results) {
        if (result.range.length == 2) {
            //两个数字相连
            [indexs addObject:[NSNumber numberWithInteger:result.range.location]];
        }
        NSString * subString = [content substringWithRange:result.range];
        NSLog(@"sub is %@",subString);
    }
    
    CGSize formSize =  [@"字" boundingRectWithSize:(CGSize){40,40} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_font} context:nil].size;

  
    
    for (int i = 0; i < content.length; i ++) {
        
        NSInteger length = 1;
        if ([indexs containsObject:[NSNumber numberWithInteger:i]]) {
            //判断是否是两个数字的index，需要读取两个字符
            length = 2;
        }
        
        NSString * str = [content substringWithRange:(NSRange){i,length}];
        
        //判断字符串的字节
       const char * s = [str cStringUsingEncoding:NSUTF8StringEncoding];

        size_t bytesLength = strlen(s);
        
       CGSize size =  [str boundingRectWithSize:(CGSize){40,40} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_font} context:nil].size;

        NSDictionary * attributes = @{NSFontAttributeName:_font,NSForegroundColorAttributeName:[UIColor redColor]};
        
        unichar char_ = [str characterAtIndex:0];
        
         if ([enArr containsObject:str] || (char_ > 'a' && char_ < 'z') || (char_ > 'A' && char_ < 'Z')){
            //英文符号
            CGFloat maxL = MAX(size.width,size.height);
            UIImage * image = [self imageWithString:str size:CGSizeMake(maxL,maxL) fontNumber:_font.pointSize color:[attributes objectForKey:NSForegroundColorAttributeName]];
            [image drawInRect:(CGRect){x-0,y,CGSizeMake(maxL,maxL)}];
            size.height -= enSpace;
         }else if ([cnArr containsObject:str]) {
             //中文符号
             UIImage * image = [self imageWithString:str size:CGSizeMake(MAX(size.width, [UIFont boldSystemFontOfSize:16].lineHeight),size.height) fontNumber:16 color:[attributes objectForKey:NSForegroundColorAttributeName]];
             [image drawInRect:(CGRect){x,y,size}];
         }else{
            [str drawAtPoint:(CGPoint){x + (formSize.width - size.width)/2,y} withAttributes:attributes];
        }
        if ([str isEqualToString:@" "]) {
            size.height -= enSpace;
        }
        //修正一个字符时(数字，英文字符等) 间隔过大的问题
        CGFloat margin = ((bytesLength == 1)?(size.height - size.width)/3:0);

        y += size.height  + lineSpace - margin ;
        
        if (length == 2) {
            i ++;
        }
        
        if (i < content.length) {
            NSString * laterStr = [content substringWithRange:(NSRange){i + 1,content.length - i - 1}];
            
            CGSize laterSize =  [laterStr boundingRectWithSize:(CGSize){40,40} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_font} context:nil].size;
            
            
            //因为 ··· 会占一个多字的高度，所以需要从最后两个字的时候就考虑是否有足够多的高度
            if (y > rect.size.height - MAX(15*2, laterSize.width) - lineSpace && content.length > i + 2) {
                //过长则添加省略号
                NSString * dotString = @"···";
                for (int j = 0; j < dotString.length;j ++){
                    NSString * strj = [dotString substringWithRange:(NSRange){j,1}];
                    CGSize sizej =  [strj boundingRectWithSize:(CGSize){40,40} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_font} context:nil].size;
                    [strj drawAtPoint:(CGPoint){x + (formSize.width - sizej.width)/2,y} withAttributes:attributes];
                    y+=sizej.height - 11;
                }
                //已超出view的height
                break;
            }
        }
        
    }
}


- (UIImage *)imageWithString:(NSString *)str size:(CGSize)size fontNumber:(float)number color:(UIColor *)color
{
    
    NSInteger scale = [UIScreen mainScreen].scale;
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
