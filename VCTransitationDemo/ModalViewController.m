//
//  ModalViewController.m
//  VCTransitationDemo
//
//  Created by 李南 on 15/7/29.
//  Copyright (c) 2015年 ctd.leonard. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController ()

@end

@implementation ModalViewController

-(void)awakeFromNib{
    NSLog(@"[%@,%@]", NSStringFromClass([self class]),NSStringFromSelector(_cmd));
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"[%@,%@]", NSStringFromClass([self class]),NSStringFromSelector(_cmd));
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];

    // add a button
    
     UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.layer.cornerRadius = 5.0f;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor greenColor]];
    [button setTitle:@"dismiss me " forState:UIControlStateNormal];
    
    CGRect bounds = self.view.bounds;
    button.frame = CGRectMake((bounds.size.width-120)/2, (bounds.size.height-30)/2, 120, 30);
    [self.view addSubview:button];
}

-(IBAction)buttonClick:(id)sender{
    if (self.presentingViewController) {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
    
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

@end
