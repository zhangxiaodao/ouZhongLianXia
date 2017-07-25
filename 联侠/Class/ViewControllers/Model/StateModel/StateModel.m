//
//  StateModel.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/4/12.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "StateModel.h"

@implementation StateModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    
    if ([key isEqualToString:@"fLock"]) {
        if ([value isKindOfClass:[NSNull class]]) {
            _fLock = 0;
        } else {
            _fLock = [value integerValue];
        }
    }  if ([key isEqualToString:@"fMode"]) {
        if ([value isKindOfClass:[NSNull class]]) {
            _fMode = 0;
        } else {
            _fMode = [value integerValue];
        }
    }  if ([key isEqualToString:@"fCold"]) {
        if ([value isKindOfClass:[NSNull class]]) {
            _fCold = 0;
        } else {
            _fCold = [value integerValue];
        }
    }  if ([key isEqualToString:@"fSwing"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _fSwing = 0;
        } else {
            _fSwing = [value integerValue];
        }
        
    }  if ([key isEqualToString:@"fSwitch"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _fSwitch = 0;
        } else {
            _fSwitch = [value integerValue];
        }
        
    }  if ([key isEqualToString:@"fUV"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _fUV = 0;
        } else {
            _fUV = [value integerValue];
        }
        
    } if ([key isEqualToString:@"fWind"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _fWind = 0;
        } else {
            _fWind = [value integerValue];
        }
        
    }  if ([key isEqualToString:@"fAuto"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _fAuto = 0;
        } else {
            _fAuto = [value integerValue];
        }
        
    }  if ([key isEqualToString:@"fSleep"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _fSleep = 0;
        } else {
            _fSleep = [value integerValue];
        }
        
    }  if ([key isEqualToString:@"fAnion"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _fAnion = 0;
        } else {
            _fAnion = [value integerValue];
        }
        
    } if ([key isEqualToString:@"fShift"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _fShift = 0;
        } else {
            _fShift = [value integerValue];
        }
        
    } if ([key isEqualToString:@"sCurrentC"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _sCurrentC = 0;
        } else {
            _sCurrentC = value;
        }
        
    }  if ([key isEqualToString:@"aqi"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _aqi = 0;
        } else {
            _aqi = value;
        }
        
    }  if ([key isEqualToString:@"sCleanFilterScreen"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _sCleanFilterScreen = 0;
        } else {
            _sCleanFilterScreen = [value integerValue];
        }
        
    }  if ([key isEqualToString:@"sChangeFilterScreen"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _sChangeFilterScreen = 0;
        } else {
            _sChangeFilterScreen = [value integerValue];
        }
        
    }  if ([key isEqualToString:@"sPm25"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _sPm25 = 0;
        } else {
            _sPm25 = value;
        }
        
    } if ([key isEqualToString:@"fLight"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _fLight = 0;
        } else {
            _fLight = [value integerValue];
        }
        
    }  if ([key isEqualToString:@"sCurrentH"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _sCurrentH = 0;
        } else {
            _sCurrentH = [value integerValue];
        }
        
    } if ([key isEqualToString:@"co2"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _co2 = 0;
        } else {
            _co2 = [value integerValue];
        }
        
    } if ([key isEqualToString:@"durTime"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _durTime = 0;
        } else {
            _durTime = [value integerValue];
        }
        
    } if ([key isEqualToString:@"sMethanal"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _sMethanal = 0;
        } else {
            _sMethanal = [value integerValue];
        }
        
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"fSwitch--%ld , _fWind--%ld , _fAnion--%ld , _fAuto--%ld , _fLight--%ld" , (long)_fSwitch , _fWind , _fAnion , _fAuto , _fLight];
}


@end
