//
//  UINavigationController+Orientation.h
//  ZWUtilityKit
//
//  Created by 陈正旺 on 15/1/31.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 *  @description:解决在ios6中设备旋转问题
 *
 *  描述参考http://blog.csdn.net/qq515383106/article/details/8765360
 *
 */

@interface UINavigationController (Orientation)
@end

@interface UINavigationController (Background)

/*
 * @brief: 设置导航栏的背景图片
 * @prama: image:背景图片
 *
 */
- (void)setBackgroundImage:(nonnull UIImage *)image;

@end
