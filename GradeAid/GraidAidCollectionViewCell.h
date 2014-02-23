//
//  GraidAidCollectionViewCell.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-28.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DeleteiconPressedBlock)(UICollectionViewCell*cell);
typedef void(^CellLongPressedBlock)(UICollectionViewCell*cell, BOOL editMode);
typedef void(^CellTappedBlock)(UICollectionViewCell*cell, BOOL editMode);

@interface GraidAidCollectionViewCell : UICollectionViewCell
{
    IBOutlet UIImageView *_imageView;
    IBOutlet UILabel *_textLabel;
    IBOutlet UIImageView *_deleteiconView;
    
    UITextField *_textField;

    UITapGestureRecognizer *_deleteIconTapRecognizer;
    UITapGestureRecognizer *_tapRecognizer;
    UILongPressGestureRecognizer *_longPressRecognizer;

}

@property (nonatomic) BOOL editMode;

//@property (nonatomic) BOOL objectRemovable;
//@property (nonatomic) BOOL objectTitleEditable;

@property (nonatomic, copy) DeleteiconPressedBlock deleteiconPressedBlock;
@property (nonatomic, copy) CellTappedBlock cellTappedBlock;
@property (nonatomic, copy) CellLongPressedBlock cellLongPressedBlock;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIImageView *deleteiconView;
@property (nonatomic, strong) UITextField *textField;

@end
