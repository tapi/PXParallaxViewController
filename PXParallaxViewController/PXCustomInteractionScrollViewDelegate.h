//
//  PXCustomInteractionScrollViewDelegate.h
//  PXParallaxViewController
//
//  Created by Paddy O'Brien on 2012-08-17.
//  Copyright (c) 2012 500px. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * The idea is that any of the view interaction methods on UI scrollview or the UIGestureRecognizer delegate methods that return a BOOL will
 * hand off to a delegate first. If the delegate returns YES then we return YES. If the delegate returns NO we return the result obtained by
 * calling the super implementation. This should give controllers a little more leeway in how scrollviews, in particular nested scrollviews, 
 * behave without having to subclass every time. If your not sure, return NO.
 *
 * It's a pity that catagories can't call super.
 */
@protocol PXCustomInteractionScrollViewDelegate <NSObject>
#pragma mark - UIScrollView Overrides
- (BOOL)scrollView:(UIScrollView *)scrollView touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view;
- (BOOL)scrollView:(UIScrollView *)scrollView touchesShouldCancelInContentView:(UIView *)view;
@end


