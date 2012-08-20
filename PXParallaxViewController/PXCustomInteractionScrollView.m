//
//  PXCustomInteractionScrollView.m
//  PXParallaxViewController
//
//  Created by Paddy O'Brien on 2012-08-17.
//  Copyright (c) 2012 500px. All rights reserved.
//

#import "PXCustomInteractionScrollView.h"

@implementation PXCustomInteractionScrollView

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


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
	if (_interactionDelegate && [_interactionDelegate respondsToSelector:@selector(scrollView:gestureRecognizer:shouldReceiveTouch:)])
	{
		BOOL result = [_interactionDelegate scrollView:self gestureRecognizer:gestureRecognizer shouldReceiveTouch:touch];
		if (result)
		{
			return YES;
		}
	}
	
	return [super gestureRecognizer:gestureRecognizer shouldReceiveTouch:touch];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
	if (_interactionDelegate && [_interactionDelegate respondsToSelector:@selector(scrollView:gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:)])
	{
		BOOL result = [_interactionDelegate scrollView:self gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
		if (result)
		{
			return YES;
		}
	}
	
	return [super gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
	if (_interactionDelegate && [_interactionDelegate respondsToSelector:@selector(scrollView:gestureRecognizerShouldBegin:)])
	{
		BOOL result = [_interactionDelegate scrollView:self gestureRecognizerShouldBegin:gestureRecognizer];
		if (result)
		{
			return YES;
		}
	}
	
	return [super gestureRecognizerShouldBegin:gestureRecognizer];
}
@end