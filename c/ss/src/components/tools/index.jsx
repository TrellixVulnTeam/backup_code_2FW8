import React from 'react';
import { EditOutlined, BorderOutlined, FontColorsOutlined, ClearOutlined } from '@ant-design/icons'
import { Button } from 'antd';
import './index.css'
export default function Tools({ setDrawType}) {
  return (
    <div className="tools">
      <Button type="primary" icon={<EditOutlined />} onClick={() => setDrawType('line')} />
      {/* <Button type="primary" icon={<FontColorsOutlined />} onClick={() => setDrawType('line')} /> */}
      <Button type="primary" icon={<BorderOutlined />} onClick={() => setDrawType('rect')} />
      <Button type="primary" icon={<ClearOutlined />} onClick={() => setDrawType('eraser')} />
    </div>
  );
}
