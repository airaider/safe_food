<template>
  <div>
    <!-- ID가 admin이면 보이게 하기 -->
    <div v-if='isAdmin'>
      <router-link to="/noticeInput">글쓰기</router-link>
      <p/>
    </div>
    <table>
      <tr>
        <th width="10%">NO</th>
        <th width="70%">TITLE</th>
        <th width="10%">REGDATE</th>
      </tr>
      <tr v-for="notice in paginatedData" v-bind:key="notice.no" @click.stop="getnotice(notice.no)">
        <td>{{ notice.no }}</td>
        <td>{{ notice.title }}</td>
        <td>{{ notice.regdate }}</td>
      </tr>
    </table>
    <div class="btn-cover">
      <button :disabled="pageNum === 0" @click="prevPage" class="page-btn">
        이전
      </button>
      <span class="page-count">{{ pageNum + 1 }} / {{ pageCount }} 페이지</span>
      <button :disabled="pageNum >= pageCount - 1" @click="nextPage" class="page-btn">
        다음
      </button>
    </div>
  </div>
</template>

<script>
import Constant from "../Constant";

export default {
  name: 'noticeList',
  data () {
    return {
      pageNum: 0
    }
  },
  props: {
    pageSize: {
      type: Number,
      required: false,
      default: 10
    }
  },
  methods: {
    nextPage () {
      this.pageNum += 1;
    },
    prevPage () {
      this.pageNum -= 1;
    },
    removenotice(no) {
      this.$store.dispatch(Constant.REMOVE_NOTICE, { no });
    },
    getnotice(no) {
      this.$router.push("/noticeDetail/" + no);
    }
  },
  computed: {
    noticeItems() {
      console.log(this.$store.state.noticeItems);
      return this.$store.state.noticeItems;
    },
    pageCount () {
      let listLeng = this.noticeItems.length,
          listSize = this.pageSize,
          page = Math.floor(listLeng / listSize);
      if (listLeng % listSize > 0) page += 1;
      
      /*
      아니면 page = Math.floor((listLeng - 1) / listSize) + 1;
      이런식으로 if 문 없이 고칠 수도 있다!
      */
      return page;
    },
    // 페이지에 맞게 noticeList 잘라주는거
    paginatedData () {
      const start = this.pageNum * this.pageSize,
            end = start + this.pageSize;
      return this.noticeItems.slice(start, end);
    },
    isAdmin() {
      if (this.$store.state.loginStatus.id == 'admin') {
        return true;
      } else {
        return false;
      }
    }
  },
  created () {
      this.$store.dispatch(Constant.GET_NOTICELIST);
      this.$store.dispatch(Constant.GET_LOGINSTATUS);
  },
}
</script>

<style>
table {
  width: 100%;
  border-collapse: collapse;
  font-size: 1.7rem;
}
table tr th {
  text-align: center;
  height: 2rem;
  border-bottom: 2px solid #505050;
}
table tr:first-of-type {
  border-top: 2px solid #404040;
}
table tr td {
  padding: 1rem 0;
}
.btn-cover {
  margin-top: 1.5rem;
  text-align: center;
}
.btn-cover .page-btn {
  width: 5rem;
  height: 3rem;
  letter-spacing: 0.5px;
}
.btn-cover .page-count {
  padding: 0 1rem;
}
</style>