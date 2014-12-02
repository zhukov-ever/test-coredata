//
//  Cat.h
//  test-coredata
//
//  Created by Zhn on 2/12/2014.
//  Copyright (c) 2014 Zhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CatDetails;

@interface Cat : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * hasFur;
@property (nonatomic, retain) CatDetails *details;

@end
