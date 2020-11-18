from ..extensions import db

class Feel(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    project_id = db.Column(db.Integer, db.ForeignKey(
        'project.id'), nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    is_favorite = db.Column(db.BOOLEAN, default=False)
    is_like = db.Column(db.BOOLEAN, default=False)

    def __init__(self, user_id, project_id, is_favorite = False, is_like = False):
        self.user_id = user_id
        self.project_id = project_id
        self.is_favorite = is_favorite
        self.is_like = is_like