<template>
  <div id="app">
    <NoticeHeader></NoticeHeader>
    <br/>
    <router-view></router-view>
  </div>
</template>

<script>
import NoticeHeader from "./components/NoticeHeader.vue";
import NoticeList from "./components/NoticeList.vue";
import NoticeInput from "./components/NoticeInput.vue";
import NoticeDetail from "./components/NoticeDetail.vue";
import VueRouter from "vue-router";
import Vue from "vue";

Vue.use(VueRouter);

const router = new VueRouter({
  mode: "history",
  routes: [
    { path: "/", component: NoticeList },
    { path: "/notice.jsp", component: NoticeList },
    { path: "/noticeIndex.html", component: NoticeList},
    { path: "/noticeList", component: NoticeList },
    { path: "/noticeInput", component: NoticeInput },
    { path: "/noticeDetail/:no", component: NoticeDetail }
  ]
});

export default {
  name: "app",
  components: {
   NoticeHeader
  },
  router
};
</script>

<style>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
body {
  text-align: center;
  background-color: #f6f6f8;
}
input {
  border-style: groove;
  width: 200px;
}
button {
  border-style: groove;
}
.shadow {
  box-shadow: 5px 10px 10px rgba(0, 0, 0, 0.03);
}
</style>
