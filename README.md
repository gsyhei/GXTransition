# GXTransition
iOS常用转场动画（包括自定义和OC自带转场动画）
Commonly used transition animation in iOS. (including custom transition animation and objective-c own transition animation.)

备注：开发这一些列分类皆在于提高开发的效率以及改善代码的可读性和重用性，以此献上共勉！

# 喜欢就给个star哦，QQ：279694479。没工作无聊写点东西玩儿！

先上个效果图
--

![](/GXTransition.gif)


Requirements
--
- iOS 7.0 or later
- Xcode 9.0 or later

Usage in you Podfile:
--

```
pod 'GXTransition'
```

使用方法
--
首先#import "UIViewController+GXTransitionDelegate.h"，然后直接使用扩展方法就行，是不是很简单😁。

```objc

- (void)gx_pushViewController:(UIViewController *)viewController style:(GXAnimationStyle)style interacting:(BOOL)interacting;

- (void)gx_presentViewController:(UIViewController *)viewControllerToPresent style:(GXAnimationStyle)style interacting:(BOOL)interacting completion:(void (^ __nullable)(void))completion;

- (void)gx_pushViewController:(UIViewController *)viewController style:(GXTransitionStyle)style subtype:(CATransitionSubtype)subtype interacting:(BOOL)interacting;

```

支持的转场动画类型
--

```objc

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
 * 系统自带转场风格（only push）
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

```

License
--
MIT

