<template>
  <v-app fluid id="app" class="layout">
    <v-content>
      <v-container style="padding: 0;" fluid>
        <v-layout>
          <v-flex style="flex:1;padding:0;max-height: 100%;" md-6>
            <EditBox v-model="content"/>
          </v-flex>
          <v-flex style="flex:1;max-height: 100%;" md-6>
            <ShowBox :content="content"/>
          </v-flex>
        </v-layout>
      </v-container>
      <Nagivation v-model="showSetting" />
    </v-content>
    <v-speed-dial fixed :bottom="true" :right="true">
      <template v-slot:activator>
        <v-btn
          v-model="showSetting"
          @click="showSetting=!showSetting"
          color="blue darken-2"
          dark
          fab
        >
          <v-icon>settings</v-icon>
          <v-icon>close</v-icon>
        </v-btn>
      </template>
    </v-speed-dial>
  </v-app>
</template>

<script>
import EditBox from "./EditBox";
import ShowBox from "./ShowBox";
import Nagivation from "./Nagivation";
export default {
  components: {
    EditBox,
    ShowBox,
    Nagivation
  },
  data() {
    return {
      content: "",
      showSetting: false,
    }
  },
};
</script>

<style>
@import url("../styles/common.css");
</style>
