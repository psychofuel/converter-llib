//
//  ConverterRegistry.h
//  Convertor
//
//  Created by Ivan on 1/6/15.
//

#import <Foundation/Foundation.h>


@interface ConverterRegistry : NSObject

+ (id)registerConverterBySource:(id)sourse byTarget:(id)target andConvertor:(id)Convertor;

//+ (id)registerConverterUntyped

//- (id)getConverterBySource:(id)sourse andTarget:(id)target;

//- (int)converterHashCode;

@end
