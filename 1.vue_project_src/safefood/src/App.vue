<template>
  <div id="app">
    <f-a-q-header></f-a-q-header>
    <br/>
    <router-view></router-view>
  </div>
</template>

<script>
import FAQHeader from "./components/FAQHeader.vue";
import FAQList from "./components/FAQList.vue";
import FAQInput from "./components/FAQInput.vue";
import FAQDetail from "./components/FAQDetail.vue";
import FAQAnswer from "./components/FAQAnswer.vue";
import VueRouter from "vue-router";
import Vue from "vue";

Vue.use(VueRouter);

const router = new VueRouter({
  mode: "history",
  routes: [
    { path: "/", component: FAQList },
    { path: "/qna.jsp", component: FAQList },
    { path: "/index.html", component: FAQList},
    { path: "/list", component: FAQList },
    { path: "/input", component: FAQInput },
    { path: "/detail/:no", component: FAQDetail },
    { path: "/answer/:no", component: FAQAnswer }
  ]
});

export default {
  name: "app",
  components: {
    FAQHeader
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
