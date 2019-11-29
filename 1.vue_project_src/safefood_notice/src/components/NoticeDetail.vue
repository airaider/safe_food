<template>
  <div>
    <table align="center" width="10">
      <tr>
        <th>no</th>
        <td>{{ notice.no }}</td>
      </tr>
      <tr>
        <th>title</th>
        <td>
          {{ notice.title }}
        </td>
      </tr>
      <tr class="contents">
        <th>contents</th>
        <td>{{ notice.contents }}</td>
      </tr>
    </table>
    <br/>
    <div v-if='isAdmin'>
      <input type="button" value="수정하기"/>
      <input type="button" value="삭제하기" @click="erase" />
    </div>
    <input type="button" value="목록보기" @click="back" />
    <br/>
  </div>
</template>

<script>
import Constant from "../Constant";
export default {
  name: "notice",
  computed: {
    notice() {
      return this.$store.state.notice;
    },
    isAdmin() {
      if (this.$store.state.loginStatus.id == 'admin') {
        return true;
      } else {
        return false;
      }
    }
  },
  created() {
    this.$store.dispatch(Constant.GET_NOTICE, { no: this.$route.params.no });
  },
  methods: {
    back() {
      this.$router.push("/noticeList");
    },
    clear() {
      this.notice.reply = "";
    },
    erase() {
      this.$store.dispatch(Constant.REMOVE_NOTICE, { no: this.notice.no });
      this.$router.push("/noticeList");
    }
  }
};
</script>

<style scoped>
th {
  width: 30px;
  background-color:skyblue;
  vertical-align: middle;
}
td {
  padding: 10px;
  background-color: white;
  text-align: left;
}
.contents {
  height: 400px;
  vertical-align: top;
}
.reply{
  text-align: left;
}
</style>
