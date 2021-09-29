//
//  UIView+KExtension.h
//  KWidgetProject
//
//  Created by Kcl on 2021/9/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (KExtension)


@property (nonatomic, assign) CGFloat left;

@property (nonatomic, assign) CGFloat top;

@property (nonatomic, assign) CGFloat right;

@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat centerX;

@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, assign) CGSize size;

/**
 设左上角坐标
 */
- (void)setLeft:(CGFloat)left top:(CGFloat)top;

/**
 设左下角坐标
 */
- (void)setLeft:(CGFloat)left bottom:(CGFloat)bottom;

/**
 设右上角坐标
 */
- (void)setRight:(CGFloat)right top:(CGFloat)top;

/**
 设右下角坐标
 */
- (void)setRight:(CGFloat)right bottom:(CGFloat)bottom;

- (void)removeAllSubviews;

- (void)setStringTag:(NSString *)stringTag;
- (NSString *)stringTag;

- (UIImage *)snapshotImage;

- (UIImage *)capture;

- (UIImage *)launchViewSnapshotImage;

- (CAGradientLayer *)gradientLayer;
- (void)setGradientLayer:(CAGradientLayer *)gradientLayer;
/// 设置渐变背景，需要提前设置好frame
- (void)setHorizontalGradientBackgroundColor:(UIColor *)from to:(UIColor *)to;
- (void)setVerticalGradientBackgroundColor:(UIColor *)from to:(UIColor *)to;

- (void)keepCenterAndApplyAnchorPoint:(CGPoint)point;

@end

NS_ASSUME_NONNULL_END
