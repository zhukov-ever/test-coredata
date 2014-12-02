//
//  CatManager.m
//  test-coredata
//
//  Created by Zhn on 2/12/2014.
//  Copyright (c) 2014 Zhn. All rights reserved.
//

#import "CatManager.h"
#import <CoreData/CoreData.h>

@interface CatManager()

@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation CatManager
@synthesize arrayCats= _arrayCats;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


static CatManager* m_shared;
+(CatManager*)shared
{
    if (!m_shared)
    {
        m_shared = [CatManager new];
    }
    return m_shared;
}

-(NSArray *)arrayCats
{
    if (!_arrayCats)
    {
        _arrayCats = @[];
    }
    return _arrayCats;
}

-(void) load:(void (^)(void))completitionBlock
{
    NSMutableArray* _rezult = [NSMutableArray new];
    
    NSError *error;
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Cat"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (Cat *_info in fetchedObjects) {
        [_rezult addObject:_info];
    }
    
    self.arrayCats = [NSArray arrayWithArray:_rezult];
    
    completitionBlock();
}


-(void) addRandomCat:(void (^)(void))completitionBlock
{
    NSError *error;
    NSManagedObjectContext *context = [self managedObjectContext];
    Cat *_cat = [NSEntityDescription insertNewObjectForEntityForName:@"Cat"
                                              inManagedObjectContext:context];
    
    _cat.name = [NSString stringWithFormat:@"random cat #%@",@(rand()%100)];
    _cat.hasFur = [NSNumber numberWithBool:NO];
    
    CatDetails *_catDetails = [NSEntityDescription
                               insertNewObjectForEntityForName:@"CatDetails"
                               inManagedObjectContext:context];
    _catDetails.dateBorn = [NSDate date];
    _catDetails.dateReborn = [NSDate date];
    _catDetails.isVampire = [NSNumber numberWithBool:NO];
    
    _catDetails.info = _cat;
    _cat.details = _catDetails;
    
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    self.arrayCats = [self.arrayCats arrayByAddingObject:_cat];

    completitionBlock();
}


/*
    NSError *error;
    NSManagedObjectContext *context = [self managedObjectContext];
    Cat *_cat = [NSEntityDescription insertNewObjectForEntityForName:@"Cat"
                                                          inManagedObjectContext:context];
    _cat.name = @"Perry";
    _cat.hasFur = [NSNumber numberWithBool:YES];

    CatDetails *_catDetails = [NSEntityDescription
                               insertNewObjectForEntityForName:@"CatDetails"
                               inManagedObjectContext:context];
    _catDetails.dateBorn = [NSDate date];
    _catDetails.dateReborn = [NSDate date];
    _catDetails.isVampire = [NSNumber numberWithBool:YES];

    _catDetails.info = _cat;
    _cat.details = _catDetails;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
*/

#pragma mark - CoreData

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "home.test_coredata" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"test_coredata" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"test_coredata.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
