from flask_admin.contrib.sqla import ModelView
from ..models import Feel

class FeelModel(ModelView):
    # column_searchable_list = ('username', )
    def __init__(self, session, **kwargs):
        # You can pass name and other parameters if you want to
        super(FeelModel, self).__init__(Feel, session, **kwargs)