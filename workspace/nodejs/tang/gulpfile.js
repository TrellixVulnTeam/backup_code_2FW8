var gulp = require('gulp');
var gulp_ejs = require('gulp-ejs');

gulp.task('compile', function () {
  var data = {
    links: [
      {
        title: 'Home',
        href: './index.html'
      },
      {
        title: 'Timeline',
        href: './timeline.html'
      },
      {
        title: 'Culture',
        href: './culture.html',
        subs: [
          {
            title: 'Ouyang Xun',
            href: './calligraphy.html',
          },
          {
            title: 'Yan Zhenqing',
            href: './calligraphy2.html',
          },
          {
            title: 'Poem',
            href: './poem.html',
          },
        ]
      },
      {
        title: 'Arts',
        href: './arts.html'
      },
      {
        title: 'Economy',
        href: './economy.html'
      },
      {
        title: 'Contact',
        href: '#',
      }
    ],
    historys: [
      {
        title: "贞观之治",
        desc: "是唐朝初年唐太宗在位期间出现的清明政治，经济复苏，文化繁荣的治世局面。",
        img: "zgzz.jpg"
      },
      {
        title: "武周篡唐",
        desc: "690年，武则天御则天门即皇帝位，改国号为周，定都洛阳，成为中国历史上唯一的女皇帝。",
        img: "wzt.jpg"
      },
      {
        title: "开元盛世",
        desc: "李隆基登基以后整顿诸多弊政，整饬吏治，推崇节俭、抑制佛教，唐朝国力空前强盛逐渐步入盛世，史称“开元盛世”。",
        img: "kyss.jpg"
      },
      {
        title: "安史之乱",
        desc: "公元755年十一月，安禄山趁唐朝政治腐败、军事空虚之机发动叛乱，次年攻入洛阳，唐玄宗率众逃至成都，史称“安史之乱”。",
        img: "aszl.jpg"
      },
      {
        title: "元和中兴",
        desc: "唐宪宗在位15年间，政绩较多，在政治上有所改革，勤勉政事，并重振中央政府的威望，成就了唐朝的中兴气象，唐朝获得再次统一。",
        img: "txz.jpg"
      },
      {
        title: "丝绸之路",
        desc: "唐朝的丝绸之路有所开拓，将南北朝以来因战乱而中断的部分路段进行了疏通，并开通了天山北路的一段。",
        img: "sczl.jpg"
      },
    ],
    kings: [
      {
        name: '李世民',
        time: '626—649在位',
        img: 'lsm.jpg',
      },
      {
        isNull: true,
      },
      {
        isNull: true,
      },
      {
        name: '李治',
        time: '649—683在位',
        img: 'lz.jpg',
      },
      {
        isNull: true,
      },
      {
        isNull: true,
      },
      {
        name: '李显',
        time: '公元684年在位',
        img: 'lx.png',
      },
      {
        name: '李旦',
        time: '684—690',
        img: 'ld.jpg',
      },
      {
        name: '武曌（武则天）',
        time: '624年－705年',
        img: 'wzt.jpg',
      },
      {
        isNull: true,
      },
      {
        name: '李显',
        time: '705—710',
        img: 'lx.png',
      },
      {
        name: '李旦',
        time: '710—712',
        img: 'ld.jpg',
      },
      {
        name: '李隆基',
        time: '712—756',
        img: 'llj.jpg',
      }
    ],
    arts: [
      { img: 'h1.jpg' },
      { img: 'h2.jpg' },
      { img: 'h3.jpg' },
      { img: 'h4.jpg' },
      { img: 'h5.jpg' },
      { img: 'h6.jpg' },
      { img: 'h7.jpg' },
      { img: 'h8.jpg' },
      { img: 'h9.jpg' },
      { img: 'h10.jpg' },
      { img: 'h11.jpg' },
      { img: 'h12.jpg' },
      { img: 'h13.jpg' },
      { img: 'h14.jpg' },
      { img: 'h15.jpg' },
      { img: 'h16.jpg' },
      { img: 'h17.jpg' },
      { img: 'h18.jpg' },
    ],
    poems: [
      {
        img: 'libai.png',
        title: 'Li Bai',
        desc: 'Li Bai also known as Li Bo, courtesy name Taibai, was a Chinese poet acclaimed from his own day to the present as a genius and a romantic figure who took traditional poetic forms to new heights. '
      },
      {
        img: 'dufu.png',
        title: 'Du Fu',
        desc: 'Du Fu Along with Li Bai (Li Po), he is frequently called the greatest of the Chinese poets.is greatest ambition was to serve his country as a successful civil servant, but he proved unable to make the necessary accommodations. '
      }
    ],
    calligraphys: [
      {
        img: 'ouyangxun.png',
        title: 'Ouyang Xun',
        desc: 'courtesy name Xinben (信本), was a Confucian scholar and calligrapher of the early Tang Dynasty.'
      },
      {
        img: 'yanzhenqing.png',
        title: 'Yanzhen Qing',
        desc: 'was a leading Chinese calligrapher and a loyal governor of the Tang Dynasty. '
      },
      {
        img: 'peixiu.png',
        title: 'Pei Xiu',
        desc: 'courtesy name Jiyan, geographer, writer, and cartographer of the state of Cao Wei during the late Three Kingdoms period of China. '
      }
    ]
  };
  gulp.src(['templates/*.html'])
    .pipe(gulp_ejs(data))
    .pipe(gulp.dest('./build/html'));
})