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


+ (ConverterRegistry *)sharedConverter;

/**
 * Register specified converter in this converter registry.
 * @param source Class source type
 * @param target Class target type
 * @param converter converter instance
 * @return this object for easy chaining
 */
- (ConverterRegistry *)registerConverterBySource:(id)sourse byTarget:(id)target andConvertor:(id)convertor;

/**
 * Returns type converter for specified obj-c types.
 *
 * @param source Class source java type
 * @param target Class target java type
 * @return an instance of {@link Converter}.
 *         <code>null</code> assert - no converter is found.
 */
- (id)getConverterBySource:(id)sourse andTarget:(id)target;


@end
