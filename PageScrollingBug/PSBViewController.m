//
//  PSBViewController.m
//  PageScrollingBug
//
//  Created by Lukáš Foldýna on 05/05/14.
//  Copyright (c) 2014 Arat. All rights reserved.
//

#import "PSBViewController.h"

@interface PSBViewController () <UIPageViewControllerDataSource>

@property (nonatomic, strong) NSArray *controllers;

@end

@implementation PSBViewController

- (void) viewDidLoad
{
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor blackColor]];
    
    NSMutableArray *controllers = [NSMutableArray array];
    for (NSInteger i = 0; i < 3; i++) {
        UIViewController *controller = [[UIViewController alloc] init];
        [controller setTitle:[NSString stringWithFormat:@"Controller %i", i + 1]];
        [controller.view setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:1]];
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        [controllers addObject:navController];
    }
    _controllers = [controllers copy];
    [self setDataSource:self];
    [self setViewControllers:@[controllers[0]] direction:0 animated:NO completion:nil];
}

#pragma mark UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self.controllers indexOfObject:viewController];
    
    if (viewController == nil)
        index = 0;
    else if (index == 0)
        return nil;
    else
        index--;
    return self.controllers[index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self.controllers indexOfObject:viewController];
    
    if (viewController == nil)
        index = 0;
    else if (index == 2)
        return nil;
    else
        index++;
    return self.controllers[index];
}

@end
