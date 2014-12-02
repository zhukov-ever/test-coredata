//
//  CatManager.h
//  test-coredata
//
//  Created by Zhn on 2/12/2014.
//  Copyright (c) 2014 Zhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cat.h"
#import "CatDetails.h"

@interface CatManager : NSObject

+(CatManager*)shared;

@property (nonatomic, strong) NSArray* arrayCats;

-(void) load:(void (^)(void))completitionBlock;
-(void) addRandomCat:(void (^)(void))completitionBlock;


#pragma mark - Core Data Saving support
- (void)saveContext;

@end
