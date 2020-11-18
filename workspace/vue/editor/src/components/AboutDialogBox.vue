<template>
  <v-dialog v-model="dialog" persistent max-width="290">
    <v-card>
      <v-card-title class="headline">About</v-card-title>
      <v-card-text>
        <p>mdmd markdown编辑器</p>
        <p>基于Vue.js + Vuetify开发</p>
        <p>acldm习作</p>
      </v-card-text>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="green darken-1" flat @click="dialog = false">OK</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
import TransModel from "../TransModel";
export default {
  mixins: [TransModel("dialog")]
};
</script>

<style>
</style>
