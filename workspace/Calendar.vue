
<template>
  <div class="calendar">
    <div class="header">
      <div>星期日</div>
      <div>星期一</div>
      <div>星期二</div>
      <div>星期三</div>
      <div>星期四</div>
      <div>星期五</div>
      <div>星期六</div>
    </div>
    <Weeks v-for="(week, index) in weekdays" :key="index" :days="week" v-slot="{day}">
      <!-- <template v-if="dates[day - 1]"> -->
          {{dates[0].info.cnday}}
      <!-- </template> -->
    </Weeks>
  </div>
</template>

<script>
import Weeks from "./Weeks";

export default {
  props: {
    year: Number,
    month: Number
  },
  data() {
    return {
      datesCache: new Map(),
      dates: [],
    };
  },
  methods: {
    //加载资源
    async loadDates() {
      if (this.datesCache.get(this.url)) {
        console.log("AA")
        return this.datesCache.get(this.url)
      }
      let date = await import(`./assets/j${this.url}.json`);
      date = date.data.objects
      // date.forEach(t => {
      //   t.info = JSON.parse(t.info)
      // })
      this.datesCache.set(this.url, date);
      return date
    },
  },
  computed: {
    //当前月份天数
    days() {
      return new Date(this.year, this.month, 0).getDate();
    },
    //当前月份第一天星期
    firstWeek() {
      let date = new Date(this.year, this.month - 1, 1);
      return date.getDay();
    },
    //当前月份星期划分
    weekdays() {
      let weeks = [];
      let nowWeek = this.firstWeek;

      //头部补全
      weeks.push(...new Array(nowWeek).fill(null));

      for (let i = 1; i <= this.days; i++) {
        weeks.push(i);
        nowWeek = (nowWeek + 1) % 7;
      }

      //尾部补全,nowWeek此时超前一天
      weeks.push(...new Array(7 - nowWeek).fill(null));

      let weekArr = [];
      for (let i = 0; i < weeks.length; i += 7) {
        weekArr.push(weeks.slice(i, i + 7));
      }

      return weekArr;
    },
    url() {
      return `${this.year}_${this.month}`
    },
  },
  async created() {
    console.log("CREATE!")
    this.dates = await this.loadDates()
  },
  watch: {
    async year() {
      await this.loadDates()
    },
    async month() {
      await this.loadDates()
    },
  },
  components: {
    Weeks
  }
};
</script>

<style scoped>
.calendar {
  max-width: 876px;
  margin: 0 auto;
}

.calendar > .header {
  display: flex;
  line-height: 2em;
  border-bottom: 1px solid palevioletred;
}

.calendar > .header > div {
  flex: 1;
}

.lunar {
  font-size: .5em;
}
</style>
