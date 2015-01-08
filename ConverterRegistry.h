//
//  ConverterRegistry.h
//  Convertor
//
//  Created by Ivan on 1/6/15.
//

#import <Foundation/Foundation.h>

/**
 * A class for organizing converters.
 *
 * <p>Contains method for registering and obtaining type converters</p>
 *
 */
@interface ConverterRegistry : NSObject

/**
 * Register specified converter in this converter registry.
 * @param source Class source type
 * @param target Class target type
 * @param converter converter instance
 * @return this object for easy chaining
 */
- (ConverterRegistry *)registerConverterBySource:(id)sourse byTarget:(id)target andConvertor:(id)convertor;

/**
 * @return value (has targetClass type)
 *
 * @param source  - value
 * @param target Class target obj-c type
 * @return an instance of {@link Converter}.
 *         <code>null</code> assert - no converter is found.
 */
- (id)convertSource:(id)sourse toTargetClass:(Class)targetClass;

@end
