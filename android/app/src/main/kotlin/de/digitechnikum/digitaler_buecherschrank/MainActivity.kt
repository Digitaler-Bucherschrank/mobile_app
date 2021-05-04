package de.digitechnikum.digitaler_buecherschrank

import android.os.Build
import android.view.Surface
import android.view.SurfaceHolder
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterSurfaceView




class MainActivity: FlutterActivity() {
    private var surfaceHolder: SurfaceHolder? = null;

    override fun onFlutterSurfaceViewCreated(@NonNull flutterSurfaceView: FlutterSurfaceView) {
        super.onFlutterSurfaceViewCreated(flutterSurfaceView)
        surfaceHolder = flutterSurfaceView.holder
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            this.surfaceHolder?.addCallback(object : SurfaceHolder.Callback {
                override fun surfaceCreated(@NonNull holder: SurfaceHolder) {
                    holder.surface.setFrameRate(90f, Surface.FRAME_RATE_COMPATIBILITY_FIXED_SOURCE)
                }

                override fun surfaceChanged(@NonNull holder: SurfaceHolder, format: Int, width: Int, height: Int) {
                    holder.surface.setFrameRate(90f, Surface.FRAME_RATE_COMPATIBILITY_FIXED_SOURCE)
                }

                override fun surfaceDestroyed(holder: SurfaceHolder) {}
            })
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        surfaceHolder = null
    }
}
