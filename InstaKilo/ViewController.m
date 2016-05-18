//
//  ViewController.m
//  InstaKilo
//
//  Created by Anthony Coelho on 2016-05-18.
//  Copyright © 2016 Anthony Coelho. All rights reserved.
//

#import "ViewController.h"
#import "CustomCollectionViewCell.h"
#import "Photo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataArray = [[NSArray alloc] init];
    self.photosArray = [[NSMutableArray alloc] init];
    
    
    self.photoCollectionView.backgroundColor = [UIColor whiteColor];
    [self loadImages];
    [self organizePhotosBySubject];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)toggleSort:(id)sender {
    
    self.segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = self.segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        [self organizePhotosBySubject];
    }
    else{
        //toggle the correct view to be visible
        [self organizePhotosByLocation];
    }
    
    [self.photoCollectionView reloadData];
}

- (void) organizePhotosByLocation{
    
    NSMutableArray *tempArray1 = [NSMutableArray new];
    NSMutableArray *tempArray2 = [NSMutableArray new];
    
    for (Photo *photo in self.photosArray) {
        
        if ([photo.location isEqualToString:@"Canada"]) {
            
            [tempArray1 addObject:photo];
        }
        else if ([photo.location isEqualToString:@"World"]){
            
            [tempArray2 addObject:photo];
        }
        
        
    }
    
    self.sectionsArray = [[NSMutableArray alloc] initWithObjects:tempArray1, tempArray2, nil];
}


- (void) organizePhotosBySubject {
    
    NSMutableArray *tempArray1 = [NSMutableArray new];
    NSMutableArray *tempArray2 = [NSMutableArray new];

    for (Photo *photo in self.photosArray) {
        
        if ([photo.subject isEqualToString:@"Personal Favourites"]) {
           
            [tempArray1 addObject:photo];
        }
        else if ([photo.subject isEqualToString:@"Other"]){
    
            [tempArray2 addObject:photo];
        }
        
        
    }
    
    self.sectionsArray = [[NSMutableArray alloc] initWithObjects:tempArray1, tempArray2, nil];
}

- (void)loadImages {
    NSInteger index;
    
    NSString *directory = [NSString stringWithFormat:@"Images"];
    self.dataArray = [[NSBundle mainBundle] pathsForResourcesOfType:@"jpeg" inDirectory:directory];
    
    for (NSString *photoFileName in self.dataArray) {
        
        Photo *photo = [[Photo alloc] init];
        photo.image = [UIImage imageNamed:photoFileName];
        index = [self.dataArray indexOfObject:photoFileName];
        
        if (index < 3) {
            photo.subject = @"Personal Favourites";
        }
        else {
            photo.subject = @"Other";
        }
        
        if (index < 6) {
            photo.location = @"Canada";
        }
        else {
            photo.location = @"World";
        }
        
        [self.photosArray addObject:photo];
    
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectionsArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [self.sectionsArray[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCell" forIndexPath:indexPath];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
    Photo *photo = [self.sectionsArray[indexPath.section] objectAtIndex:indexPath.row];
    
    imageView.image = photo.image;


        
    
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Header" forIndexPath:indexPath];
        
        UILabel *label = [header viewWithTag:1];
        if (self.segmentedControl.selectedSegmentIndex == 0) {
            if (indexPath.section == 0) {
                label.text = [NSString stringWithFormat:@"Personal Favourites"];
            }
            else
            {
                label.text = [NSString stringWithFormat:@"Other"];
            }
        }
        if (self.segmentedControl.selectedSegmentIndex == 1) {
            if (indexPath.section == 0) {
                label.text = [NSString stringWithFormat:@"Canada"];
            }
            else
            {
                label.text = [NSString stringWithFormat:@"World"];
            }
        }

        
        return header;
    }
    
    
    return nil;
}

@end
