
import os
import tempfile
import re
import pytest
from app import app, db


class TestClass:
    def setup_class(self):
        app.config['TESTING'] = True  # 这将会使得处理请求时的错误捕捉失效，以便于 您在进行对应用发出请求的测试时获得更好的错误反馈。
        self.app = app.test_client()

    def test_login(self):
        response = self.app.post('/login', data={"username": "ami", "password": "123", "submit": "Login"})
        with open('s', 'w+', encoding='utf-8') as f:
            f.write(str(response.data, encoding='utf-8'))
        assert response.status_code == 200

    