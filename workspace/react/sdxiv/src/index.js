import React, { useState } from "react";
import ReactDOM from "react-dom";
import "./styles.css";
import { Table, Button, message } from "antd";
import "antd/dist/antd.css";

const columns = [
  {
    title: "房间类型",
    dataIndex: "type",
    key: "type"
  },
  {
    title: "单价",
    dataIndex: "price",
    key: "price"
  },
  {
    title: "房间大小",
    dataIndex: "size",
    key: "size"
  },
  {
    title: "好评率",
    dataIndex: "likes",
    key: "likes"
  },
  {
    title: "动作",
    dataIndex: "action",
    key: "action",
    render: (func, record) => {
      return <Button onClick={() => func(record)}>加入购物车</Button>;
    }
  }
];

const orderColumns = [
  {
    title: "房间类型",
    dataIndex: "type",
    key: "type"
  },
  {
    title: "数量",
    dataIndex: "count",
    key: "count"
  },
  {
    title: "总价",
    dataIndex: "amount",
    key: "amount"
  }
];

export default function Shopping({ onPush }) {
  const handlePush = record => {
    onPush(record);
    message.info("已加入购物车");
  };

  const data = [
    {
      key: "1",
      type: "单人间",
      price: 426,
      size: "42m2",
      likes: "88%",
      action: handlePush
    },
    {
      key: "2",
      type: "双人间",
      price: 526,
      size: "52m2",
      likes: "82%",
      action: handlePush
    },
    {
      key: "3",
      type: "三人间",
      price: 668,
      size: "55m2",
      likes: "90%",
      action: handlePush
    },
    {
      key: "4",
      type: "标间",
      price: 668,
      size: "55m2",
      likes: "92%",
      action: handlePush
    },
    {
      key: "5",
      type: "商务行政房",
      price: 888,
      size: "65m2",
      likes: "94%",
      action: handlePush
    },
    {
      key: "6",
      type: "商务套房",
      price: 988,
      size: "65m2",
      likes: "94%",
      action: handlePush
    },
    {
      key: "7",
      type: "豪华套房",
      price: 1088,
      size: "70m2",
      likes: "95%",
      action: handlePush
    }
  ];

  return <Table title={() => "选择房间"} columns={columns} dataSource={data} />;
}

function Order({ datas = [] }) {
  const all_data = [];
  for (let d of datas) {
    let ac = all_data.find(v => v.type === d.type);
    if (!ac) {
      ac = {
        type: d.type,
        amount: 0,
        count: 0,
        key: all_data.length
      };
      all_data.push(ac);
    }
    ac["amount"] += d.price;
    ac["count"] += 1;
  }

  const priceAmount = all_data.reduce((p, a) => p + a.amount, 0);
  return (
    <Table
      footer={() => `总计价格:${priceAmount}`}
      title={() => "购物车"}
      columns={orderColumns}
      dataSource={all_data}
    />
  );
}

function App() {
  const [shopList, setShopList] = useState([]);
  const pushShop = record => setShopList([...shopList, record]);
  return (
    <div className="App">
      <Shopping onPush={pushShop} />
      <Order datas={shopList} />
    </div>
  );
}

const rootElement = document.getElementById("root");
ReactDOM.render(<App />, rootElement);
