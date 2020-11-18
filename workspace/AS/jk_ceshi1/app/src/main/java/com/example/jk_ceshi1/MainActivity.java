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

	//��Ҫ��������ݼ���
	private List<fruit> list;
	//���ݿ���ɾ��Ĳ�����
	private fruitDao dao;
	//����������EditText
	private EditText nameET;
	//�������EditText
	private EditText priceET;
	private EditText numET;
	//������
	private MyAdapter adapter;
	//ListView 
	private ListView accountLV;
	
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        
      //��ʼ���ؼ�
      initView();
      dao = new fruitDao(this);
      
      //�����ݿ��в�ѯ����������
      list = dao.queryAll();
      adapter = new MyAdapter();
      accountLV.setAdapter(adapter);//��ListView������������Զ�������������Ŀ��
    }
    
    //��ʼ���ؼ�
  	private void initView(){
  		accountLV = (ListView) findViewById(R.id.accountLV);
  		nameET = (EditText) findViewById(R.id.nameET);
  		priceET = (EditText) findViewById(R.id.priceET);
  		numET = (EditText) findViewById(R.id.numET);
  		
  		//��Ӽ�������������Ŀ����¼�
  		accountLV.setOnItemClickListener(new MyOnItemClickListener());
  	}
  	
  	//activity_main.xml��ӦImageView�ĵ���¼������ķ���
  	public void add(View v){
  		String name = nameET.getText().toString().trim();
  		String price = priceET.getText().toString().trim();
  		String num = numET.getText().toString().trim();
  		
  		//��Ŀ����balance.equals("")�����0
  		//���balance���ǿ��ַ��������������ת��
  		fruit a = new fruit(name,price.equals("") ? 0:Float.parseFloat(price),num.equals("")?0:Integer.parseInt(num));
  		if (TextUtils.isEmpty(name) || TextUtils.isEmpty(price) || TextUtils.isEmpty(num)) {
  			Toast.makeText(this, "��Ʒ���ơ��������߼۸���Ϊ��", 1).show();
  			return;
  		} else {
  			
  		}
  		dao.insert(a); //�������ݿ�
  		list.add(a); //���뼯��
  		adapter.notifyDataSetChanged();//ˢ�½���
  		
  		//ѡ�����һ��
  		accountLV.setSelection(accountLV.getCount()-1);
  		nameET.setText("");
  		priceET.setText("");
  		numET.setText("");
  	}
  	
  	//�Զ���һ����������������װ��ListView�Ĺ��ߣ�
  	public class MyAdapter extends BaseAdapter{

  		@Override
  		public int getCount() { //�����Ŀ����
  			return list.size();
  		}

  		@Override
  		public Object getItem(int position) { //����λ�û�ȡ����
  			return list.get(position);
  		}

  		@Override
  		public long getItemId(int position) { //����λ�û�ȡid
  			return position;
  		}
  		
  		//��ȡһ����Ŀ��ͼ
  		@Override
  		public View getView(int position, View convertView, ViewGroup parent) {
  			
  			//����convertView
  			View item = convertView != null ? convertView : View.inflate(getApplicationContext(), R.layout.item, null);
  			
  			//��ȡ����ͼ�е�TextView
  			TextView idTV= (TextView) item.findViewById(R.id.idTV);
  			TextView nameTV = (TextView) item.findViewById(R.id.nameTV);
  			TextView priceTV = (TextView) item.findViewById(R.id.priceTV);
  			TextView numTV = (TextView) item.findViewById(R.id.numTV);
  			
  			//���ݵ�ǰλ�û�ȡAccount����
  			final fruit a =list.get(position);
  			
  			//��Account�����е����ݷŵ�TextView��
  			idTV.setText(a.getId()+"");
  			nameTV.setText(a.getName());
  			priceTV.setText(a.getPrice()+"");
  			numTV.setText(a.getNum()+"");
  			ImageView up1IV =  (ImageView) item.findViewById(R.id.up1IV);
  			ImageView down1IV =  (ImageView) item.findViewById(R.id.down1IV);
  			ImageView up2IV =  (ImageView) item.findViewById(R.id.up2IV);
  			ImageView down2IV =  (ImageView) item.findViewById(R.id.down2IV);
  			ImageView deleteIV =  (ImageView) item.findViewById(R.id.deleteIV);
  			
  			//���ϼ�ͷ�ĵ���¼������ķ���
  			up1IV.setOnClickListener(new OnClickListener() {
  				public void onClick(View v) {
  					a.setPrice(a.getPrice()+1);     //�޸�ֵ
  					notifyDataSetChanged();		   //ˢ�½���
  					dao.update(a);				   //�������ݿ�
  				}
  			});
  			
  			  			
  			//���¼�ͷ�ĵ���¼������ķ���
  			down1IV.setOnClickListener(new OnClickListener() {
  				public void onClick(View arg0) {
  					a.setPrice(a.getPrice()-1);     //�޸�ֵ
  					notifyDataSetChanged();		   //ˢ�½���
  					dao.update(a);				   //�������ݿ�
  				}
  			});
  			
  		    //���ϼ�ͷ�ĵ���¼������ķ���
  			up2IV.setOnClickListener(new OnClickListener() {		
  				public void onClick(View v) {
  					a.setNum(a.getNum()+1);        //�޸�ֵ
  					notifyDataSetChanged();		   //ˢ�½���
  					dao.update(a);				   //�������ݿ�
  				}
  			});
  			
  			//���¼�ͷ�ĵ���¼������ķ���
  			down2IV.setOnClickListener(new OnClickListener() {
  				public void onClick(View arg0) {
  					a.setNum(a.getNum()-1);         //�޸�ֵ
  					notifyDataSetChanged();		   //ˢ�½���
  					dao.update(a);				   //�������ݿ�
  				}
  			});
  			
  			//ɾ��ͼƬ�ĵ���¼������ķ���
  			deleteIV.setOnClickListener(new OnClickListener() {
  				public void onClick(View v) {
  			
  					//ɾ������֮ǰ���ȵ���һ���Ի���
  					android.content.DialogInterface.OnClickListener listener = new android.content.DialogInterface.OnClickListener() {
  					
  						public void onClick(DialogInterface dialog, int which) {
  							list.remove(a); //�Ӽ�����ɾ��
  							dao.delete(a.getId()); //�����ݿ���ɾ��
  							notifyDataSetChanged(); //ˢ�½���
  						}
  					};
  				
  					//�����Ի���
  					Builder builder = new Builder(MainActivity.this);
  					builder.setTitle("�Ƿ�ȷ��Ҫɾ����");//���ñ���
  					
  					//����ȷ����ť���ı��Լ�������
  					builder.setPositiveButton("ȷ��", listener);
  					builder.setNegativeButton("ȡ��", null);//����ȡ����ť
  					builder.show();//��ʾ�Ի���
  				}
  			});
  			return item;
  		}	
  	}
  	
  	//ListView��item����¼�
  	private class MyOnItemClickListener implements OnItemClickListener{

  		@Override
  		public void onItemClick(AdapterView<?> parent, View view, int position,
  				long id) {
  			
  			// ��ȡ���λ���ϵ�����
  			fruit a = (fruit) parent.getItemAtPosition(position);
  			Toast.makeText(getApplicationContext(), a.toString(), Toast.LENGTH_SHORT).show();
  		}
  	}
}
