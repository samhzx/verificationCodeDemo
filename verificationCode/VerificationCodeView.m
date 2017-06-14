//
//  VerificationCodeView.m
//  verificationCode
//
//  Created by sam on 16/9/9.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "VerificationCodeView.h"
//默认验证码个数
static NSInteger const codeCount = 4;
//默认干扰线条数
static NSInteger const disturbLineCount = 5;
//默认字体大小
static NSInteger const fontSize = 25.f;

@interface VerificationCodeView ()
//用来存储验证码字符串
@property (nonatomic, strong) NSString *verCode;
@end


IB_DESIGNABLE
@implementation VerificationCodeView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		self.fontSize = fontSize;
		self.codeCount = codeCount;
		self.disturbLineCount = disturbLineCount;
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.fontSize = fontSize;
		self.codeCount = codeCount;
		self.disturbLineCount = disturbLineCount;
	}
	return self;
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	NSArray *charArray = @[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z", @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
    
	CGContextRef context = UIGraphicsGetCurrentContext();
	//画背景颜色
	CGContextSetFillColorWithColor(context, randCGColor());
	CGContextFillRect(context, rect);

	NSMutableString *string = [NSMutableString string];
	//画随机字符串
	for (int i = 0; i < self.codeCount; i++) {
		NSString *c = charArray[arc4random_uniform((int)charArray.count)];
		[c drawAtPoint:CGPointMake(self.bounds.size.width / (self.codeCount * 1.f) * i + self.bounds.size.width / (self.codeCount * 2.f) - self.fontSize / 2, self.bounds.size.height / 2.f - self.fontSize / 2) withAttributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:self.fontSize], NSForegroundColorAttributeName:randUIColor() }];
		[string appendString:c];
	}
	//画干扰线
	for (int i = 0; i < self.disturbLineCount; i++) {
		CGContextSetLineWidth(context, 1);
		CGContextSetStrokeColorWithColor(context, randCGColor());
		CGContextMoveToPoint(context, arc4random_uniform(self.bounds.size.width), arc4random_uniform(self.bounds.size.height));
		CGContextAddLineToPoint(context, arc4random_uniform(self.bounds.size.width), arc4random_uniform(self.bounds.size.height));
		CGContextStrokePath(context);
	}
	self.verCode = string.copy;
}
//每次点击都重新生成验证码
- (void)touchesBegan:(NSSet <UITouch *> *)touches withEvent:(UIEvent *)event {
	[self setNeedsDisplay];
}

FOUNDATION_STATIC_INLINE CGColorRef randCGColor() {
	return randUIColor().CGColor;
}
//生成随机颜色
FOUNDATION_STATIC_INLINE UIColor *randUIColor() {
	float r = arc4random_uniform(255) / 255.f;
	float g = arc4random_uniform(255) / 255.f;
	float b = arc4random_uniform(255) / 255.f;
	return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

#pragma mark - setter
- (void)setCodeCount:(NSInteger)codeCount {
	_codeCount = codeCount;
	[self setNeedsDisplay];
}

- (void)setDisturbLineCount:(NSInteger)disturbLineCount {
	_disturbLineCount = disturbLineCount;
	[self setNeedsDisplay];
}

- (void)setFontSize:(NSInteger)fontSize {
	_fontSize = fontSize;
	[self setNeedsDisplay];
}

@end
