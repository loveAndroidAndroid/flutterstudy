package com.module.myapplication;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.util.Log;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);


        ((ViewGroup) getWindow().getDecorView()).getChildAt(0).setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                switch (event.getAction()) {
                    /**
                     * 点击的开始位置
                     */
                    case MotionEvent.ACTION_DOWN:
                        Log.e("MainActivity", event.getX() + "+" + event.getY());
                        break;
                    /**
                     * 触屏实时位置
                     */
                    case MotionEvent.ACTION_MOVE:
                        Log.e("MainActivity", event.getX() + "+" + event.getY());
                        break;
                    /**
                     * 离开屏幕的位置
                     */
                    case MotionEvent.ACTION_UP:
                        Log.e("MainActivity", event.getX() + "+" + event.getY());
                        break;
                    default:
                        break;
                }
                /**
                 *  注意返回值
                 *  true：view继续响应Touch操作；
                 *  false：view不再响应Touch操作，故此处若为false，只能显示起始位置，不能显示实时位置和结束位置
                 */
                return true;
            }
        });
//        getWindow().getDecorView().findViewById(android.R.id.content).setOnTouchListener(new View.OnTouchListener() {
//            @Override
//            public boolean onTouch(View v, MotionEvent event) {
//                switch (event.getAction()) {
//                    /**
//                     * 点击的开始位置
//                     */
//                    case MotionEvent.ACTION_DOWN:
//                        Log.e("MainActivity", event.getX() + "+" + event.getY());
//                        break;
//                    /**
//                     * 触屏实时位置
//                     */
//                    case MotionEvent.ACTION_MOVE:
//                        Log.e("MainActivity", event.getX() + "+" + event.getY());
//                        break;
//                    /**
//                     * 离开屏幕的位置
//                     */
//                    case MotionEvent.ACTION_UP:
//                        Log.e("MainActivity", event.getX() + "+" + event.getY());
//                        break;
//                    default:
//                        break;
//                }
//                /**
//                 *  注意返回值
//                 *  true：view继续响应Touch操作；
//                 *  false：view不再响应Touch操作，故此处若为false，只能显示起始位置，不能显示实时位置和结束位置
//                 */
//                return true;
//            }
//        });
    }
}