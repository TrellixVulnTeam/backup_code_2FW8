from flask_admin.contrib.sqla import ModelView
from ..models import Project, User

class ProjectModel(ModelView):
    # inline_models =  [(User, dict(form_columns=['user_id']))]
    column_searchable_list = ('name',)
    column_exclude_list = ['json', ]
    def __init__(self, session, **kwargs):
        # You can pass name and other parameters if you want to
        super(ProjectModel, self).__init__(Project, session, **kwargs)