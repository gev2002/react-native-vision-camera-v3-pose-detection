import { Platform } from 'react-native';
import type {
  Frame,
  FrameProcessorPlugin,
  PoseDetectionOptions,
} from './types';
import { VisionCameraProxy } from 'react-native-vision-camera';

const LINKING_ERROR: string =
  `The package 'react-native-vision-camera-v3-pose-detection' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const plugin: FrameProcessorPlugin | undefined =
  VisionCameraProxy.initFrameProcessorPlugin('detectPose');

export function detectPose(frame: Frame, options: PoseDetectionOptions): any {
  'worklet';
  if (plugin == null) throw new Error(LINKING_ERROR);
  // @ts-ignore
  return options ? plugin.call(frame, options) : plugin.call(frame);
}
