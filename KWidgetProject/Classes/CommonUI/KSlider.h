//
//  KSlider.h
//  AFNetworking
//
//  Created by Xunlei on 2021/9/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KSlider : UIView
// line height default  5
@property (nonatomic, assign) NSInteger lineHeight;
// slider line Color    default Black
@property (nonatomic, strong) UIColor *lineColor;
// enable Color         default White
@property (nonatomic, strong) UIColor *enableColor;

@end

NS_ASSUME_NONNULL_END
