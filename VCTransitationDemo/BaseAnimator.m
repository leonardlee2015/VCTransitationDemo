//
//  Animator.m
//  VCTransitationDemo
//
//  Created by 李南 on 15/7/29.
//  Copyright (c) 2015年 ctd.leonard. All rights reserved.
//

#import "BaseAnimator.h"

@interface BaseAnimator ()
@property (copy, nonatomic) void (^animations)();
/**
 *  an option idicate how the animations transition orientation.
 */

@end
@implementation BaseAnimator

-(instancetype)initWithAnimationOption:(AnimationOrientation)option{
    self = [super init];
    if (self) {
        self.option = option;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.4f;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    // get transition VCs.
    //UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // set toVC's view start position.
    CGRect finalRect = [transitionContext finalFrameForViewController:toVC];
    switch (self.option) {
        case AnimationOrientationHorizontalLeft:{
            toVC.view.frame = CGRectOffset(finalRect, -finalRect.size.width, 0);
            break;
        }
        case AnimationOrientationHorizontalRight:{
            toVC.view.frame = CGRectOffset(finalRect, finalRect.size.width, 0);
            break;
        }
        case AnimationOrientationVerticalUp:{
            toVC.view.frame = CGRectOffset(finalRect, 0, finalRect.size.height);
            break;
        }
        case AnimationOrientationVerticalDown:{
            toVC.view.frame = CGRectOffset(finalRect, 0, -finalRect.size.height);
            break;
        }
        default:
            break;
    }


    
    // iOS will add fromVC'view to containerView automatically, but toVC's must add by yourself.
    UIView *containerView = transitionContext.containerView;
    [containerView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"%@", obj);
    }];
    [containerView addSubview:toVC.view];

    // perform transition animation.
    /*[UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
         usingSpringWithDamping:0.6f
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         toVC.view.frame = finalRect;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                         
                     }];
     */
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0f options:UIViewAnimationOptionCurveLinear
                     animations:^{
        toVC.view.frame = finalRect ;
                     }
                     completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
    
}
@end
