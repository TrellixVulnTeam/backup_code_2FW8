package com.example.schooltest;

import android.content.ContentValues;
import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class FruitDB extends SQLiteOpenHelper {

    public static final String DB_Name = "fruit.db";
    public static final String TABLE_FRUIT = "fruits";

    private static final String CREATE_TABLE_SQL = "create table " + TABLE_FRUIT + "("
            + "id integer primary key autoincrement,"
            + "name varchar(256) not null,"
            + "price integer not null,"
            + "num integer not null"
            + ");";

    public FruitDB(Context context) {
        super(context, DB_Name, null, 1);

    }

    private void insertDatas(SQLiteDatabase db) {
        insertFruitValues(db,"apple", 120, 5);
        insertFruitValues(db,"banana", 65, 2);
        insertFruitValues(db,"pear", 200, 12);
        insertFruitValues(db,"tomato", 12, 1);
    }

    private void insertFruitValues(SQLiteDatabase db, String name, int num, int price) {
        ContentValues contentValues = new ContentValues();
        contentValues.put("name", name);
        contentValues.put("num", num);
        contentValues.put("price", price);
        db.insert(FruitDB.TABLE_FRUIT, null, contentValues);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        db.execSQL(CREATE_TABLE_SQL);
        insertDatas(db);
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {

    }
}
