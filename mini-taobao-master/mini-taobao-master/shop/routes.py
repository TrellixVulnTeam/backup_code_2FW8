from flask import render_template, url_for, request, redirect, flash, abort
from shop import app, db, bcrypt
from shop.models import Customer, User, CustomerDetail, Product, Order, OrderDetail, OrderAddress
from shop.forms import *
from flask_login import current_user, logout_user, login_user, login_required
from datetime import datetime


# 首页
@app.route('/')
@app.route("/home")
def home():
    products = Product.query.all()
    products.reverse()
    print(products)
    return render_template("home.html", products=products)

# 获取单一商品
@app.route('/p/<int:id>')
def product_detail(id):
    product = Product.query.get(id)
    print(product)
    return render_template("product_detail.html", product=product)


@app.route("/login", methods=["GET", 'POST'])
def login():
    if current_user.is_authenticated:
        return redirect(url_for('home'))
    form = LoginForm()
    if form.validate_on_submit():
        table = Customer
        table_name = "Customer"

        user = table.query.filter_by(email=form.email.data).first()
        if user and bcrypt.check_password_hash(user.password, form.password.data):
            table_id = user.id
            user_user = User.query.filter_by(
                table_id=table_id, table_name=table_name).first()  # 用User 表来登录 表示权限 以及角色
            login_user(user_user, remember=form.remember.data)
            next_page = request.args.get("next")
            if next_page:
                flash('Login Success', 'success')
                return redirect(next_page)
            else:
                return redirect(url_for('home'))
        else:
            flash('Login failed, please check your role name, email and password!', 'danger')
    return render_template('login.html', title='Login', form=form)


@app.route("/register", methods=["GET", 'POST'])
def register():
    form = RegistrationForm()
    table_name = ""
    if form.validate_on_submit():
        role = Customer()
        table_name = "Customer"
        table = Customer

        hashed_password = bcrypt.generate_password_hash(
            password=form.password.data).decode("utf-8")
        role.username = form.username.data
        role.email = form.email.data
        role.password = hashed_password
        db.session.add(role)
        db.session.commit()
        table_id = table.query.filter_by(email=form.email.data).first().id
        user = User()
        user.table_name = table_name
        user.table_id = table_id
        user.username = form.username.data
        user.email = form.email.data
        db.session.add(user)
        db.session.commit()

        flash('Your account has been created,now you can login in!', 'success')
        return redirect(url_for('login'))
    return render_template('register.html', title='Register', form=form)


@app.route("/logout")
def logout():
    logout_user()
    return redirect(url_for('home'))


@app.route("/customer/<string:username>/account/")
@login_required
def customer_account(username):
    if current_user.table_name != "Customer":
        abort(403)
    return render_template("customer_account.html", username=username)


@app.route("/customer/shopping_car/")
@login_required
def shopping_car():

    if current_user.table_name != "Customer":
        abort(403)
        # 0代表未被提交订单
    shopping_car = Order.query.filter_by(
        customer_id=current_user.table_id, status=0).first()
    customer_detail_default = CustomerDetail.query.filter_by(
        customer_id=current_user.table_id, is_default=1).first()
    if shopping_car is not None:
        orderdetails = OrderDetail.query.filter_by(
            order_id=shopping_car.id).all()
        price = 0
        for i in orderdetails:
            product = Product.query.filter_by(id=i.product_id).first()
            price = price+i.product_count*product.price
        shopping_car.total_price = price
        db.session.add(shopping_car)
        db.session.commit()
        return render_template("shopping_car.html", orderdetails=orderdetails, shopping_car=shopping_car, customer_detail_default=customer_detail_default)
    else:
        shopping_car = Order(customer_id=current_user.table_id)
        db.session.add(shopping_car)
        db.session.commit()
        orderdetails = None
        return render_template("shopping_car.html", orderdetails=orderdetails, shopping_car=shopping_car, customer_detail_default=customer_detail_default)


# 购物车是尚未提交的订单，先判断是否存在一个未提交的订单，如果有那么购物车已经存在，如果没有就
# 生成一个未被提交的订单来作为购物车，购物车被提交后，则是生成了一个提交后的订单了，购物车被清空
# 那也只是，未被提交的那个订单没有包涵订单细节


@app.route("/customer/add_product/<int:id>/to_shoppingcar/", methods=["POST", "GET"])
@login_required
def add_product_shopping_car(id):
    if current_user.table_name != "Customer":
        abort(403)

    shopping_car = Order.query.filter_by(
        customer_id=current_user.table_id, status=0).first()
    if shopping_car:
        if OrderDetail.query.filter_by(order_id=shopping_car.id, product_id=id).first() is None:
            order_detail = OrderDetail(
                product_count=1, order_id=shopping_car.id, product_id=id)
            db.session.add(order_detail)
            db.session.commit()
            flash("This product has been successfully added to the shopping cart!", "success")
            return redirect(url_for("home"))
        else:
            flash("This product is already in the shopping cart, no need to add it again!", "warning")
            return redirect(url_for("home"))

    else:
        shopping_car = Order(customer_id=current_user.table_id)
        db.session.add(shopping_car)
        db.session.commit()
        if OrderDetail.query.filter_by(order_id=shopping_car.id, product_id=id).first() is None:
            order_detail = OrderDetail(
                product_count=1, order_id=shopping_car.id, product_id=id)
            db.session.add(order_detail)
            db.session.commit()
            flash("This product has been successfully added to the shopping cart!", "success")
            return redirect(url_for("home"))
        else:
            flash("This product is already in the shopping cart, no need to add it again!", "warning")
            return redirect(url_for("home"))


@app.route("/customer/delete_product/<int:id>/from_shoppingcar/", methods=["POST", "GET"])
@login_required
def delete_product_from_shopping_car(id):
    if current_user.table_name != "Customer":
        abort(403)
    shopping_car = Order.query.filter_by(
        customer_id=current_user.table_id, status=0).first()
    orderdetail = OrderDetail.query.filter_by(
        order_id=shopping_car.id, product_id=id).first()
    db.session.delete(orderdetail)
    db.session.commit()
    flash("This item has been successfully deleted from the shopping cart!", "success")
    return redirect(url_for("shopping_car"))


@app.route("/customer/add_num_by_1/<int:id>", methods=["POST", "GET"])
@login_required
def add_by_1(id):
    if current_user.table_name != "Customer":
        abort(403)
    shopping_car = Order.query.filter_by(
        customer_id=current_user.table_id, status="0").first()
    orderdetail = OrderDetail.query.filter_by(
        order_id=shopping_car.id, product_id=id).first()

    orderdetail.product_count = orderdetail.product_count+1
    db.session.add(orderdetail)
    db.session.commit()
    flash("uccessfully added 1！！！", "success")
    return redirect(url_for("shopping_car"))


@app.route("/customer/add_num_by_10/<int:id>", methods=["POST", "GET"])
@login_required
def add_by_10(id):
    if current_user.table_name != "Customer":
        abort(403)

    shopping_car = Order.query.filter_by(
        customer_id=current_user.table_id, status="0").first()
    orderdetail = OrderDetail.query.filter_by(
        order_id=shopping_car.id, product_id=id).first()
    orderdetail.product_count = orderdetail.product_count+10
    db.session.add(orderdetail)
    db.session.commit()
    flash("Successfully added 10！！！", "success")
    return redirect(url_for("shopping_car"))


@app.route("/customer/delete_num_by_1/<int:id>", methods=["POST", "GET"])
@login_required
def delete_by_1(id):
    if current_user.table_name != "Customer":
        abort(403)
    shopping_car = Order.query.filter_by(
        customer_id=current_user.table_id, status="0").first()
    orderdetail = OrderDetail.query.filter_by(
        order_id=shopping_car.id, product_id=id).first()
    orderdetail.product_count = orderdetail.product_count-1
    db.session.add(orderdetail)
    db.session.commit()
    flash("Successfully reduced by 1！！！", "success")
    return redirect(url_for("shopping_car"))


@app.route("/customer/delete_num_by_10/<int:id>", methods=["POST", "GET"])
@login_required
def delete_by_10(id):
    if current_user.table_name != "Customer":
        abort(403)
    shopping_car = Order.query.filter_by(
        customer_id=current_user.table_id, status="0").first()
    orderdetail = OrderDetail.query.filter_by(
        order_id=shopping_car.id, product_id=id).first()
    orderdetail.product_count = orderdetail.product_count-10
    db.session.add(orderdetail)
    db.session.commit()
    flash("Successfully reduced by 10！！！", "success")
    return redirect(url_for("shopping_car"))


@app.route("/customer/confirm_order/<int:id>", methods=["POST", "GET"])
@login_required
def confirm_order(id):
    if current_user.table_name != "Customer" or \
            Order.query.filter_by(id=id).first().customer_id != current_user.table_id:
        abort(403)

    address = CustomerDetail.query.filter_by(
        customer_id=current_user.table_id, is_default=1).first()
    if address is None:
        flash("You have not set the default address, please go to set the default address! ! !", "warning")
        return redirect(url_for("customer_detail_manager", username=current_user.username))
    shopping_car = Order.query.filter_by(id=id).first()

    for detail in shopping_car.orderdetails:
        product = Product.query.filter_by(id=detail.product_id).first()

        if detail.product_count > product.product_count:
            if product.product_count > 0:
                flash("Sorry, your goods have just been snatched away, not so much, please update your order!", "warning")
                detail.product_count = 1
                db.session.add(detail)
                db.session.commit()
                return redirect(url_for("shopping_car"))
            else:
                flash("Sorry, just now your goods have been taken away, not so much, come early next time!", "warning")
                row = detail
                db.session.delete(row)
                db.session.commit()
                return redirect(url_for("shopping_car"))
        else:
            product.product_count = product.product_count-detail.product_count
            db.session.add(product)
            db.session.commit()
        # 1 代表付款成功

        # 将默认地址设置为 订单的地址
        default = CustomerDetail.query.filter_by(
            customer_id=current_user.table_id, is_default=1).first()
        order_address = OrderAddress()

        order_address.address = default.address
        order_address.telephone = default.telephone
        order_address.consignee = default.consignee
        order_address.order_id = shopping_car.id
        db.session.add(order_address)

        shopping_car.status = 1
        shopping_car.start_time = datetime.now()
        print(shopping_car.start_time)
        db.session.add(shopping_car)
        db.session.commit()
        return redirect(url_for("shopping_car"))


@app.route("/customer/<string:username>/detail/")
@login_required
def customer_detail_manager(username):
    user = Customer.query.filter_by(username=username).first_or_404()
    if user.username != current_user.username:
        abort(403)
    return render_template("coustomer_detail_manager.html")


@app.route("/customer/order_manager")
@login_required
def customer_order_manager():
    return render_template("customer_order_manager.html")


@app.route("/customer/order_manager/order_waitting")
@login_required
def waitting_orders():
    if current_user.table_name != "Customer":
        abort(403)
    orders = Order.query.filter_by(
        customer_id=current_user.table_id, status=1).all()

    return render_template("waitting_orders.html", orders=orders)


@app.route("/customer/order_manager/cancel_order/<int:id>")
@login_required
def cancel_orders(id):
    order = Order.query.filter_by(id=id).first()
    if current_user.table_name != "Customer" or order.customer_id != current_user.table_id:
        abort(403)
    if order.status != 1:  # 确保取消订单之前他的状态确实是付款了，但还没发货的
        flash("The order has not been cancelled! The order has been shipped!", "danger")
        return redirect(url_for("waitting_orders"))

    # 把库存换回去，删除订单地址，删除订单
    else:
        details = order.orderdetails
        for detail in details:
            product = Product.query.filter_by(id=detail.product_id).first()
            product.product_count = product.product_count+detail.product_count
            db.session.add(product)
            db.session.commit()
            db.session.delete(detail)
            db.session.commit()

        order_address = OrderAddress.query.filter_by(order_id=id).first()
        db.session.delete(order_address)
        db.session.commit()
        db.session.delete(order)
        db.session.commit()
        flash("Your order has been cancelled and the refund was successful!", "success")
        return redirect(url_for("waitting_orders"))


@app.route("/customer/order_manager/order_traning")
@login_required
def traning_orders():
    if current_user.table_name != "Customer":
        abort(403)
    # 2代表的成功发货的订单
    orders = Order.query.filter_by(
        customer_id=current_user.table_id, status=2).all()
    return render_template("traning_orders.html", orders=orders)


@app.route("/customer/order_manager/confirm_order_traning/<int:id>")
@login_required
def confirm_traning_orders(id):
    if current_user.table_name != "Customer":
        abort(403)
    # 3代表的成功发货的订单
    order = Order.query.filter_by(id=id).first()
    order.status = 3
    order.end_time = datetime.now()
    db.session.add(order)
    db.session.commit()
    flash("You should receive the goods successfully, welcome to visit next time!", "success")
    return redirect(url_for("traning_orders"))


@app.route("/customer/order_manager/order_completed")
@login_required
def completed_orders():
    if current_user.table_name != "Customer":
        abort(403)

    # 3代表的收货成功的订单，也就是完成了交易
    orders = Order.query.filter_by(
        customer_id=current_user.table_id, status=3).all()
    return render_template("completed_orders.html", orders=orders)


@app.route("/customer/detail/new/post/", methods=["GET", "POST"])
@login_required
def new_customer_detail():
    if current_user.table_name != "Customer":
        abort(403)
    form = CustomerDetailForm()
    if form.validate_on_submit():
        print(current_user.table_id)
        detail = CustomerDetail(customer_id=current_user.table_id, consignee=form.consignee.data,
                                telephone=form.telephone.data, address=form.address.data)
        db.session.add(detail)
        db.session.commit()
        flash("Successfully added shipping address！", "success")
        return redirect(url_for("customer_detail_manager", username=current_user.username))
    return render_template("new_customer_detail.html", form=form)


@app.route("/customer/detail/show_all")
@login_required
def show_customer_detail():
    if current_user.table_name != "Customer":
        abort(403)

    details = Customer.query.filter_by(
        id=current_user.table_id).first_or_404().detail

    return render_template("show_customer_detail.html", details=details)


@app.route("/customer/detail/update/<int:id>", methods=["GET", "POST"])
@login_required
def update_customer_detail(id):
    if current_user.table_name != "Customer":
        abort(403)
    detail = CustomerDetail.query.filter_by(id=id).first_or_404()

    form = UpdateCustomerDetailForm()
    if form.validate_on_submit():
        detail.consignee = form.consignee.data
        detail.address = form.address.data
        detail.telephone = form.telephone.data
        db.session.commit()
        flash("shopping address updated successfully!", "success")
        return redirect(url_for("show_customer_detail"))
    elif request.method == "GET":
        form.consignee.data = detail.consignee
        form.address.data = detail.address
        form.telephone.data = detail.telephone
    return render_template("update_customer_detail.html", form=form)


@app.route("/customer/detail/delete/<int:id>")
@login_required
def delete_customer_detail(id):
    if current_user.table_name != "Customer":
        abort(403)
    detail = CustomerDetail.query.filter_by(id=id).first_or_404()
    db.session.delete(detail)
    db.session.commit()
    flash("Successfully deleted delivery address", "success")
    return redirect(url_for("show_customer_detail"))


@app.route("/customer/detail/set_default/<int:id>", methods=["GET", "POST"])
@login_required
def set_customer_detail_default(id):
    if current_user.table_name != "Customer" or\
            CustomerDetail.query.filter_by(id=id).first_or_404().customer_id != current_user.table_id:
        abort(403)
    detail = CustomerDetail.query.filter_by(
        customer_id=current_user.table_id, is_default=1).first()
    if detail:
        detail.is_default = 0
        db.session.add(detail)
        db.session.commit()

    detail1 = CustomerDetail.query.filter_by(id=id).first()
    detail1.is_default = 1
    db.session.add(detail1)
    db.session.commit()

    flash("The default address has been updated!", "success")
    return redirect(url_for("show_customer_detail"))


@app.route("/security_check", methods=["GET", "POST"])
@login_required
def security_check():

    form = SecurityCheck()
    if form.validate_on_submit():
        user = Customer.query.filter_by(id=current_user.table_id).first()
        if user and bcrypt.check_password_hash(user.password, form.password.data):
            flash("Successful authentication", "success")
            return redirect(url_for("update_info"))
        else:
            flash("Authentication failed", "warning")
    return render_template("security_check.html", form=form)


@app.route("/update/info", methods=["GET", "POST"])
@login_required
def update_info():
    form = UpdateInfo()
    role = Customer.query.filter_by(
        id=current_user.table_id).first_or_404()
    if form.validate_on_submit():
        role.username = form.username.data
        role.email = form.email.data
        db.session.add(role)
        db.session.commit()

        user = User.query.filter_by(id=current_user.id).first_or_404()
        user.username = form.username.data
        user.email = form.email.data
        db.session.add(user)
        db.session.commit()
        flash('Your email and username have been updated', 'success')
        return redirect(url_for("home"))

    if request.method == "GET":
        form.username.data = role.username
        form.email.data = role.email
    return render_template("update_info.html", form=form)


@app.route("/update/password", methods=["GET", "POST"])
@login_required
def update_password():
    form = UpdatePasswordForm()
    role = Customer.query.filter_by(id=current_user.table_id).first_or_404()
    if form.validate_on_submit():
        hashed_password = bcrypt.generate_password_hash(
            password=form.password.data).decode("utf-8")
        role.password = hashed_password
        role.confirm_password = form.confirm_password.data
        db.session.add(role)
        db.session.commit()

        user = User.query.filter_by(id=current_user.id).first_or_404()
        user.password = hashed_password
        user.confirm_password = form.confirm_password.data
        db.session.add(user)
        db.session.commit()
        flash('Your password has been updated', 'success')
        return redirect(url_for("home"))

    return render_template("update_password.html", form=form)
