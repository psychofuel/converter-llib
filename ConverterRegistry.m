//
//  ConverterRegistry.m
//  Convertor
//
//  Created by Ivan on 1/6/15.
//

#import "ConverterRegistry.h"


@interface ConverterRegistry ()

@property (nonatomic, strong) NSMutableDictionary *converters;

@end


@implementation ConverterRegistry

#pragma mark - Allocation

+ (ConverterRegistry *)sharedConverter {
    static ConverterRegistry *Converter = nil;
    
    @synchronized(self) {
        if (Converter == nil) {
            Converter = [ConverterRegistry new];
        }
    }
    
    return Converter;
}

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

- (id)getConverterBySource:(id)sourse andTarget:(id)target {
    NSString *mappingKey = [self converterUnicKeyBySource:[sourse class] andTargetClass:[target class]];
    id result = [self.converters objectForKey:mappingKey];
    NSAssert((result == nil), @"Converter from '%@' to '%@' unsupported", NSStringFromClass([sourse class]), NSStringFromClass([target class]));
    return result;
}


#pragma  mark - Private

- (ConverterRegistry *)registerConverterInternalBySource:(id)sourse byTarget:(id)target andConvertor:(id)convertor {
    NSString *mappingKey = [self converterUnicKeyBySource:[sourse class] andTargetClass:[target class]];
    NSAssert(([self.converters objectForKey:mappingKey] != nil), @"Converter from '%@' to '%@' already registered.", NSStringFromClass([sourse class]), NSStringFromClass([target class]));
   
    @synchronized (self) {
        [self.converters setObject:convertor forKey:mappingKey];
    }
    
    return self;
}

- (NSString *)converterUnicKeyBySource:(Class)source andTargetClass:(Class)target {
    return [NSString stringWithFormat:@"from%@to%@", NSStringFromClass(source), NSStringFromClass(target)];
}

@end
