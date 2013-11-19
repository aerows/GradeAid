//
//  SellectionCell.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-06.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "SellectionCell.h"
#import "SellectionViewController.h"

@implementation SellectionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - SellectionVerifyer View Methods

- (void) updateView
{
    id<CellPresentable> object = _sellectionVerifyer.selectedObject;
    
    if (object)
    {
        _thumbnailView.image = [object thumbNail];
        _titleLabel.text = [object title];
    }
    else
    {
        _thumbnailView.image = nil;
        _titleLabel.text = @"Ingen vald";
    }
}

#pragma mark - IBAction Methods

- (IBAction) selectButtonPressed:(id)sender
{

}


#pragma mark - Setters and Getters

@synthesize sellectionVerifyer = _sellectionVerifyer;

- (void) setSellectionVerifyer:(SellectionVerifyer *)sellectionVerifyer
{
    _sellectionVerifyer = sellectionVerifyer;
    [self updateView];
}

@end
