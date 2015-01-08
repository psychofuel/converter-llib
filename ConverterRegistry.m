//
//  ConverterRegistry.m
//  Convertor
//
//  Created by Ivan on 1/6/15.
//

#import "ConverterRegistry.h"
#import "Converter.h"


@interface ConverterRegistry ()

@property (nonatomic, strong) NSMutableDictionary *converters;

@end


@implementation ConverterRegistry

#pragma mark - Allocation

- (instancetype)init {
    if (self = [super init]) {
        _converters = [NSMutableDictionary new];
    }
    return self;
}

#pragma  mark - Public

- (ConverterRegistry *)registerConverterBySource:(id)sourse byTarget:(id)target andConvertor:(id)convertor {
    return [self registerConverterInternalBySource:sourse byTarget:target andConvertor:convertor];
}

- (id)convertSource:(id)sourse toTargetClass:(Class)targetClass {
    //convert from structure type to app type see:
    //https://developer.apple.com/library/ios/documentation/General/Conceptual/CocoaEncyclopedia/Toll-FreeBridgin/Toll-FreeBridgin.html#//apple_ref/doc/uid/TP40010810-CH2
    
    Class sourceClass = [sourse class];
    if ([sourse isKindOfClass:[NSString class]]) {
        sourceClass = [NSString class];
    } else if ([sourse isKindOfClass:[NSDate class]]) {
        sourceClass = [NSDate class];
    } else if ([sourse isKindOfClass:[NSNumber class]]) {
        sourceClass = [NSNumber class];
    }
    
    id <Converter> converter = [self getConverterBySource:sourceClass andTarget:targetClass];
    return [converter convert:sourse];
}


#pragma  mark - Private

/**
 * Returns type converter for specified obj-c types.
 *
 * @param source Class source obj-c type
 * @param target Class target obj-c type
 * @return an instance of {@link Converter}.
 *         <code>null</code> assert - converter not supported
 */
- (id)getConverterBySource:(Class)sourseClass andTarget:(Class)targetClass {
    NSString *mappingKey = [self converterUnicKeyBySource:sourseClass andTargetClass:targetClass];
    id result = [self.converters objectForKey:mappingKey];
    NSAssert((result != nil), @"converter from '%@' to '%@' not supported", NSStringFromClass(sourseClass), NSStringFromClass(targetClass));
    return result;
}

- (ConverterRegistry *)registerConverterInternalBySource:(id)sourse byTarget:(id)target andConvertor:(id)convertor {
    NSString *mappingKey = [self converterUnicKeyBySource:[sourse class] andTargetClass:[target class]];
    NSAssert(([self.converters objectForKey:mappingKey] == nil), @"converter from '%@' to '%@' already registered", NSStringFromClass([sourse class]), NSStringFromClass([target class]));
   
    @synchronized (self) {
        [self.converters setObject:convertor forKey:mappingKey];
    }
    
    return self;
}

- (NSString *)converterUnicKeyBySource:(Class)source andTargetClass:(Class)target {
    return [NSString stringWithFormat:@"From%@To%@", NSStringFromClass(source), NSStringFromClass(target)];
}

@end
