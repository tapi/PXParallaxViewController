//
//  PXCustomInteractionScrollView.m
//  PXParallaxViewController
//
//  Created by Paddy O'Brien on 2012-08-17.
//  Copyright (c) 2012 500px. All rights reserved.
//

#import "PXCustomInteractionScrollView.h"
#import "NSInvocation(ForwardedConstruction).h"

@interface PXCustomInteractionScrollView ()
@property (nonatomic, strong) id<UIGestureRecognizerDelegate> panDelegate;
@property (nonatomic, strong) id<UIGestureRecognizerDelegate> pinchDelegate;
@end

@implementation PXCustomInteractionScrollView
- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
	{
		_panDelegate = self.panGestureRecognizer.delegate;
		self.panGestureRecognizer.delegate = (_panDelegate) ? self : nil;
		
		_pinchDelegate = self.pinchGestureRecognizer.delegate;
		self.panGestureRecognizer.delegate = (_pinchDelegate) ? self : nil;
	}
	
	return self;
}

#pragma mark - UIScrollView Overrides
- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view
{
	if (_interactionDelegate && [_interactionDelegate respondsToSelector:@selector(scrollView:touchesShouldBegin:withEvent:inContentView:)])
	{
		BOOL result = [_interactionDelegate scrollView:self touchesShouldBegin:touches withEvent:event inContentView:view];
		if (result)
		{
			return YES;
		}
	}
	
	return [super touchesShouldBegin:touches withEvent:event inContentView:view];
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
	if (_interactionDelegate && [_interactionDelegate respondsToSelector:@selector(touchesShouldCancelInContentView:)])
	{
		BOOL result = [_interactionDelegate scrollView:self touchesShouldCancelInContentView:view];
		if (result)
		{
			return YES;
		}
	}
	
	return [super touchesShouldCancelInContentView:view];
}

@end