

#import "BaseModel.h"

@implementation BaseModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [self JSONDictionary];
}

+ (NSDictionary *)JSONDictionary
{
    //NSLog(@"子类需要重写%s",__FUNCTION__);
    return nil;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"没有发现这个字段%@",key);
}


@end
