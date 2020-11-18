from flask_admin.contrib.sqla import ModelView
from ..models import User

class UserModel(ModelView):
    column_searchable_list = ('username', )
    def __init__(self, session, **kwargs):
        # You can pass name and other parameters if you want to
        super(UserModel, self).__init__(User, session, **kwargs)