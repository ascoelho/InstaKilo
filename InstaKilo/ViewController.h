//
//  ViewController.h
//  InstaKilo
//
//  Created by Anthony Coelho on 2016-05-18.
//  Copyright © 2016 Anthony Coelho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;




@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *photosArray;
@property (nonatomic, strong) NSMutableArray *sectionsArray;

@end

