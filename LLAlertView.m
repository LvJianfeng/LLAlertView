//
//  LLAlertView.m
//
//  Created by LvJianfeng on 16/8/16.
//  Copyright © 2016年 LvJianfeng. All rights reserved.
//

#import "LLAlertView.h"
//#import "LineView.h"

@interface LLAlertView()
@property (strong, nonatomic) UIView *blackAlphaView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *messageLabel;
@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) UIButton *otherButton;

@property (strong, nonatomic) UIView *verticallyLineView;
@property (strong, nonatomic) UIView *horizontallyLineView;

//Custom Padding && Font
@property (assign, nonatomic) CGFloat titleFont;
@property (assign, nonatomic) CGFloat messageFont;

@property (assign, nonatomic) CGFloat cancelButtonFont;
@property (assign, nonatomic) CGFloat otherButtonFont;

@property (assign, nonatomic) CGFloat titleHeight;
@property (assign, nonatomic) CGFloat titleTopPadding;

@property (assign, nonatomic) CGFloat titleBottomPadding;
@property (assign, nonatomic) CGFloat messageBottomPadding;

@end

@implementation LLAlertView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        // Init
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(nonnull NSString *)cancelButtonTitle otherButtonTitle:(nonnull NSString *)otherButtonTitle{
    
    self = [super initWithFrame:CGRectMake(0, 0, ALERT_WIDTH, ALERT_HEIGHT)];
    if (self) {
        //Default
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.titleColor = ll_ColorWithRGB(0x333333);
        self.messageColor = ll_ColorWithRGB(0x999999);
        self.cancelButtonTitleColor = ll_ColorWithRGB(0x999999);
        self.otherButtonTitleColor = ll_ColorWithRGB(0x333333);
        self.contentViewBackgroundColor = [UIColor whiteColor];
        self.buttonViewBackgroundColor = [UIColor whiteColor];
        self.verticallyLineColor = ll_ColorWithRGB(0xcccccc);
        self.horizontallyLineColor = ll_ColorWithRGB(0xcccccc);
        
        // Params
        self.title = title;
        self.message = message;
        self.cancelButtonTitle = cancelButtonTitle;
        self.otherButtonTitle = otherButtonTitle;

        //Custom
        self.titleFont = 16.f;
        self.messageFont = 15.f;
        self.cancelButtonFont = 16.f;
        self.otherButtonFont = 16.f;
        self.titleHeight = 20.f;
        self.titleTopPadding = 14.f;
        self.titleBottomPadding = 22.f;
    }
    
    return self;
}

- (void)configUI{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.text = self.title;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = self.titleColor;
    self.titleLabel.font = [UIFont systemFontOfSize:self.titleFont];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    
    self.messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.text = self.message;
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.messageLabel.textColor = self.messageColor;
    self.messageLabel.font = [UIFont systemFontOfSize:self.messageFont];
    self.messageLabel.backgroundColor = [UIColor clearColor];
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.backgroundColor = [UIColor clearColor];
    [self.cancelButton setTitleColor:self.cancelButtonTitleColor forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:self.cancelButtonFont];
    [self.cancelButton setTitle:self.cancelButtonTitle forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.otherButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.otherButton.backgroundColor = [UIColor clearColor];
    [self.otherButton setTitleColor:self.otherButtonTitleColor forState:UIControlStateNormal];
    self.otherButton.titleLabel.font = [UIFont systemFontOfSize:self.otherButtonFont];
    [self.otherButton setTitle:self.otherButtonTitle forState:UIControlStateNormal];
    [self.otherButton addTarget:self action:@selector(otherClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.verticallyLineView = [[UIView alloc] initWithFrame:CGRectZero];
    self.verticallyLineView.backgroundColor = self.verticallyLineColor;
    
    self.horizontallyLineView = [[UIView alloc] initWithFrame:CGRectZero];
    self.horizontallyLineView.backgroundColor = self.horizontallyLineColor;
}

- (void)show{
    UIView *window = [[UIApplication sharedApplication] delegate].window;
    self.blackAlphaView = [[UIView alloc] initWithFrame:window.bounds];
    self.blackAlphaView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    
    [window addSubview:self.blackAlphaView];
    
    [self showSubViews: window];
}

- (void)showSubViews:(UIView *)view{
    
    [self configUI];
    
    self.frame = CGRectMake((view.frame.size.width - self.frame.size.width )/2, (view.frame.size.height - self.frame.size.height) /2, ALERT_WIDTH, ALERT_HEIGHT);
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ALERT_WIDTH, ALERT_HEIGHT-ALERT_BOTTOM_HEIGHT)];
    contentView.backgroundColor = self.contentViewBackgroundColor;
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(contentView.frame), ALERT_WIDTH, ALERT_BOTTOM_HEIGHT)];
    bottomView.backgroundColor = self.buttonViewBackgroundColor;
    
    [self addSubview:contentView];
    [self addSubview:bottomView];
    
    [self configContentView: contentView];
    [self configBottomView: bottomView];
    
    [view addSubview:self];
    
    self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    self.alpha = .6;
    [UIView animateWithDuration:.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
        
    } completion:nil];
}

- (void)configContentView: (UIView *)view{
    if (self.message && self.message.length>0) {
        self.titleLabel.frame = CGRectMake(0, self.titleTopPadding, ALERT_WIDTH, self.titleHeight);
        self.messageLabel.frame = CGRectMake(0, view.frame.size.height-22-self.titleHeight, ALERT_WIDTH, self.titleHeight);
    }else{
        self.titleLabel.frame = CGRectMake(0, (ALERT_HEIGHT-ALERT_BOTTOM_HEIGHT) * 0.5 - self.titleHeight * 0.5, ALERT_WIDTH, self.titleHeight);
    }
    
    
    [view addSubview:self.titleLabel];
    [view addSubview:self.messageLabel];
}

- (void)configBottomView: (UIView *)view{
    self.horizontallyLineView.frame = CGRectMake(0, 0, ALERT_WIDTH, .5);
    self.verticallyLineView.frame = CGRectMake(ALERT_WIDTH * .5, 0, .5, ALERT_BOTTOM_HEIGHT);
    
    self.cancelButton.frame = CGRectMake(0, 0, ALERT_WIDTH*.5, ALERT_BOTTOM_HEIGHT);
    self.otherButton.frame = CGRectMake(ALERT_WIDTH*.5, 0, ALERT_WIDTH*.5, ALERT_BOTTOM_HEIGHT);
    
    [view addSubview:self.horizontallyLineView];
    [view addSubview:self.verticallyLineView];
    [view addSubview:self.cancelButton];
    [view addSubview:self.otherButton];
}

- (void)dismiss{
    self.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:.02 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
        
    } completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
    
    if (self.blackAlphaView) {
        [UIView animateWithDuration:.2 animations:^{
            self.blackAlphaView.alpha = 0;
        } completion:^(BOOL finished) {
            [self.blackAlphaView removeFromSuperview];
        }];
    }
}

- (void)cancelClicked{
    [self dismiss];
    
    if ([self.delegate respondsToSelector:@selector(cancelClicked)]) {
        [self.delegate cancelClicked];
    }
}

- (void)otherClicked{
    [self dismiss];
    
    if (self.clickActionBlock) {
        self.clickActionBlock();
    }
    
    if ([self.delegate respondsToSelector:@selector(otherClicked)]) {
        [self.delegate otherClicked];
    }
}
@end
