import os.path as op
from flask_admin import Admin, form
from flask_admin.contrib import sqla, rediscli
from flask_admin.contrib.sqla import ModelView
from ..models import Card, User, Store
from . import db

file_path = op.join(op.dirname(__file__), '../files')
print(file_path)

admin = Admin(name='cards_manager', template_mode='bootstrap3')

class ImageView(sqla.ModelView):
    form_extra_fields = {
        'path': form.ImageUploadField('Image',
                                      base_path=file_path)
    }

admin.add_view(ImageView(Card, db.session, name='cards_manager',  endpoint='admin-card'))
admin.add_view(ModelView(User, db.session, name='user_manager',  endpoint='admin-user'))
admin.add_view(ModelView(Store, db.session, name='store_manager',  endpoint='admin-store'))