//
//  CatDetails.h
//  test-coredata
//
//  Created by Zhn on 2/12/2014.
//  Copyright (c) 2014 Zhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Cat;

@interface CatDetails : NSManagedObject

@property (nonatomic, retain) NSDate * dateBorn;
@property (nonatomic, retain) NSDate * dateReborn;
@property (nonatomic, retain) NSNumber * isVampire;
@property (nonatomic, retain) Cat *info;

@end
