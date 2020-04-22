//
//  UIViewController+GXTransitionDelegate.h
//  GXTransitionSample
//
//  Created by Gin on 2020/4/4.
//  Copyright © 2020 gin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GXAnimationBaseDelegate.h"

/**
 * 自定义转场风格(present/push)
 */
typedef NS_ENUM(NSUInteger, GXAnimationStyle) {
    /**如push一致的平移转场*/
    GXAnimationStylePush = 0,
    /**当前视图scale，目标视图平移（横向向左）*/
    GXAnimationStylePushEdgeLeft,
    /**当前视图与目标视图同时平移（横向向左）*/
    GXAnimationStylePushAllLeft,
    /**当前视图与目标视图同时平移（纵向向上）*/
    GXAnimationStylePushAllTop,
    /**当前视图与目标视图同时平移（纵向向下）*/
    GXAnimationStylePushAllBottom,
    /**目标视图扇形旋转*/
    GXAnimationStyleSector,
    /**目标视图扇侧立遮盖*/
    GXAnimationStyleErect,
    /**当前视图与目标视图呈立方体旋转（横向）*/
    GXAnimationStyleCube,
    /**当前视图与目标视图呈正反面旋转（横向）*/
    GXAnimationStyleOglFlip,
};

/**
 * 系统自带转场风格（present/push）
 */
typedef NS_ENUM(NSUInteger, GXTransitionStyle) {
    GXTransitionStyleFade = 0,       // 不支持subtype
    GXTransitionStylePush,
    GXTransitionStyleMoveInReveal,
    GXTransitionStyleCube,
    GXTransitionStyleOglFlip,
    GXTransitionStylePageCurl,
    GXTransitionStyleCameralIris,    // 不支持subtype
    GXTransitionStyleSuckEffect,     // 不支持subtype
    GXTransitionStyleRippleEffect,   // 不支持subtype
};

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (GXTransitionDelegate)

@property (nonatomic, strong) GXAnimationBaseDelegate *gx_animatedDelegate;

- (void)gx_pushViewController:(UIViewController *)viewController style:(GXAnimationStyle)style interacting:(BOOL)interacting;

- (void)gx_presentViewController:(UIViewController *)viewControllerToPresent style:(GXAnimationStyle)style interacting:(BOOL)interacting completion:(void (^ __nullable)(void))completion;

- (void)gx_pushViewController:(UIViewController *)viewController style:(GXTransitionStyle)style subtype:(nullable CATransitionSubtype)subtype interacting:(BOOL)interacting;

- (void)gx_presentViewController:(UIViewController *)viewControllerToPresent style:(GXTransitionStyle)style subtype:(nullable CATransitionSubtype)subtype interacting:(BOOL)interacting completion:(void (^ __nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END
