package com.example.fruit;

import java.util.ArrayList;
import java.util.List;

import com.example.jk_ceshi1.fruitDBOpenHelper;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

public class fruitDao {

	private fruitDBOpenHelper helper;

	public fruitDao(Context context) {
		//����Daoʱ������Helper
		helper = new fruitDBOpenHelper(context);
	}
	
	public void insert(fruit fruit){
		
		//��ȡ���ݿ����
		SQLiteDatabase db = helper.getWritableDatabase();
		
		//����װ��Ҫ��������ݵ�Map<�������е�ֵ>
		ContentValues values = new ContentValues();
		values.put("name", fruit.getName());
		values.put("price",fruit.getPrice());
		values.put("num",fruit.getNum());
		
		//��account���������values,
		long id = db.insert("fruit", null, values);
		fruit.setId(id); //�õ�id
		db.close(); //�ر����ݿ�
	}
	//����idɾ������
	public int delete(long id){
		SQLiteDatabase db = helper.getWritableDatabase();
		
		//������ɾ��ָ�����е����ݣ�������Ӱ�������
		int count = db.delete("fruit", "_id=?", new String[]{id+""});
		db.close();
		return count;
	}
	
	//��������
	public int update(fruit fruit){
		SQLiteDatabase db = helper.getWritableDatabase();
		ContentValues values = new ContentValues();//Ҫ�޸ĵ�����
		values.put("name", fruit.getName());
		values.put("price",fruit.getPrice());
		values.put("num",fruit.getNum());
		int count = db.update("fruit", values, "_id=?", new String[]{fruit.getId()+""});
		db.close();
		return count;
	}
	//��ѯ�������ݵ�������
	public List<fruit> queryAll(){
		SQLiteDatabase db = helper.getReadableDatabase();
		Cursor c = db.query("fruit", null, null, null, null, null, "price DESC");
		List<fruit> list = new ArrayList<fruit>();
		while(c.moveToNext()){
			
			//���Ը���������ȡ����
			long id = c.getLong(c.getColumnIndex("_id"));
			String name = c.getString(1);
			float price = c.getFloat(2);
			int num = c.getInt(3);
			list.add(new fruit(id,name,price,num));
		}
		c.close();
		db.close();
		return list;
	}
	
}