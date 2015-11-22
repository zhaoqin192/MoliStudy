//
//  RSA.h
//  
//
//  Created by zhaoqin on 11/22/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//
//

#import <Foundation/Foundation.h>

@interface RSA : NSObject{
    SecKeyRef publicKey;
    SecCertificateRef certificate;
    SecPolicyRef policy;
    SecTrustRef trust;
    size_t maxPlainLen;
}

- (NSData *) encryptWithData:(NSData *)content;
- (NSString *) encryptWithString:(NSString *)content;

@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) NSString *str1;
@end
