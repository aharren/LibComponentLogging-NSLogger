//
//
// LCLNSLogger.m
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

#import "LCLNSLogger.h"
#import "LoggerClient.h"


//
// Configuration checks.
//


#ifndef LCLNSLogger
#error  'LCLNSLogger' must be defined in LCLNSLoggerConfig.h
#endif


//
// Fields.
//


// The logger instance we use.
static Logger *_LCLNSLogger_logger = nil;

// Log component identifiers, indexed by log component.
NSString *_LCLNSLogger_identifier[] = {
#   define  _lcl_component(_identifier, _header, _name)                        \
    @#_identifier,
#   include "lcl_config_components.h"
#   undef   _lcl_component
};


@implementation LCLNSLogger


//
// Initialization.
//


// No instances, please.
+(id)alloc {
    [LCLNSLogger doesNotRecognizeSelector:_cmd];
    return nil;
}

// Initializes the class.
+ (void)initialize {
    // perform initialization only once
    if (self != [LCLNSLogger class])
        return;
    
    // create and remember the logger instance
    _LCLNSLogger_logger = LoggerInit();
    
    // get configuration
    const BOOL logToConsole = NO;
    const BOOL bufferLocallyUntilConnection = YES;
    const BOOL browseBonjour = YES;
    const BOOL browseOnlyLocalDomains = YES;

    // configure the logger
    LoggerSetOptions(_LCLNSLogger_logger, logToConsole, bufferLocallyUntilConnection, browseBonjour, browseOnlyLocalDomains);
    
    // activate the logger
    LoggerStart(_LCLNSLogger_logger);
}


//
// Logging methods.
//


// Writes the given log message to the log.
+ (void)logWithComponent:(_lcl_component_t)component level:(uint32_t)level
                  format:(NSString *)format, ... {
    NSString *domain = _LCLNSLogger_identifier[component];
    va_list args;
    va_start(args, format);
    LogMessageTo_va(_LCLNSLogger_logger, domain, (int)level, format, args);
    va_end(args);
}

@end

