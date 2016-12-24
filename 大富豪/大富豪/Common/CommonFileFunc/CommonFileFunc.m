
#import "CommonFileFunc.h"

@implementation CommonFileFunc


+ (NSString *) getFilePath:(NSString *)file
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSMutableString * filepath = [NSMutableString stringWithCapacity:10];
	[filepath appendString:documentsDirectory];
	[filepath appendString:@"/"];
	[filepath appendString:file];
	
	return filepath;
}

+ (NSString *)getDocumentFilePath:(NSString *)fileName
{
    NSString *documentsDirectory = [[self class] getDocumentFolderPath];
    NSString *filepath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, fileName];
    return filepath;
}

+ (NSString *)getDocumentFolderPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

+ (NSString *)getLibraryCachesFilePath:(NSString *)fileName
{
    NSString *cachesDir = [[self class] getLibraryCachesFolderPath];
    NSString *filepath  = [NSString stringWithFormat:@"%@/%@", cachesDir, fileName];
    return filepath;
}

+ (NSString *)getLibraryCachesFolderPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    return cachesDir;
}

+ (BOOL)checkDir:(NSString *)filepath
{
	NSFileManager * fm = [NSFileManager defaultManager];
	if (![fm fileExistsAtPath:filepath]) {
		NSError * err = nil;
		if (![fm createDirectoryAtPath:filepath withIntermediateDirectories:YES attributes:nil error:&err])
			return NO;
	}
	return YES;
}

+ (BOOL)removeFilePath:(NSString *)filepath
{
	NSError * err = nil;
	return [[NSFileManager defaultManager] removeItemAtPath:filepath error:&err];
}

+ (unsigned long long)fileSizeForDir:(NSString*)path
{
    unsigned long long size = 0;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    NSArray* array = [fileManager contentsOfDirectoryAtPath:path error:nil];
    for(int i = 0; i<[array count]; i++)
    {
        NSString *fullPath = [path stringByAppendingPathComponent:[array objectAtIndex:i]];
        
        BOOL isDir;
        if ( !([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && isDir) )
        {
            NSDictionary *fileAttributeDic = [fileManager attributesOfItemAtPath:fullPath error:nil];
            size += fileAttributeDic.fileSize;
        }
        else
        {
            size += [self fileSizeForDir:fullPath];
        }
    }
    return size;
}

+ (unsigned long long)fileSizeForPath:(NSString *)path
{
    unsigned long long fileSizeBytes = 0;
    const char *filePath = [path UTF8String];
    FILE *file = fopen(filePath,"r");
    
    if (file > 0)
    {
        fseek(file, 0, SEEK_END);
        fileSizeBytes = ftell(file);
        fseek(file, 0, SEEK_SET);
        fclose(file);
    }
    return fileSizeBytes;
}

//+ (unsigned long long)fileSizeForPath:(NSString *)path
//{
//    unsigned long long fileSize = 0;
//    NSFileManager * filemanager = [[NSFileManager alloc] init];
//    
//    BOOL isDirectory;
//    
//    if([filemanager fileExistsAtPath:path isDirectory:&isDirectory])
//    {   
//        NSDictionary * attributes = [filemanager attributesOfItemAtPath:path error:nil];
//        NSNumber *theFileSize = [attributes objectForKey:NSFileSize];
//        fileSize = [theFileSize unsignedLongLongValue];
//    }
//    
//    return fileSize;
//}

+ (BOOL)createDirector:(NSString *)directorPath
{
    NSFileManager *myFile = [NSFileManager defaultManager];
    BOOL isDir;
    BOOL isExist    = [myFile fileExistsAtPath:directorPath isDirectory:&isDir];
    BOOL bRet       = isExist ? YES : NO;
    
    if (!isExist)
    {
        bRet = [myFile createDirectoryAtPath:directorPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return bRet;
}

+ (BOOL)saveDataToDirector:(NSString *)directorPath fileName:(NSString *)fileName data:(NSData *)data
{
    BOOL retSaveStatus = NO;
    BOOL bRet = [[self class] createDirector:directorPath];

    if (bRet && data)
    {
        NSString *savePath = [NSString stringWithFormat:@"%@/%@", directorPath, fileName];
        retSaveStatus = [data writeToFile:savePath atomically:YES];
    }

    return retSaveStatus;
}

+ (BOOL)saveArrayToDirector:(NSString *)directorPath fileName:(NSString *)fileName array:(NSArray *)array
{
    BOOL retSaveStatus = NO;
    BOOL bRet = [[self class] createDirector:directorPath];
    
    if (bRet && array)
    {
        NSString *savePath = [NSString stringWithFormat:@"%@/%@", directorPath, fileName];
        retSaveStatus = [array writeToFile:savePath atomically:YES];
    }
    
    return retSaveStatus;
}

+ (BOOL)saveDictionaryToDirector:(NSString *)directorPath fileName:(NSString *)fileName dict:(NSDictionary *)dict
{
    BOOL retSaveStatus = NO;
    BOOL bRet = [[self class] createDirector:directorPath];
    
    if (bRet && dict)
    {
        NSString *savePath = [NSString stringWithFormat:@"%@/%@", directorPath, fileName];
        retSaveStatus = [dict writeToFile:savePath atomically:YES];
    }
    
    return retSaveStatus;
}

+ (BOOL)removeDirectory:(NSString *)directorPath
{
    NSFileManager *myFile = [NSFileManager defaultManager];
    BOOL isDir;
    BOOL bRet = NO;

    BOOL isExist = [myFile fileExistsAtPath:directorPath isDirectory:&isDir];

    if (isExist)
    {
        bRet = [myFile removeItemAtPath:directorPath error:nil];
    }

    return bRet;
}

@end
