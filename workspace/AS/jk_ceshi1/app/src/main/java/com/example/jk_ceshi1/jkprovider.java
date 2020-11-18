package com.example.jk_ceshi1;

import android.content.ContentProvider;
import android.content.ContentValues;
import android.content.UriMatcher;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.net.Uri;

public class jkprovider extends ContentProvider {

	//�����ṩ��Ҫʵ����ɾ�Ĳ�ķ���
	
	//URI���������·��
	//����һ��uriƥ������-1��ʾ��ƥ�䲻�ɹ����򷵻�-1
	public static UriMatcher urimatcher = new UriMatcher(-1);
	
	static {
		//���URIƥ�����
		urimatcher.addURI("com.example.jk_ceshi1.fruit", "query", 1);
		urimatcher.addURI("com.example.jk_ceshi1.fruit", "delete", 2);
		urimatcher.addURI("com.example.jk_ceshi1.fruit", "insert", 3);
		urimatcher.addURI("com.example.jk_ceshi1.fruit", "update", 4);
	}
	
	
	@Override
	public int delete(Uri uri, String whereClause, String[] whereArgs) {
		
		int result = urimatcher.match(uri);
		if (result == 2) {
			fruitDBOpenHelper helper = new fruitDBOpenHelper(getContext());
			SQLiteDatabase db = helper.getReadableDatabase();
			db.delete("fruit", whereClause, whereArgs);
		} else {
			throw new RuntimeException("uri·�����󣬲��ܲ�������");
		}
		return 0;
	}

	@Override
	public String getType(Uri uri) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Uri insert(Uri uri, ContentValues values) {
		int result = urimatcher.match(uri);
		if (result == 3) {
			fruitDBOpenHelper helper = new fruitDBOpenHelper(getContext());
			SQLiteDatabase db = helper.getReadableDatabase();
			
			db.insert("fruit", null, values);
			
		} else {
			throw new RuntimeException("uri·�����󣬲��ܲ�������");
		}
		return null;
	}

	@Override
	public boolean onCreate() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Cursor query(Uri uri, String[] columns, String selection, String[] arg3,
			String arg4) {
		
		int result = urimatcher.match(uri);
		if (result==1) {
			fruitDBOpenHelper helper = new fruitDBOpenHelper(getContext());
			SQLiteDatabase db = helper.getReadableDatabase();
			
			return db.query("fruit", columns, selection, null, null, null, null);
			
		} else {
			throw new RuntimeException("uri·�����󣬲��ܲ�������");
		}
		
	}

	@Override
	public int update(Uri uri, ContentValues values, String whereClause,
			String[] whereArgs) {

		int result = urimatcher.match(uri);
		if (result == 4) {
			fruitDBOpenHelper helper = new fruitDBOpenHelper(getContext());
			SQLiteDatabase db = helper.getReadableDatabase();
			db.update("fruit", values, whereClause, whereArgs);
		} else {
			throw new RuntimeException("uri·�����󣬲��ܲ�������");
		}
		return 0;
	}

}
