#import <MLKitPoseDetection/MLKitPoseDetection.h>
#import <MLKitPoseDetectionCommon/MLKitPoseDetectionCommon.h>
#import <VisionCamera/FrameProcessorPlugin.h>
#import <VisionCamera/FrameProcessorPluginRegistry.h>
#import <VisionCamera/VisionCameraProxy.h>
#import <VisionCamera/Frame.h>
@import MLKitVision;

@interface VisionCameraV3PoseDetectionPlugin : FrameProcessorPlugin
@end

@implementation VisionCameraV3PoseDetectionPlugin{
    MLKPoseDetectorOptions *options;
}

- (instancetype _Nonnull)initWithProxy:(VisionCameraProxyHolder*)proxy
                           withOptions:(NSDictionary* _Nullable)options {
  self = [super initWithProxy:proxy withOptions:options];
  return self;
}

- (id _Nullable)callback:(Frame* _Nonnull)frame
           withArguments:(NSDictionary* _Nullable)arguments {
    MLKPoseDetectorOptions *options = [[MLKPoseDetectorOptions alloc] init];

    if (arguments != nil && [arguments.allKeys containsObject:@"mode"]) {
        NSString *mode = arguments[@"mode"];
        if ([mode  isEqual: @"stream"]) {
            options.detectorMode = MLKPoseDetectorModeStream;
        } else if ([mode  isEqual: @"single"]){
            options.detectorMode = MLKPoseDetectorModeSingleImage;
        }else {
            options.detectorMode = MLKPoseDetectorModeStream;
        }
    }
    CMSampleBufferRef buffer = frame.buffer;
    UIImageOrientation orientation = frame.orientation;
    MLKVisionImage *image = [[MLKVisionImage alloc] initWithBuffer:buffer];
    image.orientation = orientation;
    MLKPoseDetector *poseDetector =[MLKPoseDetector poseDetectorWithOptions:options];

    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    dispatch_group_t dispatchGroup = dispatch_group_create();
    dispatch_group_enter(dispatchGroup);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [poseDetector processImage:image
                   completion:^(NSArray<MLKPose*> *_Nullable poses,
                              NSError *_Nullable error) {
           if (error != nil) {
              [NSException raise:@"Error processing Pose Detection" format:@"%@",error];
          }
            if (poses.count > 0) {

                for (MLKPose *pose in poses) {
                    MLKPoseLandmark *leftShoulderPosition = [pose landmarkOfType:MLKPoseLandmarkTypeLeftShoulder];
                    if (leftShoulderPosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = leftShoulderPosition.position;
                        data[@"leftShoulderPosition"] = @{@"x": @(position.x), @"y": @(  position.y)};
                    }
                    MLKPoseLandmark *rightShoulderPosition = [pose landmarkOfType:MLKPoseLandmarkTypeRightShoulder];
                    if (rightShoulderPosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = leftShoulderPosition.position;
                        data[@"rightShoulderPosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }
                    MLKPoseLandmark *leftElbowPosition = [pose landmarkOfType:MLKPoseLandmarkTypeLeftElbow];
                    if (leftElbowPosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = leftElbowPosition.position;
                        data[@"leftElbowPosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }
                    MLKPoseLandmark *rightElbowPosition = [pose landmarkOfType:MLKPoseLandmarkTypeRightElbow];
                    if (rightElbowPosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = rightElbowPosition.position;
                        data[@"rightElbowPosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }
                    MLKPoseLandmark *leftWristPosition = [pose landmarkOfType:MLKPoseLandmarkTypeLeftWrist];
                    if (leftWristPosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = leftWristPosition.position;
                        data[@"leftWristPosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }
                    MLKPoseLandmark *rightWristPosition = [pose landmarkOfType:MLKPoseLandmarkTypeRightWrist];
                    if (rightWristPosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = rightWristPosition.position;
                        data[@"rightWristPosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }
                    MLKPoseLandmark *leftHipPosition = [pose landmarkOfType:MLKPoseLandmarkTypeLeftHip];

                    if (leftHipPosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = leftHipPosition.position;
                        data[@"leftHipPosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }
                    MLKPoseLandmark *rightHipPosition = [pose landmarkOfType:MLKPoseLandmarkTypeRightHip];
                    if (rightHipPosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = rightHipPosition.position;
                        data[@"rightHipPosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }
                    MLKPoseLandmark *leftKneePosition = [pose landmarkOfType:MLKPoseLandmarkTypeLeftKnee];
                    if (leftKneePosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = leftKneePosition.position;
                        data[@"leftKneePosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }
                    MLKPoseLandmark *rightKneePosition = [pose landmarkOfType:MLKPoseLandmarkTypeRightKnee];
                    if (rightKneePosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = rightKneePosition.position;
                        data[@"rightKneePosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }
                    MLKPoseLandmark *leftAnklePosition = [pose landmarkOfType:MLKPoseLandmarkTypeLeftAnkle];
                    if (leftAnklePosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = leftAnklePosition.position;
                        data[@"leftAnklePosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }
                    MLKPoseLandmark *rightAnklePosition = [pose landmarkOfType:MLKPoseLandmarkTypeRightAnkle];
                    if (rightAnklePosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = rightAnklePosition.position;
                        data[@"rightAnklePosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }
                    MLKPoseLandmark *leftPinkyPosition = [pose landmarkOfType:MLKPoseLandmarkTypeLeftPinkyFinger];
                    if (leftPinkyPosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = leftPinkyPosition.position;
                        data[@"leftPinkyPosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }
                    MLKPoseLandmark *rightPinkyPosition = [pose landmarkOfType:MLKPoseLandmarkTypeRightPinkyFinger];
                    if (rightPinkyPosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = rightPinkyPosition.position;
                        data[@"rightPinkyPosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }
                    MLKPoseLandmark *leftIndexPosition = [pose landmarkOfType:MLKPoseLandmarkTypeLeftIndexFinger];
                    if (leftIndexPosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = leftIndexPosition.position;
                        data[@"leftIndexPosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }
                    MLKPoseLandmark *rightIndexPosition = [pose landmarkOfType:MLKPoseLandmarkTypeRightIndexFinger];
                    if (rightIndexPosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = rightIndexPosition.position;
                        data[@"rightIndexPosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }
                    MLKPoseLandmark *leftThumbPosition = [pose landmarkOfType:MLKPoseLandmarkTypeLeftThumb];
                    if (leftThumbPosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = leftThumbPosition.position;
                        data[@"leftThumbPosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }
                    MLKPoseLandmark *rightThumbPosition = [pose landmarkOfType:MLKPoseLandmarkTypeRightThumb];
                    if (rightThumbPosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = rightThumbPosition.position;
                        data[@"rightThumbPosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }
                    MLKPoseLandmark *leftHeelPosition = [pose landmarkOfType:MLKPoseLandmarkTypeLeftHeel];
                    if (leftHeelPosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = leftHeelPosition.position;
                        data[@"leftHeelPosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }
                    MLKPoseLandmark *rightHeelPosition = [pose landmarkOfType:MLKPoseLandmarkTypeRightHeel];
                    if (rightHeelPosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = rightHeelPosition.position;
                        data[@"rightHeelPosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }
                    MLKPoseLandmark *nosePosition = [pose landmarkOfType:MLKPoseLandmarkTypeNose];
                    if (nosePosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = nosePosition.position;
                        data[@"nosePosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }
                    MLKPoseLandmark *leftFootIndexPosition = [pose landmarkOfType:MLKPoseLandmarkTypeLeftToe];
                    if (leftFootIndexPosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = leftFootIndexPosition.position;
                        data[@"leftFootIndexPosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }
                    MLKPoseLandmark *rightFootIndexPosition = [pose landmarkOfType:MLKPoseLandmarkTypeRightToe];
                    if (rightFootIndexPosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = rightFootIndexPosition.position;
                        data[@"rightFootIndexPosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }
                    MLKPoseLandmark *leftEyeInnerPosition = [pose landmarkOfType:MLKPoseLandmarkTypeLeftEyeInner];
                    if (leftEyeInnerPosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = leftEyeInnerPosition.position;
                        data[@"leftEyeInnerPosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }
                    MLKPoseLandmark *rightEyeInnerPosition = [pose landmarkOfType:MLKPoseLandmarkTypeRightEyeInner];
                    if (rightEyeInnerPosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = rightEyeInnerPosition.position;
                        data[@"rightEyeInnerPosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }
                    MLKPoseLandmark *leftEyePosition = [pose landmarkOfType:MLKPoseLandmarkTypeLeftEye];
                    if (leftEyePosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = leftEyePosition.position;
                        data[@"leftEyePosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }
                    MLKPoseLandmark *rightEyePosition = [pose landmarkOfType:MLKPoseLandmarkTypeRightEye];
                    if (rightEyePosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = rightEyePosition.position;
                        data[@"rightEyePosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }
                    MLKPoseLandmark *leftEyeOuterPosition = [pose landmarkOfType:MLKPoseLandmarkTypeLeftEyeOuter];
                    if (leftEyeOuterPosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = leftEyeOuterPosition.position;
                        data[@"leftEyeOuterPosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }
                    MLKPoseLandmark *rightEyeOuterPosition = [pose landmarkOfType:MLKPoseLandmarkTypeRightEyeOuter];
                    if (rightEyeOuterPosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = rightEyeOuterPosition.position;
                        data[@"rightEyeOuterPosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }
                    MLKPoseLandmark *leftEarPosition = [pose landmarkOfType:MLKPoseLandmarkTypeLeftEar];
                    if (leftEarPosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = leftEarPosition.position;
                        data[@"leftEarPosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }
                    MLKPoseLandmark *rightEarPosition = [pose landmarkOfType:MLKPoseLandmarkTypeRightEar];
                    if (rightEarPosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = rightEarPosition.position;
                        data[@"rightEarPosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }
                    MLKPoseLandmark *leftMouthPosition = [pose landmarkOfType:MLKPoseLandmarkTypeMouthLeft];
                    if (leftMouthPosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = leftMouthPosition.position;
                        data[@"leftMouthPosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }
                    MLKPoseLandmark *rightMouthPosition = [pose landmarkOfType:MLKPoseLandmarkTypeMouthRight];
                    if (rightMouthPosition.inFrameLikelihood > 0.5) {
                        MLKVision3DPoint *position = rightMouthPosition.position;
                        data[@"rightMouthPosition"] = @{@"x": @(position.x), @"y": @(position.y)};
                    }

                }
            }
            dispatch_group_leave(dispatchGroup);

        }];
        });
    dispatch_group_wait(dispatchGroup, DISPATCH_TIME_FOREVER);
    return data;
}

VISION_EXPORT_FRAME_PROCESSOR(VisionCameraV3PoseDetectionPlugin, detectPose)

@end

