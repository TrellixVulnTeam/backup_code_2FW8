from ..extensions import db


class Comment(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    message = db.Column(db.String(256), nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    project_id = db.Column(db.Integer, db.ForeignKey(
        'project.id'), nullable=False)

    parent_id = db.Column(
        db.Integer, db.ForeignKey("comment.id"))  # 父评论id
    parent = db.relationship("Comment", remote_side=[id])  # 自关联

    def __init__(self, message, user_id, project_id):
        self.message = message
        self.user_id = user_id
        self.project_id = project_id

    def __repr__(self):
        return '%r' % self.message

    def to_preview_json(self):
        return {
            'id': self.id,
            'project_id': self.project_id,
            'message': self.message,
            'username': self.user.username
            
        }
