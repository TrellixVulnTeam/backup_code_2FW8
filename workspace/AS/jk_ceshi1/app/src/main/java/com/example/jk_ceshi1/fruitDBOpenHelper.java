package com.example.jk_ceshi1;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class fruitDBOpenHelper extends SQLiteOpenHelper {

	// 由于父类没有无参构造函数, 所以子类必须指定调用父类哪个有参的构造函数
	public fruitDBOpenHelper(Context context) {
		super(context, "fruit.db", null, 1);
	}

	@Override
	public void onCreate(SQLiteDatabase db) {
		System.out.println("oncreate方法被调用，数据库被第一次创建了");
		db.execSQL("create table fruit (_id integer primary key autoincrement,name varchaar(20),price float,num int)");
		
	}

	@Override
	public void onUpgrade(SQLiteDatabase arg0, int arg1, int arg2) {
		System.out.println("onupgrade方法被调用，数据库被升级了");
	}
	
}
