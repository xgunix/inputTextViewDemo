//
//  zjhTextView.h
//  test
//
//  Created by Queen_B on 2016/11/16.
//  Copyright © 2016年 Queen_B. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface zjhTextView : UITextView
// 最大行数
@property (nonatomic,assign)NSInteger maxNumOfLines;
// cornerRadius
@property (nonatomic,assign)NSInteger cornerRadius;
// 用于传值的block
@property (nonatomic, strong) void(^textHeightChangeBlock)(NSString *text,CGFloat textHeight);

@end
