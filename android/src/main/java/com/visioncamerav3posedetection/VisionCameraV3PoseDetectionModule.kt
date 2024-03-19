package com.visioncamerav3posedetection

import android.media.Image
import com.facebook.react.bridge.WritableNativeMap
import com.google.android.gms.tasks.Task
import com.google.android.gms.tasks.Tasks
import com.google.mlkit.vision.common.InputImage
import com.google.mlkit.vision.pose.Pose
import com.google.mlkit.vision.pose.PoseDetection
import com.google.mlkit.vision.pose.PoseLandmark
import com.google.mlkit.vision.pose.defaults.PoseDetectorOptions
import com.mrousavy.camera.frameprocessor.Frame
import com.mrousavy.camera.frameprocessor.FrameProcessorPlugin
import com.mrousavy.camera.frameprocessor.VisionCameraProxy
import java.util.HashMap

class VisionCameraV3PoseDetectionModule(proxy : VisionCameraProxy, options: Map<String, Any>?): FrameProcessorPlugin() {

  override fun callback(frame: Frame, arguments: Map<String, Any>?): HashMap<String, Any> {
    val options = PoseDetectorOptions.Builder()
    if (arguments?.get("mode") === "stream") options.setDetectorMode(PoseDetectorOptions.STREAM_MODE)
    else if (arguments?.get("mode") === "single") options.setDetectorMode(PoseDetectorOptions.SINGLE_IMAGE_MODE)
    if (arguments?.get("performanceMode") === "min") options.setPreferredHardwareConfigs(PoseDetectorOptions.CPU)
    else if (arguments?.get("performanceMode") === "max") options.setPreferredHardwareConfigs(PoseDetectorOptions.CPU_GPU)

    try {
      val poseDetector = PoseDetection.getClient(options.build())
      val mediaImage: Image = frame.image
      val image = InputImage.fromMediaImage(mediaImage, 0)
      val task: Task<Pose> = poseDetector.process(image)
      val pose: Pose = Tasks.await(task)
      val map = WritableNativeMap()
      fun addLandmarkToMap(landmark: PoseLandmark?, landmarkName: String) {
        val landmarkMap = WritableNativeMap()
        landmarkMap.putDouble("x", landmark?.position?.x?.toDouble() ?: 0.0)
        landmarkMap.putDouble("y", landmark?.position?.y?.toDouble() ?: 0.0)

        map.putMap(landmarkName, landmarkMap)
      }
      if (pose.allPoseLandmarks.isNotEmpty()){
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.LEFT_SHOULDER), "leftShoulderPosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.RIGHT_SHOULDER), "rightShoulderPosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.LEFT_ELBOW), "leftElbowPosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.RIGHT_ELBOW), "rightElbowPosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.LEFT_WRIST), "leftWristPosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.RIGHT_WRIST), "rightWristPosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.LEFT_HIP), "leftHipPosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.RIGHT_HIP), "rightHipPosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.LEFT_KNEE), "leftKneePosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.RIGHT_KNEE), "rightKneePosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.LEFT_ANKLE), "leftAnklePosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.RIGHT_ANKLE), "rightAnklePosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.LEFT_PINKY), "leftPinkyPosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.RIGHT_PINKY), "rightPinkyPosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.LEFT_INDEX), "leftIndexPosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.RIGHT_INDEX), "rightIndexPosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.LEFT_THUMB), "leftThumbPosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.RIGHT_THUMB), "rightThumbPosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.LEFT_HEEL), "leftHeelPosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.RIGHT_HEEL), "rightHeelPosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.LEFT_FOOT_INDEX), "leftFootIndexPosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.RIGHT_FOOT_INDEX), "rightFootIndexPosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.NOSE), "nosePosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.LEFT_EYE_INNER), "leftEyeInnerPosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.LEFT_EYE), "leftEyePosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.LEFT_EYE_OUTER), "leftEyeOuterPosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.RIGHT_EYE_INNER), "rightEyeInnerPosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.RIGHT_EYE), "rightEyePosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.RIGHT_EYE_OUTER), "rightEyeOuterPosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.LEFT_EAR), "leftEarPosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.RIGHT_EAR), "rightEarPosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.LEFT_MOUTH), "leftMouthPosition")
      addLandmarkToMap(pose.getPoseLandmark(PoseLandmark.RIGHT_MOUTH), "rightMouthPosition")
}
      return map.toHashMap()
    } catch (e: Exception) {
      throw Exception("Error processing pose detection: $e")
    }
  }
}


