//
//  NavigationController.m
//  VCTransitationDemo
//
//  Created by 李南 on 15/8/2.
//  Copyright (c) 2015年 ctd.leonard. All rights reserved.
//

#import "NavigationController.h"
#import "SwipePercentIntercativeTransition.h"
#import "CEFoldAnimationController.h"
#import "BaseAnimator.h"

@interface NavigationController ()<UINavigationControllerDelegate>
@property(nonatomic, strong) SwipePercentIntercativeTransition *intrecationController;
@property(nonatomic, strong) CEFoldAnimationController *animatorController;
@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.intrecationController = [[SwipePercentIntercativeTransition alloc]initWithOperation:SwipeInteractionOperationNav];
    self.animatorController = [[CEFoldAnimationController alloc]init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UINavigationControllerDelegate

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{

    [self.intrecationController writeToViewController:toVC];
    if (operation == UINavigationControllerOperationPop) {
        self.animatorController.reverse =  NO;
        
        
    }else{
        self.animatorController.reverse = YES;
    }
    return self.animatorController;

     
}

-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    CEFoldAnimationController *animator = animationController;
    return self.intrecationController.interacting&&!animator.reverse?self.intrecationController:nil;
}
@end
