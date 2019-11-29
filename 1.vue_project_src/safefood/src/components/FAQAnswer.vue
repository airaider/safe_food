<template>
  <div>
    <table align="center">
      <tr bgcolor="skyblue">
        <th>no</th>
        <td bgcolor="white">{{ faq.no }}</td>
      </tr>
      <tr bgcolor="skyblue">
        <th>id</th>
        <td bgcolor="white">{{ faq.id }}</td>
      </tr>
      <tr bgcolor="skyblue">
        <th>title</th>
        <td bgcolor="white">{{ faq.title }}</td>
      </tr>
      <tr bgcolor="skyblue">
        <th>regdate</th>
        <td bgcolor="white">{{ faq.regdate }}</td>
      </tr>
      <tr bgcolor="skyblue">
        <th>contents</th>
        <td bgcolor="white">{{ faq.contents }}</td>
      </tr>
      <tr bgcolor="skyblue">
        <th>reply</th>
        <td>
          <input
            type="text"
            placeholder="답변을 입력하세요"
            v-model="faq.reply"
          />
        </td>
      </tr>
    </table>

    <input type="button" value="등록하기" @click="insert" />
    <input type="button" value="뒤로가기" @click="back" />
  </div>
</template>

<script>
import Constant from "../Constant";

export default {
  name: "FAQ",
  computed: {
    faq() {
      return this.$store.state.faq;
    }
  },
  created() {
    this.$store.dispatch(Constant.GET_FAQ, { no: this.$route.params.no });
  },
  methods: {
    back() {
      this.$router.push("/list");
    },
    insert() {
      console.log(this.faq.reply);
      if (this.faq.reply.trim() != "") {
        this.$store.dispatch(Constant.COMPLETE_FAQ, { faq: this.faq });
        this.clear();
        this.$router.push("/list");
      }
    },
    clear() {
      this.faq.reply = "";
    }
  }
};
</script>

<style scoped></style>
