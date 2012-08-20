//
//  PXParallaxViewController.h
//
//  Created by Paddy O'Brien on 14/08/2012.
//  Copyright (c) 2012 500px Inc. All rights reserved.
//
//	Adapted from RBParallaxTableViewController by Rheese Burgess
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
//  of the Software, and to permit persons to whom the Software is furnished to do
//  so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import "PXCustomInteractionScrollViewDelegate.h"
#import "PXCustomInteractionScrollView.h"

@interface PXParallaxViewController : UIViewController <UIScrollViewDelegate>
/**
 * The scrollview that contains the content
 */
@property (nonatomic, readonly) PXCustomInteractionScrollView *contentScrollView;

/**
 * The scrollview that contains the parallax View
 */
@property (nonatomic, readonly) UIScrollView *parallaxScrollView;

/**
 * The view to be shown with the parallax effect
 */
@property (nonatomic, strong) UIView *parallaxView;

/**
 * The content view that obscures the parallax view
 */
@property (nonatomic, strong) UIView *contentView;

/**
 * The visible height of the parallax view at rest
 */
@property (nonatomic, assign) CGFloat parallaxHeight;

- (id)initWithContentView:(UIView *)contentView andParallaxView:(UIView *)parallaxView;
@end
