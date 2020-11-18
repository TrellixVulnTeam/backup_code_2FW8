import React from 'react'
import { Tabs } from 'antd'
const { TabPane } = Tabs;


const DATA = [
  {
    key :1,
    name: '基础设备',
    components: [
      {
        name: '摄像头',
        src: '摄像头.png'
      },
      {
        name: '存储',
        src: '存储器.png'
      },
      {
        name: '交换机',
        src: '交换机.png'
      },
      {
        name: '服务器',
        src: '服务器.png'
      },
      {
        name: '解码器',
        src: '解码器.png'
      }
    ]
  },
  {
    key :2,
    name: '停车场设备',
    components: [
      {
        name: '道闸',
        src: '道闸.png'
      },
      {
        name: '道闸2',
        src: '道闸2.png'
      },
      {
        name: '入口机',
        src: '入口机.png'
      },
      {
        name: '自助缴费机',
        src: '自助缴费机.png'
      },
      {
        name: '车辆检测器',
        src: '车辆检测器.png'
      },
      {
        name: '停车诱导',
        src: '停车诱导.png'
      },
      {
        name: '停车屏',
        src: '停车屏.png'
      },
    ]
  },
  {
    key :3,
    name: '门禁设备',
  },
  {
    key :4,
    name: '消防设备',
  },
  {
    key :5,
    name: '机器人设备',
  }
]

export default function ToolTabs(props) {

  const tab_list = DATA.map(({ name, key, components = [] }) => {
    let card = []
    components.forEach(({ name, src }) => {
      card.push(<img key={name} style={{
        width: 100,
        objectFit: 'cover'
      }} alt="" src={require(`./images/${src}`)} />)
    })
    let tab = <TabPane tab={name} key={key}>
      {card}
    </TabPane>
    return tab
  })

  return (
    <div>
      <Tabs style={{
        margin: 0,
        position: 'fixed',
        width: '100%',
        bottom: 0
        }} type='card'>
        {tab_list}
      </Tabs>
    </div>

  )
}