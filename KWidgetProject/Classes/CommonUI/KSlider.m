//
//  KSlider.m
//  AFNetworking
//
//  Created by Xunlei on 2021/9/29.
//

#import "KSlider.h"

@interface KSlider()
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *indicatorView;
@end
@implementation KSlider

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self layoutUI];
    }
    
    return self;
}

- (void)layoutUI {
    
    CGRect frame = self.frame;
//    self.lineView = [UIView alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
}



@end
