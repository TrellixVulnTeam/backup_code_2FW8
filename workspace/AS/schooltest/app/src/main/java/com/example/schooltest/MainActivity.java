package com.example.schooltest;

import android.content.ContentValues;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.CursorAdapter;
import android.widget.ListView;
import android.widget.SimpleAdapter;
import android.widget.SimpleCursorAdapter;

import java.util.ArrayList;
import java.util.HashMap;

public class MainActivity extends AppCompatActivity {
    public FruitDB fruitDBHelper;
    public SQLiteDatabase db;
    ArrayList<HashMap<String, Object>> listData;
    SimpleAdapter listItemAdapter;
    private ListView listView;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        listView = (ListView) this.findViewById(R.id.list_item);

        fruitDBHelper = new FruitDB(getApplicationContext());
        db = fruitDBHelper.getReadableDatabase();
        getAllData();
        listItemAdapter = new SimpleAdapter(MainActivity.this,
                listData, R.layout.item,
                new String[] {"name", "price", "num"},
                new int[] {R.id.name, R.id.price, R.id.num});
        listView.setAdapter(listItemAdapter);
    }

    public void getAllData() {
        Cursor c = db.rawQuery("select name, price, num from fruits", null);
        int columnsSize = c.getColumnCount();
        listData = new ArrayList<HashMap<String, Object>>();
        // 获取表的内容
        while (c.moveToNext()) {
            HashMap<String, Object> map = new HashMap<String, Object>();
            for (int i = 0; i < columnsSize; i++) {
                map.put("name", c.getString(0));
                map.put("price", c.getInt(1));
                map.put("num", c.getInt(2));
            }
            listData.add(map);
        }
    }

}
