//
//  WeatherHTTPClient.m
//  Weather
//
//  Created by Chao Xu on 14-1-16.
//  Copyright (c) 2014年 Scott Sherwood. All rights reserved.
//

#import "WeatherHTTPClient.h"

@implementation WeatherHTTPClient

+(WeatherHTTPClient *)sharedWeatherHTTPClient{
    NSString *urlStr = @"http://api.worldweatheronline.com/free/v1/";
    
    static dispatch_once_t pred;
    static WeatherHTTPClient *_sharedWeatherHTTPClient = nil;
    
    dispatch_once(&pred, ^{ _sharedWeatherHTTPClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:urlStr]]; });
    return _sharedWeatherHTTPClient;
}

-(id)initWithBaseURL:(NSURL *)url{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}
-(void)updateWeatherAtLocation:(CLLocation *)location forNumberOfDays:(int)number{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[NSString stringWithFormat:@"%d",number] forKey:@"num_of_days"];
    [parameters setObject:[NSString stringWithFormat:@"%f,%f",location.coordinate.latitude,location.coordinate.longitude] forKey:@"q"];
    [parameters setObject:@"json" forKey:@"format"];
    [parameters setObject:@"wrvrtxuugz6e56q9fy2ae5vx" forKey:@"key"];
    //[parameters setObject:@"7f3a3480fc162445131401" forKey:@"key"];
    [self getPath:@"weather.ashx"
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if([self.delegate respondsToSelector:@selector(weatherHTTPClient:didUpdateWithWeather:)])
                  [self.delegate weatherHTTPClient:self didUpdateWithWeather:responseObject];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if([self.delegate respondsToSelector:@selector(weatherHttpClient:didFailWithError:)])
                  [self.delegate weatherHttpClient:self didFailWithError:error];
          }];
}
@end




































