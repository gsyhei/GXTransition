# GXTransition
iOS常用转场动画（包括自定义和OC自带转场动画）
Commonly used transition animation in iOS. (including custom transition animation and objective-c own transition animation.)

# 喜欢就给个star哦，QQ：279694479。没工作无聊写点东西玩儿！

先上demo菜单效果（比较朴素，请别介意）
--

![](/GXAlert.gif '描述')


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

License
--
MIT

