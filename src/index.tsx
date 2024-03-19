import React from 'react';
import { Platform } from 'react-native';
import { useRunInJS } from 'react-native-worklets-core';
import {
  VisionCameraProxy,
  Camera as VisionCamera,
  useFrameProcessor,
} from 'react-native-vision-camera';
import type {
  CameraTypes,
  Frame,
  PoseType,
  FrameProcessor,
  FrameProcessorPlugin,
  PoseDetectionOptions,
} from './types';

const LINKING_ERROR: string =
  `The package 'react-native-vision-camera-v3-pose-detection' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const plugin: FrameProcessorPlugin | undefined =
  VisionCameraProxy.initFrameProcessorPlugin('detectPose');

function detectPose(frame: Frame, options: PoseDetectionOptions): any {
  'worklet';
  if (plugin == null) throw new Error(LINKING_ERROR);
  // @ts-ignore
  return options ? plugin.call(frame, options) : plugin.call(frame);
}

export const Camera = (props: CameraTypes) => {
  const { callback, device, options } = props;
  // @ts-ignore
  const useWorklets = useRunInJS((data: PoseType): void => {
    callback(data);
  }, []);
  const frameProcessor: FrameProcessor = useFrameProcessor(
    (frame: Frame): void => {
      'worklet';
      const data: PoseType = detectPose(frame, options);
      // @ts-ignore
      // eslint-disable-next-line react-hooks/rules-of-hooks
      useWorklets(data);
    },
    []
  );
  return (
    !!device && <VisionCamera frameProcessor={frameProcessor} {...props} />
  );
};
