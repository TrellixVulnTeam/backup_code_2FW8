from datetime import datetime
from shop import db,login_manager
from flask_login import UserMixin

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))


class User(db.Model,UserMixin):
    __tablename__="User"
    username = db.Column(db.String(20), unique=False, nullable=False,default="private")
    #password = db.Column(db.String(120), unique=False, nullable=False, default="私密")
    email = db.Column(db.String(120), unique=False, nullable=False)

    id = db.Column(db.Integer, primary_key=True)
    table_name = db.Column(db.String(20), unique=False, nullable=False)
    table_id = db.Column(db.Integer,nullable=False)

class Customer(db.Model,UserMixin):
    __tablename__ = "Customer"
    id = db.Column(db.Integer,primary_key=True)
    username = db.Column(db.String(20),unique=True,nullable=False)
    email = db.Column(db.String(120),unique=True,nullable=False)
    password = db.Column(db.String(60),nullable=False)

    detail = db.relationship("CustomerDetail",backref="customer",lazy=True)
    orders = db.relationship("Order",backref="customer",lazy=True)

    def __repr__(self):
        return f"Customer_User('{self.username}','{self.email}','{self.id}')"

class CustomerDetail(db.Model):
    __tablename__ = "CustomerDetail"
    id = db.Column(db.Integer,primary_key=True)
    consignee = db.Column(db.String(20),nullable=False)
    address = db.Column(db.String(40),nullable=False)
    telephone = db.Column(db.String(20),nullable=False)
    customer_id = db.Column(db.Integer,db.ForeignKey("Customer.id"),nullable=False)
    is_default = db.Column(db.Integer,nullable=False,default=0)

    def __repr__(self):
        return f"Customer_Detail('{self.consignee}','{self.telephone}','id:{self.id}',customer_id:{self.customer_id})"

class Product(db.Model):
    __tablename__="Product"
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(40),nullable=False,default="none")
    sort = db.Column(db.String(40),nullable=False,default="none")
    price = db.Column(db.Float,nullable=False,default="none")
    detail = db.Column(db.Text,nullable=False,default="none")
    order_detail = db.relationship("OrderDetail",backref="product",uselist=False,lazy=True)
    product_count = db.Column("product_count", db.Integer, nullable=False, default=0)
    image = db.Column("image", db.String(255), nullable=True)

    def __repr__(self):
        return f"Product('{self.name}',{self.sort},{self.price})"

class OrderDetail(db.Model):
    __tablename__="OrderDetail"

    id = db.Column(db.Integer,primary_key=True)

    product_count = db.Column(db.Integer, nullable=False)

    order_id = db.Column(db.Integer,db.ForeignKey("Order.id"),nullable=False)
    product_id = db.Column(db.Integer, db.ForeignKey("Product.id"),nullable=False)



class Order(db.Model):
    __tablename__ = "Order"

    id = db.Column(db.Integer, primary_key=True)
    status = db.Column(db.Integer, nullable=False, default=0)
    start_time = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    end_time = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    total_price =db.Column(db.Float,nullable=False, default=0.00)
    #address
    customer_id = db.Column("customer_id", db.Integer,db.ForeignKey("Customer.id"),nullable=False)

    orderdetails = db.relationship("OrderDetail",backref="order",lazy=True)


class OrderAddress(db.Model):
    __tablename__ = "OrderAddress"
    id = db.Column(db.Integer,primary_key=True)
    consignee = db.Column(db.String(20),nullable=False)
    address = db.Column(db.String(40),nullable=False)
    telephone = db.Column(db.String(20),nullable=False)
    order_id = db.Column(db.Integer,db.ForeignKey("Order.id"),nullable=False)
