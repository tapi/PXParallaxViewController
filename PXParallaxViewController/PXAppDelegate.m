//
//  PXAppDelegate.m
//  PXParallaxViewController
//
//  Created by Paddy O'Brien on 2012-08-14.
//  Copyright (c) 2012 500px. All rights reserved.
//

#import "PXAppDelegate.h"
#import "PXParallaxViewController.h"

@implementation PXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
	
	UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shovel"]];
	imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	imageView.contentMode = UIViewContentModeScaleAspectFill;
	
	UIView *testContentView = [[[UINib nibWithNibName:@"testContentView" bundle:nil] instantiateWithOwner:nil options:nil] objectAtIndex:0];
	
	PXParallaxViewController *paralaxViewController = [[PXParallaxViewController alloc] initWithContentView:testContentView andParallaxView:imageView];
	paralaxViewController.parallaxHeight = 150;
	paralaxViewController.contentScrollView.delegate = self;
	_window.rootViewController = paralaxViewController;
	
    return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	usleep(0);
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
	usleep(0);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	usleep(0);
}
@end
