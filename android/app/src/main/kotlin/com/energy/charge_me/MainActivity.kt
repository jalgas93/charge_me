package com.energy.charge_me
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity(){
    override fun configureFlutterEngine(@NonNull flutterEngine:FlutterEngine){
        MapKitFactory.setApiKey("b84b403d-0bd1-44f3-80e9-1cbee6f3708d")
        super.configureFlutterEngine(flutterEngine)
    }
}

