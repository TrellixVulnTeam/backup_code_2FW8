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
		//创建Dao时，创建Helper
		helper = new fruitDBOpenHelper(context);
	}
	
	public void insert(fruit fruit){
		
		//获取数据库对象
		SQLiteDatabase db = helper.getWritableDatabase();
		
		//用来装载要插入的数据的Map<列名，列的值>
		ContentValues values = new ContentValues();
		values.put("name", fruit.getName());
		values.put("price",fruit.getPrice());
		values.put("num",fruit.getNum());
		
		//向account表插入数据values,
		long id = db.insert("fruit", null, values);
		fruit.setId(id); //得到id
		db.close(); //关闭数据库
	}
	//根据id删除数据
	public int delete(long id){
		SQLiteDatabase db = helper.getWritableDatabase();
		
		//按条件删除指定表中的数据，返回受影响的行数
		int count = db.delete("fruit", "_id=?", new String[]{id+""});
		db.close();
		return count;
	}
	
	//更新数据
	public int update(fruit fruit){
		SQLiteDatabase db = helper.getWritableDatabase();
		ContentValues values = new ContentValues();//要修改的数据
		values.put("name", fruit.getName());
		values.put("price",fruit.getPrice());
		values.put("num",fruit.getNum());
		int count = db.update("fruit", values, "_id=?", new String[]{fruit.getId()+""});
		db.close();
		return count;
	}
	//查询所有数据倒序排列
	public List<fruit> queryAll(){
		SQLiteDatabase db = helper.getReadableDatabase();
		Cursor c = db.query("fruit", null, null, null, null, null, "price DESC");
		List<fruit> list = new ArrayList<fruit>();
		while(c.moveToNext()){
			
			//可以根据列名获取索引
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