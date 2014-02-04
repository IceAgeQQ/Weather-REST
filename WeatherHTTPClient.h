//
//  WeatherHTTPClient.h
//  Weather
//
//  Created by Chao Xu on 14-1-16.
//  Copyright (c) 2014年 Scott Sherwood. All rights reserved.
//

#import "AFHTTPClient.h"

@protocol WeatherHttpClientDelegate;

@interface WeatherHTTPClient : AFHTTPClient

@property(weak) id<WeatherHttpClientDelegate> delegate;

+(WeatherHTTPClient *)sharedWeatherHTTPClient;
-(id)initWithBaseURL:(NSURL *)url;
-(void)updateWeatherAtLocation:(CLLocation *)location forNumberOfDays:(int)number;

@end

@protocol WeatherHttpClientDelegate <NSObject>

-(void)weatherHTTPClient:(WeatherHTTPClient *)client didUpdateWithWeather:(id)weather;
-(void)weatherHttpClient:(WeatherHTTPClient *)client didFailWithError:(NSError *)error;

@end