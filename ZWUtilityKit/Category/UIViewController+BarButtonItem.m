//
//  UINavigationController+BarButtonItem.m
//  ZWUtilityKit
//
//  Created by 陈正旺 on 15/1/30.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

#import "UIViewController+BarButtonItem.h"
#import "ZWMacroDef.h"

@implementation UIViewController (BarButtonItem)

- (void)setDefaultBackBarButtonItem
{
    [self setLeftBarButtonItem:[self defaultLeftBackItem] offset:Nav_Left_BarItem_Offset];
}

- (UIBarButtonItem *)defaultLeftBackItem
{
    return [self createNavButton:@"DDMenu.bundle/nav_back"
                       highImage:@"Header-Btn-Back-Darkred.png"
                           title:nil
                          target:self
                          action:@selector(respondsToLeftItemClick) offset:Nav_Left_BarItem_Offset];
}

- (void)setLeftBarButtonItem:(UIBarButtonItem *)item offset:(float)offset
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
//    negativeSpacer.width = offset;
    
    self.navigationController.topViewController.navigationItem.leftBarButtonItems = [NSArray
                                                                arrayWithObjects:negativeSpacer, item, nil];
}

- (void)setLeftButtonWithAnimation:(UIBarButtonItem *)item
{
    UIBarButtonItem *old_item = [self.navigationItem.leftBarButtonItems objectAtIndex:1];
    if (!old_item) {
        [self setLeftBarButtonItem:item offset:Nav_Left_BarItem_Offset];
    }
    UIButton *old_btn = [[[old_item customView] subviews] lastObject];
    UIButton *new_btn = [[[item customView] subviews] lastObject];
    [[old_item customView] addSubview:new_btn];
    new_btn.alpha = 0;
    
    [UIView animateWithDuration:Navigation_Bar_Animaiton_Interval
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void){
                         old_btn.alpha = 0;
                         new_btn.alpha = 1.0f;
                     } completion:^(BOOL finished){
                         [old_btn removeFromSuperview];
                     }];
}

- (void)setRightBarButtonItem:(UIBarButtonItem *)item offset:(float)offset
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = offset;
    self.navigationItem.rightBarButtonItems = [NSArray
                                               arrayWithObjects:negativeSpacer, item, nil];
}

- (void)setRightButtonWithAnimation:(UIBarButtonItem *)item
{
    UIBarButtonItem *old_item = [self.navigationItem.rightBarButtonItems objectAtIndex:1];
    if (!old_item) {
        [self setRightBarButtonItem:item offset:Nav_Right_BarItem_Offset];
    }
    UIButton *old_btn = [[[old_item customView] subviews] lastObject];
    UIButton *new_btn = [[[item customView] subviews] lastObject];
    [[old_item customView] addSubview:new_btn];
    new_btn.alpha = 0;
    
    [UIView animateWithDuration:Navigation_Bar_Animaiton_Interval
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void){
                         old_btn.alpha = 0;
                         new_btn.alpha = 1.0f;
                     } completion:^(BOOL finished){
                         [old_btn removeFromSuperview];
                     }];
}

- (UIBarButtonItem*)createNavButton:(NSString *)strImageName
                          highImage:(NSString *)strHighImage
                              title:(NSString *)strTitle
                             target:(id)target
                             action:(SEL)btnAction
                             offset:(float)offset
{
    UIImage* image = [UIImage imageNamed:strImageName];
    UIImage* imageHigh =[UIImage imageNamed:strHighImage];
    
    
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    if (width < 0.001)
    {
        width = 30;
    }
    if (height < 0.001)
    {
        height = 30;
    }
    CGRect backframe = CGRectMake(0, 0, width, height);
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width,height)];
    
    UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = backframe;
    [backButton setTitle:strTitle forState:UIControlStateNormal];
    [backButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton setImage:imageHigh forState:UIControlStateHighlighted];
    [backButton addTarget:target action:btnAction forControlEvents:UIControlEventTouchUpInside];
    backButton.tag = 101;
    [bgView addSubview:backButton];
    
    __autoreleasing UIBarButtonItem* someBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:bgView];
    return someBarButtonItem;
}

- (void)respondsToLeftItemClick
{
    if (self.navigationController.topViewController != self && [self.navigationController.topViewController respondsToSelector:@selector(respondsToLeftItemClick)])
    {
        __weak UIViewController *vcTop = self.navigationController.topViewController;
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong UIViewController *vcStrong = vcTop;
            [vcStrong respondsToLeftItemClick];
        });
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
