<template>
  <div>
    <table align="center" width="10">
      <tr>
        <th>no</th>
        <td>{{ faq.no }}</td>
      </tr>
      <tr>
        <th>id</th>
        <td>{{ faq.id }}</td>
      </tr>
      <tr>
        <th>title</th>
        <td>
          {{ faq.title }}
        </td>
      </tr>
      <tr class="contents">
        <th>contents</th>
        <td>{{ faq.contents }}</td>
      </tr>
    </table>
    <br/>
    <input type="button" value="수정하기" @click="insert" />
    <input type="button" value="삭제하기" @click="erase" />
    <input type="button" value="목록보기" @click="back" />
    <br/>
    <h3> REPLY </h3>
    <textarea cols="100%" v-model="reply.contents"/>
    <br/>
    <input type="button" value="댓글 등록" @click="addReply" />
    <br/>
    <div v-if=hasReplys>
    <table class="reply">
      <tr v-for="reply in replys" v-bind:key="reply.qno">
        <td> {{ reply.id }} </td>
        <td> {{ reply.contents }} </td>
      </tr>
    </table>
    </div>
    <div v-else>
      댓글이 없습니다.
    </div>

  </div>
</template>

<script>
import Constant from "../Constant";
var today = new Date();
var date = "";
export default {
  name: "FAQ",
  data() {
    return {
      reply: {
        no: 0,
        id: this.$store.state.loginStatus.id,
        contents: '',
        regdate: date,
        fno: 0
      }
    }
  },
  computed: {
    faq() {
      return this.$store.state.faq;
    },
    replys() {
      return this.$store.state.replys;
    },
    hasReplys() {
      return this.$store.state.replys.length > 0;
    }
  },
  created() {
    this.$store.dispatch(Constant.GET_FAQ, { no: this.$route.params.no });
    this.$store.dispatch(Constant.GET_REPLYLIST, { qno: this.$route.params.no });
    this.reply.fno = this.$route.params.no;
  },
  methods: {
    back() {
      this.$router.push("/list");
    },
    insert() {
      console.log(this.faq.reply);
      this.$store.dispatch(Constant.COMPLETE_FAQ, { faq: this.faq });
      this.clear();
      this.$router.push("/list");
    },
    clear() {
      this.faq.reply = "";
    },
    erase() {
      this.$store.dispatch(Constant.REMOVE_FAQ, { no: this.faq.no });
      this.$router.push("/list");
    },
    addReply() {
      if(this.reply.contents.trim() != '') {
        console.log(this.reply.contents);
        date =
          today.getFullYear() +
          "-" +
          (today.getMonth() + 1) +
          "-" +
          today.getDate();
        this.$store.dispatch(Constant.ADD_REPLY, { reply: this.reply });
        this.clearReply();
      }
    },
    clearReply() {
      this.reply.contents = "";
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
