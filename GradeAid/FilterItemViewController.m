//
//  FilterViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-07.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "FilterItemViewController.h"

// View
#import "ItemCollectionViewCell.h"
#import "PromptNavigationController.h"
#import "UIAlertView+MKBlockAdditions.h"

static CGFloat cellWidth = 150.f;

@interface FilterItemViewController ()
{
    UIPanGestureRecognizer *_panGestureRecognizer;
}

@end

@implementation FilterItemViewController

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder: aDecoder])
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _filterItemCollectionView.allowsSelection = YES;
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget: self action: @selector(panning:)];
    [self.view addGestureRecognizer: _panGestureRecognizer];
}

#pragma mark - Appearing Methods

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    [[NSNotificationCenter defaultCenter] addObserver: self selector:@selector(filterItemCreated:) name:FilterItemWasCreatedNotification object:nil];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

#pragma mark - Notification Methods

- (void) filterItemCreated: (NSNotification*) notification
{
    [_filterItem reloadItems];
    [_filterItemCollectionView reloadData];
}

#pragma mark - GestureRecognizer Methods

-(void) panning: (UIPanGestureRecognizer*) panGestureRecognizer
{
    static CGRect originalFrame; // or you could make this a non-static class ivar
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        originalFrame = self.view.frame;
    }
    else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [panGestureRecognizer translationInView:self.view];
        CGFloat y = (translation.y < originalFrame.size.height) ? translation.y : originalFrame.size.height;
        y = (y < 0) ? y / 4 : y;
        CGRect newFrame = originalFrame;
        newFrame.origin.y += y;
        newFrame.size.height -= y;
        self.view.frame = newFrame;
        
    }
    else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        CGPoint translation = [panGestureRecognizer translationInView:self.view];
        if (translation.y > originalFrame.size.height / 2)
        {
            _dismissBlock();
        }
        else
        {
            [UIView animateWithDuration: 0.3 animations:^{
                [self.view setFrame: originalFrame];
            }];
        }
    }
}

#pragma mark - Class Methods

- (CGFloat) neededHeight
{
    return 120.f;
}

#pragma mark - IBAction Methods

- (IBAction) editButtonPressed:(id)sender
{
    [self setInEditMode: !_inEditMode];
    [_filterItemCollectionView reloadData];

}

#pragma mark - UICollectionView Datasource Methods

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return (_inEditMode) ? 1 + _filterItem.selectableItems.count : _filterItem.selectableItems.count;
}

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: ItemCollectionViewCellIdentifier forIndexPath: indexPath];
    
    if (!_inEditMode || indexPath.item < _filterItem.selectableItems.count)
    {
        __block id selectableItem = [_filterItem.selectableItems objectAtIndex: indexPath.item];
        
        [cell.imageView setImage: [_filterItem imageForItem: selectableItem]];
        [cell.label setText: [_filterItem titleForItem: selectableItem]];
        [cell setWobble: _inEditMode];
        [cell setShowDeleteView: _inEditMode];
        [cell setDeleteObjectBlock:^(UICollectionViewCell* cell)
         {
             NSString *message = [NSString stringWithFormat: @"Är du säker på att du vill ta bort \"%@\"?", [_filterItem titleForItem: selectableItem]];
             [UIAlertView alertViewWithTitle:@""
                                     message: message
                           cancelButtonTitle:@"Nej"
                           otherButtonTitles:@[@"Ja"]
                                   onDismiss:^(int buttonIndex)
              {
                  NSIndexPath *indexPath = [_filterItemCollectionView indexPathForCell: cell];
                  [_filterItem deleteItemAtIndex: indexPath.item];
                  [_filterItemCollectionView deleteItemsAtIndexPaths: @[indexPath]];
                  [_filterItemCollectionView reloadData];
              }
                                    onCancel:^()
              {
                  NSLog(@"Cancelled");
              }];
             

         }];
    }
    else
    {
        [cell.imageView setImage: [UIImage imageNamed: @"plus"]];
        [cell.label setText: @"Lägg till ny"];
        [cell setWobble: NO];
        [cell setShowDeleteView: NO];
    }
    
    return cell;
}

#pragma mark - UICollectionView Delegate Methods

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_inEditMode)
    {
        if (indexPath.item < _filterItem.selectableItems.count)
        {
            NSLog(@"Redigera ämnet");

        }
        else
        {
            PromptNavigationController *pnc = [[PromptNavigationController alloc] init];
            PromptCreateViewController *pcvc = _filterItem.newObjectPromptViewController;
            
            [pnc pushPromptViewController:  pcvc animated: YES];
            [pcvc setDoneCreatingBlock:^(PromptViewController *prompt , id object)
            {
                NSInteger index = [_filterItem indexForInsertSelectableItem: object];
                [self setInEditMode: NO];
                [prompt dismiss];
            }];
            [self presentViewController: pnc animated: YES completion: nil];
        }
        return;
    }
    
    id selectedItem = [_filterItem.selectableItems objectAtIndex: indexPath.item];
    id previousItem = nil;
    if ([_filterItem.selectedItem isEqual: selectedItem])
    {
        _filterItem.selectedItem = nil;
    }
    else
    {
        previousItem = _filterItem.selectedItem;
        _filterItem.selectedItem = selectedItem;
        _dismissBlock();
    }
    
    ItemCollectionViewCell *cell = (ItemCollectionViewCell*)[collectionView cellForItemAtIndexPath: indexPath];
    [cell.imageView setImage: [_filterItem imageForItem: selectedItem]];
    
    if (previousItem)
    {
        NSInteger index = [_filterItem.selectableItems indexOfObject: previousItem];
        NSIndexPath *previousIndexPath = [NSIndexPath indexPathForItem: index inSection:0];
        ItemCollectionViewCell *previousCell = (ItemCollectionViewCell*)[collectionView cellForItemAtIndexPath: previousIndexPath];
        [previousCell.imageView setImage: [_filterItem imageForItem: previousItem]];
    }
    
    
    [_filterItem.delegate filterItemDidUpdate: _filterItem];
}

- (void) collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{

}

- (BOOL) collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)colView
didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor blueColor];
}
- (void)collectionView:(UICollectionView *)colView
didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = nil;
}

#pragma mark - View Appearence Methods

- (void) viewWillAppear:(BOOL)animated
{
    [_editButton setHidden: !_filterItem.editable];
    
    [super viewWillAppear: animated];
    
    if (_filterItem.selectedItem)
    {
        NSInteger index = [_filterItem.selectableItems indexOfObject: _filterItem.selectedItem];
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem: index inSection: 0];
        [_filterItemCollectionView selectItemAtIndexPath: indexPath animated: NO scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    }
    [self updateFlowLayoutAnimated: NO];
}

- (void) updateFlowLayoutAnimated: (bool) animated
{
    return;
    NSInteger cellCount = (_inEditMode) ? _filterItem.selectableItems.count + 1 : _filterItem.selectableItems.count;
    CGFloat cellWidthSum = cellCount * cellWidth;
    
    
        CGFloat collectionViewWidth = self.filterItemCollectionView.frame.size.width;
    CGFloat leftInset = (cellWidthSum < self.filterItemCollectionView.frame.size.width) ?(collectionViewWidth - cellWidthSum) / 2 : 0;
        UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*)_filterItemCollectionView.collectionViewLayout;
        CGFloat previousInset = flowLayout.sectionInset.left;

        [flowLayout setSectionInset: UIEdgeInsetsMake(0, leftInset, 0, leftInset)];
        [_filterItemCollectionView setCollectionViewLayout: flowLayout];
        
        if (animated)
        {
            CGFloat diff = leftInset - previousInset;
            CGPoint offset = _filterItemCollectionView.contentOffset;
            
            [_filterItemCollectionView setContentOffset: CGPointMake(offset.x + diff, offset.y) animated:NO];
            [_filterItemCollectionView setContentOffset: offset animated: YES];
            
        }

    
}

#pragma mark - Setters and Getters

- (void) setFilterItem:(FilterItem *)filterItem
{
    _filterItem = filterItem;
    [_filterItem reloadItems];
    [_filterItemCollectionView reloadData];
}

- (void) setInEditMode:(BOOL)inEditMode
{
    if (inEditMode == _inEditMode) return;
    _inEditMode = inEditMode;
    [_editButton setTitleColor: (_inEditMode) ? colorTintedBlue : [UIColor whiteColor] forState: UIControlStateNormal];
    [self updateFlowLayoutAnimated: YES];
        
    [_filterItemCollectionView reloadData];
}

- (void) updateFilterItemCollectionView
{
    
}

// Model
@synthesize filterItem = _filterItem;
// View
@synthesize filterItemCollectionView = _filterItemCollectionView;
// Controller
@synthesize inEditMode = _inEditMode;
@synthesize dismissBlock = _dismissBlock;

@end
