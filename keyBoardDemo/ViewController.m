//
//  ViewController.m
//  keyBoardDemo
//
//  Created by Queen_B on 2016/11/16.
//  Copyright © 2016年 xxxx. All rights reserved.
//

#import "ViewController.h"
#import "zjhTextView.h"
#import <Masonry.h>

@interface ViewController ()
@property (nonatomic,strong)zjhTextView *textView2;
@property (nonatomic,strong)UIView *containerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupViews];
    // 监听键盘的出现和消失.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
}
- (void)keyboardWillChangeFrame:(NSNotification *)notification{
    // 获取键盘frame
    CGRect endFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 获取键盘弹出时长
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    // 创建遮罩btn
    UIButton *shieldBtn = [[UIButton alloc]init];
    [self.view addSubview:shieldBtn];
    [shieldBtn addTarget:self action:@selector(shieldViewAct) forControlEvents:UIControlEventTouchUpInside];
    [shieldBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.containerView.mas_top);
    }];
    // 修改底部视图距离底部的间距
    CGFloat tempHeight = endFrame.origin.y != screenH?endFrame.size.height:0;
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-tempHeight);
    }];
    // 约束动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
    
}
- (void)shieldViewAct{
    [self.textView2 resignFirstResponder];
}
- (void)setupViews{
    // 底层view
    self.containerView = [[UIView alloc]init];
    self.containerView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.equalTo(@44);
    }];
    // voiceBtn
    UIButton *voiceBtn = [[UIButton alloc]init];
    [self.containerView addSubview:voiceBtn];
    [voiceBtn setImage:[UIImage imageNamed:@"sound.png"] forState:UIControlStateNormal];
    [voiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        // 根据要求设定btn的约束,这里设定是btn固定在contentView的顶部
        make.left.equalTo(self.containerView.mas_left).offset(5);
        make.top.equalTo(self.containerView.mas_top).offset(5);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    // textView
    self.textView2 = [[zjhTextView alloc]init];
    self.textView2.cornerRadius = 5;
    self.textView2.maxNumOfLines = 5;
    
    __weak typeof(self) weakSelf = self;
    self.textView2.textHeightChangeBlock = ^(NSString *text,CGFloat height){
        NSLog(@"设定textVeiw2的block");
        // 传递过来的高度:height
        // 根据height调整contentView的高度约束,就能改变textView的高度
        [weakSelf changHeight:height];
    };
    
    [self.containerView addSubview:self.textView2];
    [self.textView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(voiceBtn.mas_right).offset(5);
        make.top.equalTo(self.containerView.mas_top).offset(5);
        make.bottom.equalTo(self.containerView.mas_bottom).offset(-5);
        make.right.equalTo(self.containerView.mas_right).offset(-75);
    }];
    // 笑脸btn
    UIButton *smileBtn = [[UIButton alloc]init];
    [smileBtn setImage:[UIImage imageNamed:@"smail.png"] forState:UIControlStateNormal];
    [self.containerView addSubview:smileBtn];
    [smileBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_textView2.mas_right).offset(5);
        make.top.equalTo(_containerView.mas_top).offset(5);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    // + btn
    UIButton *plusBtn = [[UIButton alloc]init];
    [self.containerView addSubview:plusBtn];
    [plusBtn setImage:[UIImage imageNamed:@"plus.png"] forState:UIControlStateNormal];
    [plusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(smileBtn.mas_top);
        make.right.equalTo(self.containerView.mas_right).offset(-5);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
}
- (void)changHeight:(CGFloat)height{
    NSLog(@"changeHeight方法");
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height + 10));
    }];
}
// 使输入框随键盘移动

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
