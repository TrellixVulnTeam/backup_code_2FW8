package com.example.jk_ceshi1;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class fruitDBOpenHelper extends SQLiteOpenHelper {

	// ���ڸ���û���޲ι��캯��, �����������ָ�����ø����ĸ��вεĹ��캯��
	public fruitDBOpenHelper(Context context) {
		super(context, "fruit.db", null, 1);
	}

	@Override
	public void onCreate(SQLiteDatabase db) {
		System.out.println("oncreate���������ã����ݿⱻ��һ�δ�����");
		db.execSQL("create table fruit (_id integer primary key autoincrement,name varchaar(20),price float,num int)");
		
	}

	@Override
	public void onUpgrade(SQLiteDatabase arg0, int arg1, int arg2) {
		System.out.println("onupgrade���������ã����ݿⱻ������");
	}
	
}
