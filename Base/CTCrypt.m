//
//  CTCrypt.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2013/01/22.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import "CTCrypt.h"

@implementation CTCrypt

// AES暗号化復号化
+ (NSData *) AES128Crypt:(NSData *)sourceData operation:(CCOperation)operation key:(NSString *)key initialVector:(NSString *)initialVector
{
    // キー
    char keyPointer[kCCKeySizeAES128 + 1];
    memset(keyPointer, 0, sizeof(keyPointer));
    [key getCString:keyPointer maxLength:sizeof(keyPointer) encoding:NSUTF8StringEncoding];
    
    // ブロック
    char ivPointer[kCCBlockSizeAES128 + 1];
    memset(ivPointer, 0, sizeof(ivPointer));
    [initialVector getCString:ivPointer maxLength:sizeof(ivPointer) encoding:NSUTF8StringEncoding];
    
    // データセット
    NSUInteger dataLength = [sourceData length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    // 変換
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPointer,
                                          kCCBlockSizeAES128,
                                          ivPointer,
                                          [sourceData bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess)
    {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
    }
    return nil;
}


// AES暗号化
+ (NSData *) AES128Encrypt:(NSData *)sourceData key:(NSString *)key initialVector:(NSString *)initialVector
{
    return [self AES128Crypt:sourceData operation:kCCEncrypt key:key initialVector:initialVector];
}

// AES復号化
+ (NSData *) AES128Decrypt:(NSData *)sourceData key:(NSString *)key initialVector:(NSString *)initialVector
{
    return [self AES128Crypt:sourceData operation:kCCDecrypt key:key initialVector:initialVector];
}

// 変換マップ
#define xx 65
#define BINARY_UNIT_SIZE 3
#define BASE64_UNIT_SIZE 4
#define MAX_NUM_PADDING_CHARS 2
#define OUTPUT_LINE_LENGTH 64
#define INPUT_LINE_LENGTH ((OUTPUT_LINE_LENGTH / BASE64_UNIT_SIZE) * BINARY_UNIT_SIZE)
#define CR_LF_SIZE 2
static unsigned char ENCODE_MAP[65] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

static unsigned char DECODE_MAP[256] =
{
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, 62, xx, xx, xx, 63,
    52, 53, 54, 55, 56, 57, 58, 59, 60, 61, xx, xx, xx, xx, xx, xx,
    xx,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
    15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, xx, xx, xx, xx, xx,
    xx, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
};

// base64エンコードする
+ (NSString *) base64EncodeFromString:(NSString *)stringValue
{
    return [self base64EncodeFromString:stringValue separatedLine:NO];
}

// base64エンコードする
+ (NSString *) base64EncodeFromString:(NSString *)stringValue separatedLine:(BOOL)separatedLine
{
    NSData *result = [self base64EncodeFromData:[stringValue dataUsingEncoding:NSUTF8StringEncoding] separatedLine:separatedLine];
    return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    
}

// base64デコードする
+ (NSString *) base64DecodeFromString:(NSString *)stringValue
{
    NSData *result = [self base64DecodeFromData:[stringValue dataUsingEncoding:NSUTF8StringEncoding]];
    return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    
}


// base64エンコードする
+ (NSData *) base64EncodeFromData:(NSData *)dataValue
{
    return [self base64EncodeFromData:dataValue separatedLine:NO];
}

// base64エンコードする
+ (NSData *) base64EncodeFromData:(NSData *)dataValue separatedLine:(BOOL)separatedLine
{
    // 入力データ
    NSData *dataInput = dataValue;
    const char *bufferInput = [dataInput bytes];
    size_t dataLength = [dataInput length];
    
	//
	// Byte accurate calculation of final buffer size
	//
	size_t outputBufferSize = ((dataLength / BINARY_UNIT_SIZE) + ((dataLength % BINARY_UNIT_SIZE) ? 1 : 0)) * BASE64_UNIT_SIZE;
	if (separatedLine == YES)
	{
		outputBufferSize += (outputBufferSize / OUTPUT_LINE_LENGTH) * CR_LF_SIZE;
	}
	
	//
	// Include space for a terminating zero
	//
	outputBufferSize += 1;
    
	//
	// Allocate the output buffer
	//
	char *bufferOutput = (char *)malloc(outputBufferSize);
	if (!bufferOutput)
	{
		return NULL;
	}
    
	size_t i = 0;
	size_t j = 0;
	const size_t lineLength = separatedLine ? INPUT_LINE_LENGTH : dataLength;
	size_t lineEnd = lineLength;
	
	while (true)
	{
		if (lineEnd > dataLength)
		{
			lineEnd = dataLength;
		}
        
		for (; i + BINARY_UNIT_SIZE - 1 < lineEnd; i += BINARY_UNIT_SIZE)
		{
			//
			// Inner loop: turn 48 bytes into 64 base64 characters
			//
			bufferOutput[j++] = ENCODE_MAP[(bufferInput[i] & 0xFC) >> 2];
			bufferOutput[j++] = ENCODE_MAP[((bufferInput[i] & 0x03) << 4)
                                           | ((bufferInput[i + 1] & 0xF0) >> 4)];
			bufferOutput[j++] = ENCODE_MAP[((bufferInput[i + 1] & 0x0F) << 2)
                                           | ((bufferInput[i + 2] & 0xC0) >> 6)];
			bufferOutput[j++] = ENCODE_MAP[bufferInput[i + 2] & 0x3F];
		}
		
		if (lineEnd == dataLength)
		{
			break;
		}
		
		//
		// Add the newline
		//
		bufferOutput[j++] = '\r';
		bufferOutput[j++] = '\n';
		lineEnd += lineLength;
	}
	
	if (i + 1 < dataLength)
	{
		//
		// Handle the single '=' case
		//
		bufferOutput[j++] = ENCODE_MAP[(bufferInput[i] & 0xFC) >> 2];
		bufferOutput[j++] = ENCODE_MAP[((bufferInput[i] & 0x03) << 4)
                                       | ((bufferInput[i + 1] & 0xF0) >> 4)];
		bufferOutput[j++] = ENCODE_MAP[(bufferInput[i + 1] & 0x0F) << 2];
        bufferOutput[j++] =	'=';
	}
	else if (i < dataLength)
	{
		//
		// Handle the double '=' case
		//
		bufferOutput[j++] = ENCODE_MAP[(bufferInput[i] & 0xFC) >> 2];
		bufferOutput[j++] = ENCODE_MAP[(bufferInput[i] & 0x03) << 4];
        bufferOutput[j++] = '=';
        bufferOutput[j++] = '=';
	}
	bufferOutput[j] = 0;

	return [NSData dataWithBytes:bufferOutput length:outputBufferSize];
}

// base64デコードする
+ (NSData *) base64DecodeFromData:(NSData *)dataValue
{
    // 入力データ
    NSData *dataInput = dataValue;
    const char *bufferInput = [dataInput bytes];
    size_t dataLength = [dataInput length];
    
	if (dataLength == -1)
	{
		dataLength = strlen(bufferInput);
	}
	
	size_t bufferOutputSize = ((dataLength + BASE64_UNIT_SIZE - 1) / BASE64_UNIT_SIZE) * BINARY_UNIT_SIZE;
	char *bufferOutput = (char *)malloc(bufferOutputSize);
	
	size_t i = 0;
	size_t j = 0;
	while (i < dataLength)
	{
		//
		// Accumulate 4 valid characters (ignore everything else)
		//
		unsigned char accumulated[BASE64_UNIT_SIZE];
		size_t accumulateIndex = 0;
		while (i < dataLength)
		{
			unsigned char decode = DECODE_MAP[bufferInput[i++]];
			if (decode != xx)
			{
				accumulated[accumulateIndex] = decode;
				accumulateIndex++;
				
				if (accumulateIndex == BASE64_UNIT_SIZE)
				{
					break;
				}
			}
		}
		
		//
		// Store the 6 bits from each of the 4 characters as 3 bytes
		//
		// (Uses improved bounds checking suggested by Alexandre Colucci)
		//
		if(accumulateIndex >= 2)
        {
			bufferOutput[j] = (accumulated[0] << 2) | (accumulated[1] >> 4);
        }
		if(accumulateIndex >= 3)
        {
			bufferOutput[j + 1] = (accumulated[1] << 4) | (accumulated[2] >> 2);
        }
		if(accumulateIndex >= 4)
        {
			bufferOutput[j + 2] = (accumulated[2] << 6) | accumulated[3];
        }
		j += accumulateIndex - 1;
	}
	
    return [NSData dataWithBytes:bufferOutput length:j];
}

@end
