<template>
  <div>
    <h2 align="center">QnA 등록</h2>
    <table align="center">
      <tr bgcolor="skyblue">
        <th>title</th>
        <td><textarea class="textarea_header" placeholder="제목" v-model="faq.title" /></td>
      </tr>
      <tr bgcolor="skyblue">
        <th>contents</th>
        <td><textarea class="textarea_contents" placeholder="내용" v-model="faq.contents" /></td>
      </tr>
    </table>

    <input type="button" @click="addFAQ" value="등록" />
    <input type="button" value="목록보기" @click="back" />
  </div>
</template>

<script>
import Constant from "../Constant";
var today = new Date();
var date = "";
export default {
  data() {
    return {
      faq: {
        title: "",
        contents: "",
        no: 0,
        id: this.$store.state.loginStatus.id,
        reply: "",
        regdate: date
      }
    };
  },
  methods: {
    back() {
      this.$router.push("/list");
    },
    addFAQ() {
      if (this.faq.contents.trim() != "") {
        date =
          today.getFullYear() +
          "-" +
          (today.getMonth() + 1) +
          "-" +
          today.getDate();
        this.$store.dispatch(Constant.ADD_FAQ, { faq: this.faq });
        this.$router.push("/list");
        this.clear();
      }
    },
    clear() {
      this.faq.title = "";
      this.faq.contents = "";
    }
  }
};
</script>

<style scoped>
input:focus {
  outline: none;
}
.inputBox {
  background: white;
  height: 50px;
  line-height: 50px;
  border-radius: 5px;
}
.inputBox input {
  border-style: none;
  font-size: 0.9rem;
}
.addContainer {
  float: right;
  background: linear-gradient(to right, #6478fb, #8763fb);
  display: inline-block;
  width: 3rem;
  border-radius: 0 5px 5px 0;
}
.addContainer2 {
  float: right;
  background: linear-gradient(to right, #647811, #527810);
  display: inline-block;
  width: 3rem;
  border-radius: 0 5px 5px 0;
}
.modifyBtn, 
.addBtn {
  color: white;
  vertical-align: middle;
}
.textarea_header {
  width: 90%;
}
.textarea_contents {
  width: 90%;
  height: 500px;
}
</style>
