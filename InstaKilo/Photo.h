//
//  Photo.h
//  InstaKilo
//
//  Created by Anthony Coelho on 2016-05-18.
//  Copyright © 2016 Anthony Coelho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Photo : NSObject

@property (strong, nonatomic) UIImage *image;
@property (copy, nonatomic) NSString *subject;
@property (copy, nonatomic) NSString *location;

@end
