import type { CameraProps } from 'react-native-vision-camera';
export type {
  Frame,
  FrameProcessor,
  FrameProcessorPlugin,
} from 'react-native-vision-camera';

export type PoseType = {
  leftShoulderX: { ['x']: number; ['y']: number };
  rightShoulderX: { ['x']: number; ['y']: number };
  leftElbowX: { ['x']: number; ['y']: number };
  leftElbowY: { ['x']: number; ['y']: number };
  rightElbowX: { ['x']: number; ['y']: number };
  rightElbowY: { ['x']: number; ['y']: number };
  leftWristX: { ['x']: number; ['y']: number };
  leftWristY: { ['x']: number; ['y']: number };
  rightWristX: { ['x']: number; ['y']: number };
  rightWristY: { ['x']: number; ['y']: number };
  leftHipX: { ['x']: number; ['y']: number };
  leftHipY: { ['x']: number; ['y']: number };
  rightHipX: { ['x']: number; ['y']: number };
  rightHipY: { ['x']: number; ['y']: number };
  leftKneeX: { ['x']: number; ['y']: number };
  leftKneeY: { ['x']: number; ['y']: number };
  rightKneeX: { ['x']: number; ['y']: number };
  rightKneeY: { ['x']: number; ['y']: number };
  leftAnkleX: { ['x']: number; ['y']: number };
  leftAnkleY: { ['x']: number; ['y']: number };
  rightAnkleX: { ['x']: number; ['y']: number };
  rightAnkleY: { ['x']: number; ['y']: number };
  leftPinkyX: { ['x']: number; ['y']: number };
  leftPinkyY: { ['x']: number; ['y']: number };
  rightPinkyX: { ['x']: number; ['y']: number };
  rightPinkyY: { ['x']: number; ['y']: number };
  leftIndexX: { ['x']: number; ['y']: number };
  leftIndexY: { ['x']: number; ['y']: number };
  rightIndexX: { ['x']: number; ['y']: number };
  rightIndexY: { ['x']: number; ['y']: number };
  leftThumbX: { ['x']: number; ['y']: number };
  leftThumbY: { ['x']: number; ['y']: number };
  rightThumbX: { ['x']: number; ['y']: number };
  rightThumbY: { ['x']: number; ['y']: number };
  leftHeelX: { ['x']: number; ['y']: number };
  leftHeelY: { ['x']: number; ['y']: number };
  rightHeelX: { ['x']: number; ['y']: number };
  rightHeelY: { ['x']: number; ['y']: number };
  leftFootIndexX: { ['x']: number; ['y']: number };
  leftFootIndexY: { ['x']: number; ['y']: number };
  rightFootIndexX: { ['x']: number; ['y']: number };
  rightFootIndexY: { ['x']: number; ['y']: number };
  noseX: { ['x']: number; ['y']: number };
  noseY: { ['x']: number; ['y']: number };
  leftEyeInnerX: { ['x']: number; ['y']: number };
  leftEyeInnerY: { ['x']: number; ['y']: number };
  leftEyeX: { ['x']: number; ['y']: number };
  leftEyeY: { ['x']: number; ['y']: number };
  leftEyeOuterX: { ['x']: number; ['y']: number };
  leftEyeOuterY: { ['x']: number; ['y']: number };
  rightEyeInnerX: { ['x']: number; ['y']: number };
  rightEyeInnerY: { ['x']: number; ['y']: number };
  rightEyeX: { ['x']: number; ['y']: number };
  rightEyeY: { ['x']: number; ['y']: number };
  leftMouthX: { ['x']: number; ['y']: number };
  leftMouthY: { ['x']: number; ['y']: number };
  rightMouthX: { ['x']: number; ['y']: number };
  rightMouthY: { ['x']: number; ['y']: number };
};

export interface PoseDetectionOptions {
  // @default stream
  mode?: 'stream' | 'single';
  // @default min
  performanceMode?: 'min' | 'max';
}

export type CameraTypes = {
  callback: Function;
  options: PoseDetectionOptions;
} & CameraProps;
