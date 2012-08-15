//
//  PXParallaxViewController.m
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

#import "PXParallaxViewController.h"

#define DEFAULT_PARALLAX_HEIGHT	200.0f

@interface PXParallaxViewController ()
@property (nonatomic, weak) id<UIScrollViewDelegate> contentDelegate;
@end

@implementation PXParallaxViewController

static CGFloat ImageHeight  = 300.0;

- (id)initWithContentView:(UIView *)contentView andParallaxView:(UIView *)parallaxView
{
	self = [super initWithNibName:nil bundle:nil];
	if (self)
	{
		_parallaxHeight = DEFAULT_PARALLAX_HEIGHT;
		
		_parallaxScrollView  = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _parallaxScrollView.backgroundColor                  = [UIColor clearColor];
        _parallaxScrollView.showsHorizontalScrollIndicator   = NO;
        _parallaxScrollView.showsVerticalScrollIndicator     = NO;
		
		_contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _contentScrollView.backgroundColor              = [UIColor clearColor];
        _contentScrollView.delegate                     = self;

		self.parallaxView = parallaxView;
		self.contentView = contentView;
		
		[_contentScrollView addObserver:self forKeyPath:@"delegate" options:NSKeyValueObservingOptionNew context:nil];
	}
	
	return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if (object == _contentScrollView && [keyPath isEqualToString:@"delegate"])
	{
		id<UIScrollViewDelegate> secondaryDelegate = [change valueForKey:NSKeyValueChangeNewKey];
		if (secondaryDelegate != self)
		{
			_contentDelegate = secondaryDelegate;
			_contentScrollView.delegate = self;
		}
	}
}


- (void)setContentView:(UIView *)contentView
{
	_contentView = contentView;
	_contentView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
	
	[_contentScrollView addSubview:_contentView];
}

- (void)setParallaxView:(UIView *)parallaxView
{
	_parallaxView = parallaxView;
	_parallaxView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
	
	[_parallaxScrollView addSubview:_parallaxView];
}

#pragma mark - Parallax effect

- (void)updateOffsets
{
    CGFloat yOffset   = _contentScrollView.contentOffset.y;
    CGFloat threshold = ImageHeight - _parallaxHeight;
    
    if (yOffset > -threshold && yOffset < 0)
	{
        _parallaxScrollView.contentOffset = CGPointMake(0.0, floorf(yOffset / 2.0));
    }
	else if (yOffset < 0)
	{
        _parallaxScrollView.contentOffset = CGPointMake(0.0, yOffset + floorf(threshold / 2.0));
    }
	else
	{
        _parallaxScrollView.contentOffset = CGPointMake(0.0, yOffset);
    }
}

#pragma mark - View Layout
- (void)layoutParallaxView
{
	CGRect bounds = self.view.bounds;
    _parallaxScrollView.frame	= CGRectMake(0.0, 0.0, bounds.size.width, bounds.size.height);
	
    CGFloat width   = _parallaxScrollView.frame.size.width;
    CGFloat yOffset = floorf((_parallaxHeight  - ImageHeight) / 2.0);
    CGFloat xOffset = 0.0;
    
    _parallaxView.frame					= CGRectMake(xOffset, yOffset, width, ImageHeight);
    _parallaxScrollView.contentSize		= CGSizeMake(width, self.view.bounds.size.height);
    _parallaxScrollView.contentOffset	= CGPointZero;
}

- (void)layoutContent
{
    _contentScrollView.frame = self.view.bounds;
	
	CGFloat yOffset = _parallaxHeight;
	CGFloat xOffset = 0.0;
	
	CGSize contentSize = _contentView.frame.size;
	contentSize.height += yOffset;

	_contentView.frame				= (CGRect){.origin = CGPointMake(xOffset, yOffset), .size = _contentView.frame.size};
	_contentScrollView.contentSize	= contentSize;
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self layoutParallaxView];
	[self layoutContent];
	
    [self updateOffsets];
}

#pragma mark - UIScrollView Delegate
// We want to allow external delegates without breaking functionality
// This could be done better with a bit of runtime hacking, requires more research
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if (scrollView == _contentScrollView)
	{
		[self updateOffsets];

		if ([_contentDelegate respondsToSelector:@selector(scrollViewDidScroll:)])
		{
			[_contentDelegate scrollViewDidScroll:scrollView];
		}
	}
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
 	if (scrollView == _contentScrollView && [_contentDelegate respondsToSelector:@selector(scrollViewDidZoom:)])
	{
		[_contentDelegate scrollViewDidZoom:scrollView];
	}
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
	if (scrollView == _contentScrollView && [_contentDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)])
	{
		[_contentDelegate scrollViewWillBeginDragging:scrollView];
	}
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
	if (scrollView == _contentScrollView && [_contentDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)])
	{
		[_contentDelegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
	}
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	if (scrollView == _contentScrollView && [_contentDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)])
	{
		[_contentDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
	}
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
	if (scrollView == _contentScrollView && [_contentDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)])
	{
		[_contentDelegate scrollViewWillBeginDecelerating:scrollView];
	}
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	if (scrollView == _contentScrollView && [_contentDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)])
	{
		[_contentDelegate scrollViewDidEndDecelerating:scrollView];
	}
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
	if (scrollView == _contentScrollView && [_contentDelegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)])
	{
		[_contentDelegate scrollViewDidEndScrollingAnimation:scrollView];
	}
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	if (scrollView == _contentScrollView && [_contentDelegate respondsToSelector:@selector(viewForZoomingInScrollView:)])
	{
		return [_contentDelegate viewForZoomingInScrollView:scrollView];
	}
	return nil;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
	if (scrollView == _contentScrollView && [_contentDelegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)])
	{
		[_contentDelegate scrollViewWillBeginZooming:scrollView withView:view];
	}
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
	if (scrollView == _contentScrollView && [_contentDelegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)])
	{
		[_contentDelegate scrollViewDidEndZooming:scrollView withView:view atScale:scale];
	}
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
	if (scrollView == _contentScrollView && [_contentDelegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)])
	{
		return [_contentDelegate scrollViewShouldScrollToTop:scrollView];
	}
	return NO;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
	if (scrollView == _contentScrollView && [_contentDelegate respondsToSelector:@selector(scrollViewDidScrollToTop:)])
	{
		[_contentDelegate scrollViewDidScrollToTop:scrollView];
	}
}
@end
