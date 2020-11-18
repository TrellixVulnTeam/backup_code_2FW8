from flask_admin.contrib.sqla import ModelView
from ..models import Comment

class CommentModel(ModelView):
    # column_searchable_list = ('username', )
    def __init__(self, session, **kwargs):
        # You can pass name and other parameters if you want to
        super(CommentModel, self).__init__(Comment, session, **kwargs)