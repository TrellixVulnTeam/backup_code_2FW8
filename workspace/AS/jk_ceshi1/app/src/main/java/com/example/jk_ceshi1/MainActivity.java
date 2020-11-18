package com.example.jk_ceshi1;

import java.util.List;

import com.example.fruit.fruit;
import com.example.fruit.fruitDao;
import android.app.Activity;
import android.app.AlertDialog.Builder;
import android.content.DialogInterface;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.View.OnClickListener;
import android.widget.AdapterView;
import android.widget.BaseAdapter;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.AdapterView.OnItemClickListener;


public class MainActivity extends Activity {

	//需要适配的数据集合
	private List<fruit> list;
	//数据库增删查改操作类
	private fruitDao dao;
	//输入姓名的EditText
	private EditText nameET;
	//输入金额的EditText
	private EditText priceET;
	private EditText numET;
	//适配器
	private MyAdapter adapter;
	//ListView 
	private ListView accountLV;
	
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        
      //初始化控件
      initView();
      dao = new fruitDao(this);
      
      //从数据库中查询出所有数据
      list = dao.queryAll();
      adapter = new MyAdapter();
      accountLV.setAdapter(adapter);//给ListView添加适配器（自动把数据生成条目）
    }
    
    //初始化控件
  	private void initView(){
  		accountLV = (ListView) findViewById(R.id.accountLV);
  		nameET = (EditText) findViewById(R.id.nameET);
  		priceET = (EditText) findViewById(R.id.priceET);
  		numET = (EditText) findViewById(R.id.numET);
  		
  		//添加监听器，监听条目点击事件
  		accountLV.setOnItemClickListener(new MyOnItemClickListener());
  	}
  	
  	//activity_main.xml对应ImageView的点击事件触发的方法
  	public void add(View v){
  		String name = nameET.getText().toString().trim();
  		String price = priceET.getText().toString().trim();
  		String num = numET.getText().toString().trim();
  		
  		//三目运算balance.equals("")则等于0
  		//如果balance不是空字符串，则进行类型转换
  		fruit a = new fruit(name,price.equals("") ? 0:Float.parseFloat(price),num.equals("")?0:Integer.parseInt(num));
  		if (TextUtils.isEmpty(name) || TextUtils.isEmpty(price) || TextUtils.isEmpty(num)) {
  			Toast.makeText(this, "商品名称、数量或者价格不能为空", 1).show();
  			return;
  		} else {
  			
  		}
  		dao.insert(a); //插入数据库
  		list.add(a); //插入集合
  		adapter.notifyDataSetChanged();//刷新界面
  		
  		//选中最后一个
  		accountLV.setSelection(accountLV.getCount()-1);
  		nameET.setText("");
  		priceET.setText("");
  		numET.setText("");
  	}
  	
  	//自定义一个适配器（把数据装到ListView的工具）
  	public class MyAdapter extends BaseAdapter{

  		@Override
  		public int getCount() { //获得条目总数
  			return list.size();
  		}

  		@Override
  		public Object getItem(int position) { //根据位置获取对象
  			return list.get(position);
  		}

  		@Override
  		public long getItemId(int position) { //根据位置获取id
  			return position;
  		}
  		
  		//获取一个条目视图
  		@Override
  		public View getView(int position, View convertView, ViewGroup parent) {
  			
  			//重用convertView
  			View item = convertView != null ? convertView : View.inflate(getApplicationContext(), R.layout.item, null);
  			
  			//获取该视图中的TextView
  			TextView idTV= (TextView) item.findViewById(R.id.idTV);
  			TextView nameTV = (TextView) item.findViewById(R.id.nameTV);
  			TextView priceTV = (TextView) item.findViewById(R.id.priceTV);
  			TextView numTV = (TextView) item.findViewById(R.id.numTV);
  			
  			//根据当前位置获取Account对象
  			final fruit a =list.get(position);
  			
  			//把Account对象中的数据放到TextView中
  			idTV.setText(a.getId()+"");
  			nameTV.setText(a.getName());
  			priceTV.setText(a.getPrice()+"");
  			numTV.setText(a.getNum()+"");
  			ImageView up1IV =  (ImageView) item.findViewById(R.id.up1IV);
  			ImageView down1IV =  (ImageView) item.findViewById(R.id.down1IV);
  			ImageView up2IV =  (ImageView) item.findViewById(R.id.up2IV);
  			ImageView down2IV =  (ImageView) item.findViewById(R.id.down2IV);
  			ImageView deleteIV =  (ImageView) item.findViewById(R.id.deleteIV);
  			
  			//向上箭头的点击事件触发的方法
  			up1IV.setOnClickListener(new OnClickListener() {
  				public void onClick(View v) {
  					a.setPrice(a.getPrice()+1);     //修改值
  					notifyDataSetChanged();		   //刷新界面
  					dao.update(a);				   //更新数据库
  				}
  			});
  			
  			  			
  			//向下箭头的点击事件触发的方法
  			down1IV.setOnClickListener(new OnClickListener() {
  				public void onClick(View arg0) {
  					a.setPrice(a.getPrice()-1);     //修改值
  					notifyDataSetChanged();		   //刷新界面
  					dao.update(a);				   //更新数据库
  				}
  			});
  			
  		    //向上箭头的点击事件触发的方法
  			up2IV.setOnClickListener(new OnClickListener() {		
  				public void onClick(View v) {
  					a.setNum(a.getNum()+1);        //修改值
  					notifyDataSetChanged();		   //刷新界面
  					dao.update(a);				   //更新数据库
  				}
  			});
  			
  			//向下箭头的点击事件触发的方法
  			down2IV.setOnClickListener(new OnClickListener() {
  				public void onClick(View arg0) {
  					a.setNum(a.getNum()-1);         //修改值
  					notifyDataSetChanged();		   //刷新界面
  					dao.update(a);				   //更新数据库
  				}
  			});
  			
  			//删除图片的点击事件触发的方法
  			deleteIV.setOnClickListener(new OnClickListener() {
  				public void onClick(View v) {
  			
  					//删除数据之前首先弹出一个对话框
  					android.content.DialogInterface.OnClickListener listener = new android.content.DialogInterface.OnClickListener() {
  					
  						public void onClick(DialogInterface dialog, int which) {
  							list.remove(a); //从集合中删除
  							dao.delete(a.getId()); //从数据库中删除
  							notifyDataSetChanged(); //刷新界面
  						}
  					};
  				
  					//创建对话框
  					Builder builder = new Builder(MainActivity.this);
  					builder.setTitle("是否确定要删除？");//设置标题
  					
  					//设置确定按钮的文本以及监听器
  					builder.setPositiveButton("确定", listener);
  					builder.setNegativeButton("取消", null);//设置取消按钮
  					builder.show();//显示对话框
  				}
  			});
  			return item;
  		}	
  	}
  	
  	//ListView的item点击事件
  	private class MyOnItemClickListener implements OnItemClickListener{

  		@Override
  		public void onItemClick(AdapterView<?> parent, View view, int position,
  				long id) {
  			
  			// 获取点击位置上的数据
  			fruit a = (fruit) parent.getItemAtPosition(position);
  			Toast.makeText(getApplicationContext(), a.toString(), Toast.LENGTH_SHORT).show();
  		}
  	}
}
