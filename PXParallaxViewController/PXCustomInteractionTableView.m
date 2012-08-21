//
//  PXCustomInteractionTableView.m
//  PXParallaxViewController
//
//  Created by Paddy O'Brien on 2012-08-20.
//  Copyright (c) 2012 500px. All rights reserved.
//

#import "PXCustomInteractionTableView.h"

@implementation PXCustomInteractionTableView

#pragma mark - UIScrollView Overrides
- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view
{
	BOOL failsSafely = YES;
	if (_interactionDelegate && [_interactionDelegate respondsToSelector:@selector(scrollViewInteractionShouldFailSafely:)])
	{
		failsSafely = [_interactionDelegate scrollViewInteractionShouldFailSafely:self];
	}
	
	if (_interactionDelegate && [_interactionDelegate respondsToSelector:@selector(scrollView:touchesShouldBegin:withEvent:inContentView:)])
	{
		BOOL result = [_interactionDelegate scrollView:self touchesShouldBegin:touches withEvent:event inContentView:view];
		
		if (failsSafely == NO)
		{
			return result;
		}
		else if (result)
		{
			return YES;
		}
	}
	
	return [super touchesShouldBegin:touches withEvent:event inContentView:view];
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
	BOOL failsSafely = YES;
	if (_interactionDelegate && [_interactionDelegate respondsToSelector:@selector(scrollViewInteractionShouldFailSafely:)])
	{
		failsSafely = [_interactionDelegate scrollViewInteractionShouldFailSafely:self];
	}
	
	if (_interactionDelegate && [_interactionDelegate respondsToSelector:@selector(touchesShouldCancelInContentView:)])
	{
		BOOL result = [_interactionDelegate scrollView:self touchesShouldCancelInContentView:view];
		
		if (failsSafely == NO)
		{
			return result;
		}
		else if (result)
		{
			return YES;
		}
	}
	
	return [super touchesShouldCancelInContentView:view];
}


#pragma mark - UIGestureRecognizer Overides
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
	if (_interactionDelegate && [_interactionDelegate respondsToSelector:@selector(scrollView:gestureRecognizer:shouldReceiveTouch:)])
	{
		return [_interactionDelegate scrollView:self gestureRecognizer:gestureRecognizer shouldReceiveTouch:touch];
	}
	
	return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
	if (_interactionDelegate && [_interactionDelegate respondsToSelector:@selector(scrollView:gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:)])
	{
		return [_interactionDelegate scrollView:self gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
	}
	
	return NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
	if (_interactionDelegate && [_interactionDelegate respondsToSelector:@selector(scrollView:gestureRecognizerShouldBegin:)])
	{
		return [_interactionDelegate scrollView:self gestureRecognizerShouldBegin:gestureRecognizer];
	}
	
	return YES;
}
@end
