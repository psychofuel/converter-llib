//
//  Converter.h
//  Converter
//
//  Created by Ivan on 1/6/15.
//

#import <UIKit/UIKit.h>

/**
 * General purpose value converter interface.
 *
 * <p>It's implementation responsibility how to convert values an how to handle errors.</p>
 *
 * <ul>Use cases:
 *  <li>data binding</li>
 *  <li>data transformation</li>
 *  <li>etc.</li>
 * </ul>
 */
@protocol Converter

/**
 * Converts specified value.
 *
 * @param input a value to convert.
 * @return output an output value.
 * @throws ConverterException if value can't be converted.
 */
- (id)convert:(id)input;

@end