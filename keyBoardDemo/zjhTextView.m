//
//  zjhTextView.m
//  test
//
//  Created by Queen_B on 2016/11/16.
//  Copyright © 2016年 Queen_B. All rights reserved.
//

#import "zjhTextView.h"

@interface zjhTextView ()
@property (nonatomic,assign)NSInteger textH;
@property (nonatomic,assign)NSInteger MaxTitleH;

@end
@implementation zjhTextView
-(instancetype)init{
    if (self = [super init]) {
        [self setUp];
    }
    return self;
}
- (void)setUp{
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.scrollEnabled = NO;
    self.scrollsToTop = NO;
    self.enablesReturnKeyAutomatically = YES;
    self.layer.borderWidth = 1;
    self.font = [UIFont systemFontOfSize:14];
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textValueChanged) name:UITextViewTextDidChangeNotification object:self];
    
}

-(void)setTextHeightChangeBlock:(void (^)(NSString *, CGFloat))textHeightChangeBlock{
    _textHeightChangeBlock = textHeightChangeBlock;
    [self textValueChanged];
}
- (void)textValueChanged{
    // 通过ceilf函数计算出最大的高度.ceilf函数与ceil函数的不同在于参数一个是float,一个是double.
    // sizeThatFits:返回一个最合适的size.并不会改变实际的大小,而是返回一个最合适的值.也就是说.给 self 找到一个最合适后面参数size的size.就像你去用布做窗帘,要多大的窗帘呢?商店的布是后面的参数,宽度指定,高度无限大.你通过sizeThatFits这把尺子,就能返回给你一个最合适你家高度的窗帘.然后拿到这个个高度.
    NSLog(@"进入textValueChanged");
//    NSInteger height = ceilf([self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)].height);
//    // 比较最合适的高度和通过最大行数算出的高度.相同则可以滚动,不同则拉伸textView
//    if (_textH != height) {
////        if (height > _MaxTitleH &&_MaxTitleH > 0) {
////            self.scrollEnabled = YES;
////        }
//        // 当高度大于最大高度时，需要滚动
//        self.scrollEnabled = height > _MaxTitleH && _MaxTitleH > 0;
//        _textH = height;
//        
//        //当不可以滚动（即 <= 最大高度）时，传值改变textView高度
//        if (_textHeightChangeBlock && self.scrollEnabled == NO) {
//            _textHeightChangeBlock(self.text,height);
//            NSLog(@"textView的textValueChanged方法");
//            [self.superview layoutIfNeeded];
//        }
//    }
    NSLog(@"进入textValueChanged");
    
    NSInteger height = ceilf([self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)].height);
    
    if (_textH != height) { // 高度不一样，就改变了高度
        
        // 最大高度，可以滚动
        self.scrollEnabled = height > _MaxTitleH && _MaxTitleH > 0;
        
        _textH = height;
        
        if (_textHeightChangeBlock && self.scrollEnabled == NO) {
            _textHeightChangeBlock(self.text,height);
            [self.superview layoutIfNeeded];
            //            self.placeholderView.frame = self.bounds;
        }
    }

}
-(void)setCornerRadius:(NSInteger)cornerRadius{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = _cornerRadius;
}
-(void)setMaxNumOfLines:(NSInteger)maxNumOfLines{
    _maxNumOfLines = maxNumOfLines;
    // 根据给定的最大行数计算出最大允许的高度.当超出这个高度时,就可以滚动textView.小于这个高度时,textView高度增加.
    // 使用ceil函数拿到最大值,ceil() 方法执行的是向上取整计算,它返回的是大于或等于函数参数.每行的高度*最大行数 + 顶部 + 底部间距.
    _MaxTitleH = ceil(self.font.lineHeight * maxNumOfLines + self.textContainerInset.top + self.textContainerInset.bottom);
    NSLog(@"lineH:%zd",self.font.lineHeight);
    NSLog(@"最多行数:%zd,最高度:%ld",maxNumOfLines,(long)_MaxTitleH);
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
