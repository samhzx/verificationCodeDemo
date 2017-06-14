//
//  VerificationCodeView.h
//  verificationCode
//
//  Created by sam on 16/9/9.
//  Copyright © 2016年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerificationCodeView : UIView
@property (nonatomic, strong, readonly) NSString *verCode;//结果字符串

@property (assign, nonatomic) IBInspectable NSInteger codeCount;//字符总数
@property (assign, nonatomic) IBInspectable NSInteger disturbLineCount;//干扰线总数
@property (assign, nonatomic) IBInspectable NSInteger fontSize;//字符字体大小
@end
