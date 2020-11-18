package com.example.fruit;

public class fruit {

	private long id;
	private String name;
	private float price;
	private int num;
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	@Override
	public String toString() {
		return "fruit [id=" + id + ", 水果名称=" + name + ", 价格=" + price
				+ ", 数量=" + num + "]";
	}
	public fruit(long id, String name, float price, int num) {
		super();
		this.id = id;
		this.name = name;
		this.price = price;
		this.num = num;
	}
	public fruit( String name, float price, int num) {
		super();
		this.name = name;
		this.price = price;
		this.num = num;
	}
	public fruit() {
		super();
		// TODO Auto-generated constructor stub
	}
	
}
