//
//  UIView+KExtension.m
//  KWidgetProject
//
//  Created by Kcl on 2021/9/29.
//

#import "UIView+KExtension.h"
#import <objc/message.h>
@implementation UIView (KExtension)

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setLeft:(CGFloat)left top:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.x = left;
    frame.origin.y = top;
    self.frame = frame;
}

- (void)setLeft:(CGFloat)left bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.x = left;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (void)setRight:(CGFloat)right top:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    frame.origin.y = top;
    self.frame = frame;
}

- (void)setRight:(CGFloat)right bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (void)setStringTag:(NSString *)stringTag {
    objc_setAssociatedObject(self, @selector(stringTag), stringTag, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)stringTag {
    return objc_getAssociatedObject(self, @selector(stringTag));
}

- (UIImage *)snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshotImage;
}

- (UIImage *)launchViewSnapshotImage {
    CGFloat version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version < 11.0 || [UIView isX]) { // 区分系统和手机型号，不然会出现launch和截图不对应的
        return [self capture];
    }
    return [self captureShot];
}

+ (BOOL)isX {
    BOOL isiPhoneX = NO;
    if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        if (window.safeAreaInsets.bottom > 0.0) {
            isiPhoneX = YES;
        }
    }
    return isiPhoneX;
}

- (UIImage *)captureShot {
    CGRect screenRect = self.bounds;
    UIGraphicsBeginImageContextWithOptions(screenRect.size, false, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set];
    CGContextFillRect(ctx, screenRect);
    // transfer content into our context
    [self.layer renderInContext:ctx];
    UIImage *screengrab = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return screengrab;
}

- (UIImage *)capture {
    CGSize size = self.size;
    if(size.width < 1 || size.height < 1){
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    } else {
        // ios7下如果用此方法navigationBar会变黑
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshot;
}

- (void)setHorizontalGradientBackgroundColor:(UIColor *)from to:(UIColor *)to {
    CAGradientLayer *gradientLayer = [self gradientLayer];
    if (![self gradientLayer]) {
        gradientLayer = [CAGradientLayer layer];
    }
    gradientLayer.frame = self.bounds;
    gradientLayer.startPoint = CGPointMake(0, 0.5);
    gradientLayer.endPoint = CGPointMake(1, 0.5);
    gradientLayer.opacity = 1;
    gradientLayer.colors = @[(__bridge id)from.CGColor, (__bridge id)to.CGColor];
    [self.layer insertSublayer:gradientLayer atIndex:0];
    
    objc_setAssociatedObject(self, @selector(gradientLayer), gradientLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setVerticalGradientBackgroundColor:(UIColor *)from to:(UIColor *)to {
    CAGradientLayer *gradientLayer = [self gradientLayer];
    if (![self gradientLayer]) {
        gradientLayer = [CAGradientLayer layer];
    }
    gradientLayer.frame = self.bounds;
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 1);
    gradientLayer.opacity = 1;
    gradientLayer.colors = @[(__bridge id)from.CGColor, (__bridge id)to.CGColor];
    [self.layer insertSublayer:gradientLayer atIndex:0];
    
    objc_setAssociatedObject(self, @selector(gradientLayer), gradientLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CAGradientLayer *)gradientLayer {
    return objc_getAssociatedObject(self, @selector(gradientLayer));
}

- (void)setGradientLayer:(CAGradientLayer *)gradientLayer {
    objc_setAssociatedObject(self, @selector(gradientLayer), gradientLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)keepCenterAndApplyAnchorPoint:(CGPoint)point {
    if (CGPointEqualToPoint(self.layer.anchorPoint, point)) return;
    CGPoint newPoint = CGPointMake(self.bounds.size.width * point.x, self.bounds.size.height * point.y);
    CGPoint oldPoint = CGPointMake(self.bounds.size.width * self.layer.anchorPoint.x, self.bounds.size.height * self.layer.anchorPoint.y);
    newPoint = CGPointApplyAffineTransform(newPoint, self.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, self.transform);
    
    CGPoint c = self.layer.position;
    c.x -= oldPoint.x;
    c.x += newPoint.x;
    
    c.y -= oldPoint.y;
    c.y += newPoint.y;
    
    self.layer.position = c;
    self.layer.anchorPoint = point;
}

@end
