//
//  BNRPaletteViewController.m
//  ColorBoard
//
//  Created by Lakhpat on 02/04/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import "BNRPaletteViewController.h"
#import "BNRColorViewController.h"
#import "BNRColorDiscription.h"

@interface BNRPaletteViewController ()

@property (nonatomic) NSMutableArray *colors;

@end

@implementation BNRPaletteViewController

- (NSMutableArray *)colors
{
    if (!_colors) {
        _colors = [NSMutableArray array];
        
        BNRColorDiscription *cd = [[BNRColorDiscription alloc] init];
        [_colors addObject:cd];
    }
    NSLog(@"%@",_colors);
    return _colors;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"colors %d",[self.colors count]);
    return [self.colors count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    BNRColorDiscription *color = self.colors[indexPath.row];
    NSLog(@"%@",color);
    NSLog(@"%@",color.name);
    cell.textLabel.text = color.name;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"NewColor"]) {
        BNRColorDiscription *color = [[BNRColorDiscription alloc] init];
        [self.colors addObject:color];
        
        UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
        BNRColorViewController *mvc = (BNRColorViewController *)[nc topViewController];
        mvc.colorDiscription = color;
    }
    else if ([segue.identifier isEqualToString:@"ExistingColor"]) {
        NSIndexPath *ip = [self.tableView indexPathForCell:sender];
        BNRColorDiscription *color = self.colors[ip.row];
        
        BNRColorViewController *cvc = (BNRColorViewController *)segue.destinationViewController;
        cvc.colorDiscription = color;
        cvc.existingColor = YES;
    }
}

@end
