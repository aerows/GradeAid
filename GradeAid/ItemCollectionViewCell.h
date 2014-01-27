//
//  ItemCollectionViewCell.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-07.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const ItemCollectionViewCellIdentifier = @"ItemCollectionViewCellIdentifier";

typedef void(^DeleteObjectInCellBlock)(UICollectionViewCell*cell);

@interface ItemCollectionViewCell : UICollectionViewCell
{
    IBOutlet UIImageView *_imageView;
    IBOutlet UILabel *_label;
    IBOutlet UIImageView *_removeIconView;
    IBOutlet UITapGestureRecognizer *_tapper;
}

@property (nonatomic, strong) UITapGestureRecognizer *tapper;
@property (nonatomic) bool showDeleteView;
@property (nonatomic, copy) DeleteObjectInCellBlock deleteObjectBlock;

@property (nonatomic) bool wobble;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *removeIconView;

@end
