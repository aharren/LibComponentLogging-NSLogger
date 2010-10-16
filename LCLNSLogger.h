//
//
// LCLNSLogger.h
//
//
// Copyright (c) 2010 Arne Harren <ah@0xc0.de>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


//
// LCLNSLogger
//
// LCLNSLogger is a logging back-end for LibComponentLogging which integrates
// the logging client from Florent Pillet's NSLogger project.
//
// See http://github.com/fpillet/NSLogger for more details about NSLogger.
//
// For using LCLNSLogger with LibComponentLogging, simply add an
//   #import "LCLNSLogger.h"
// statement to your lcl_config_logger.h file and use the LCLNSLoggerConfig.h
// file for detailed configuration of the LCLNSLogger class.
//
// In addition to the LCLNSLogger files, you need the following files from
// the Client Logger folder from the NSLogger project:
//
//   LoggerClient.h
//   LoggerClient.m
//   LoggerCommon.h
//
// You can download them from here: http://github.com/fpillet/NSLogger
//


#import <Foundation/Foundation.h>
#import "LCLNSLoggerConfig.h"


@interface LCLNSLogger : NSObject {
    
}


//
// Logging methods.
//


// Writes the given log message to the log.
+ (void)logWithComponent:(_lcl_component_t)component level:(uint32_t)level
                  format:(NSString *)format, ... __attribute__((format(__NSString__, 3, 4)));


@end


// Define the _lcl_logger macro which integrates LCLNSLogger as a logging
// back-end for LibComponentLogging.
#define _lcl_logger(_component, _level, _format, ...) {                        \
    NSAutoreleasePool *_lcl_logger_pool = [[NSAutoreleasePool alloc] init];    \
    [LCLNSLogger logWithComponent:_component                                   \
                            level:_level                                       \
                           format:_format,                                     \
                               ## __VA_ARGS__];                                \
    [_lcl_logger_pool release];                                                \
}

