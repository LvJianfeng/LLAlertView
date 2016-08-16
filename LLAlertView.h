//
//  LLAlertView.h
//
//  Created by LvJianfeng on 16/8/16.
//  Copyright © 2016年 LvJianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ALERT_WIDTH 275
#define ALERT_HEIGHT 130
#define ALERT_BOTTOM_HEIGHT 43

#define ll_ColorWithRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

typedef void (^OtherClickBlock)();

@protocol LLAlertViewDelegate <NSObject>
@optional
- (void)cancelClicked;
- (void)otherClicked;
@end

@interface LLAlertView : UIView

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *cancelButtonTitle;
@property (strong, nonatomic) NSString *otherButtonTitle;

@property (strong, nonatomic) UIColor *titleColor;
@property (strong, nonatomic) UIColor *messageColor;

@property (strong, nonatomic) UIColor *cancelButtonTitleColor;
@property (strong, nonatomic) UIColor *otherButtonTitleColor;

@property (strong, nonatomic) UIColor *contentViewBackgroundColor;
@property (strong, nonatomic) UIColor *buttonViewBackgroundColor;

@property (strong, nonatomic) UIColor *verticallyLineColor;
@property (strong, nonatomic) UIColor *horizontallyLineColor;

@property (strong, nonatomic) OtherClickBlock clickActionBlock;

@property (nonatomic, strong) id<LLAlertViewDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle;

- (void)show;

- (void)dismiss;
@end
