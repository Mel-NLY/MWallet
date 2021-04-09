package com.example.MWallet
import io.flutter.embedding.android.SplashScreen
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {

    override fun provideSplashScreen(): SplashScreen? = SplashView()
}
