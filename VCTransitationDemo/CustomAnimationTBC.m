//
//  CustomAnimationTBC.m
//  VCTransitationDemo
//
//  Created by 李南 on 15/8/1.
//  Copyright (c) 2015年 ctd.leonard. All rights reserved.
//

#import "CustomAnimationTBC.h"
#import "BaseAnimator.h"
#import "BounceAnimator.h"
#import "SwipePercentIntercativeTransition.h"

#import "CEFoldAnimationController.h"

@interface BaseAnimator ()
@property (nonatomic, weak) UIViewController* fromVC;
@property (nonatomic, weak) UIViewController* toVC;
@end

@interface CustomAnimationTBC ()<UITabBarControllerDelegate>
@property(nonatomic, strong) SwipePercentIntercativeTransition *interactViewController;
@end

@implementation CustomAnimationTBC
{
    
    CEFoldAnimationController *_foldAnimationController;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    
    
    _foldAnimationController = [[CEFoldAnimationController alloc]init];
    _foldAnimationController.folds = 3;
   
    [self addObserver:self forKeyPath:@"selectedViewController" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionNew context:nil];
    
    self.interactViewController = [[SwipePercentIntercativeTransition alloc]initWithOperation:SwipeInteractionOperationTab];
    //self.interactViewController.isTabBarController = YES;
    //[self.interactViewController writeToViewController:[self.tabBarController.viewControllers objectAtIndex:0]];
    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"selectedViewController"]) {
       
        //NSLog(@"now title at vc: %@", self.selectedViewController.title);
        //[_swipIntrecationController wireToViewController:self.selectedViewController forOperation:CEInteractionOperationTab];
        [self.interactViewController writeToViewController:self.selectedViewController];
    }else{
        //NSLog(@"now title at idx: %@", self.selectedViewController.title);
        [self.interactViewController writeToViewController:self.selectedViewController];
        //[_swipIntrecationController wireToViewController:self.selectedViewController forOperation:CEInteractionOperationTab];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITabBarControllerDelegate
-(id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    NSInteger toVCIndex =  [tabBarController.viewControllers indexOfObject:toVC];
    NSInteger fromVCIndex = [tabBarController.viewControllers indexOfObject:fromVC];
    _foldAnimationController.reverse = fromVCIndex < toVCIndex;
    return _foldAnimationController;
    /*
    BaseAnimator *animator = [[BaseAnimator alloc]init];
    animator.toVC = toVC;
    if (fromVCIndex > toVCIndex) {
        //return [[BounceAnimator alloc]initWithAnimationOption:AnimationOrientationHorizontalLeft];
        animator.option = AnimationOrientationHorizontalRight;
        return animator;
    }
    else{
        //return [[BounceAnimator alloc]initWithAnimationOption:AnimationOrientationHorizontalRight];
        animator.option = AnimationOrientationHorizontalLeft;
        return animator;
    }
     */
    
}
-(id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
   
    return self.interactViewController.interacting? self.interactViewController:nil;
    /*
    BaseAnimator *animator =  (BaseAnimator*)animationController;
    self.interactViewController.toVc = animator.toVC;
    return self.interactViewController.interacting? self.interactViewController:nil;
     */
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self removeObserver:self forKeyPath:@"selectedViewController"];
    [self removeObserver:self forKeyPath:@"selectedIndex"];
    
}
@end
