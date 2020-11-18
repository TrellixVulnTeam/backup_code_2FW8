import React, { useState } from 'react';
import './App.css';
import Header from './components/header';
import { Row, Col } from 'antd';
import Tools from './components/tools';
import { Form, Input, Button, Checkbox } from 'antd';
import Board from './components/board';

function App() {
  const [drawType, setDrawType] = useState(null)

  return (
    <div className="App">
      <Header />
      <Row>
        <Col span={18}>
          <Tools setDrawType={setDrawType} />
          <Board drawType={drawType} />
        </Col>
        <Col span={6}>
          <div style={{

          }}>
            <Form>
              <Form.Item
                label="项目编号"
                name="username"
              >
                <Input />
              </Form.Item>
              <Form.Item
                label="项目名称"
                name="username"
              >
                <Input />
              </Form.Item>
              <Form.Item
                label="行业大类"
                name="username"
              >
                <Input />
              </Form.Item>
              <Form.Item
                label="海康技术"
                name="username"
              >
                <Input />
              </Form.Item>
              <Form.Item
                label="海康销售"
                name="username"
              >
                <Input />
              </Form.Item>
            </Form>

            <Form>
              <Form.Item
                label="序列号"
                name="username"
              >
                <Input />
              </Form.Item>
              <Form.Item
                label="产品型号"
                name="username"
              >
                <Input />
              </Form.Item>
              <Form.Item
                label="版本"
                name="username"
              >
                <Input />
              </Form.Item>
              <Form.Item
                label="销售日期"
                name="username"
              >
                <Input />
              </Form.Item>
              <Form.Item
                label="保修天数"
                name="username"
              >
                <Input />
              </Form.Item>
              <Form.Item
                label="出厂版本"
                name="username"
              >
                <Input />
              </Form.Item>
            </Form>

          </div>
        </Col>
      </Row>
    </div>
  );
}

export default App;
