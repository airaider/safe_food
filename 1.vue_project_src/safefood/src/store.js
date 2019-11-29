import Vue from "vue";
import Vuex from "vuex";
import Constant from "./Constant";
import http from "./http-common";

Vue.use(Vuex);
const store = new Vuex.Store({
  state: {
    faqItems: [],
    faq: {},
    replys: {},
    reply: [],
    loginStatus: []
  },
  actions: {
    [Constant.GET_FAQLIST]: store => {
      http
        .get("/faq")
        .then(response =>
          store.commit(Constant.GET_FAQLIST, { faqItems: response.data.data })
        )
        .catch(exp => alert("처리에 실패하였습니다." + exp));
    },
    [Constant.REMOVE_FAQ]: (store, payload) => {
      http
        .delete("/faq/" + payload.no)
        .then(() => {
          console.log("삭제 처리되었습니다.");
          store.dispatch(Constant.GET_FAQLIST);
        })
        .catch(exp => alert("삭제 처리에 실패하였습니다." + exp));
    },
    [Constant.COMPLETE_FAQ]: (store, payload) => {
      http
        .put("/faq/" + payload.faq.no, {
          no: payload.faq.no,
          id: payload.faq.id,
          title: payload.faq.title,
          contents: payload.faq.contents,
          regdate: payload.faq.regdate,
          reply: payload.faq.reply
        })
        .then(() => {
          console.log("답변을 등록했습니다.");
          store.dispatch(Constant.GET_FAQLIST);
        })
        .catch(exp => alert("완료 처리에 실패하였습니다." + exp));
    },
    [Constant.ADD_FAQ]: (store, payload) => {
      http
        .post("/faqinsert", {
          id: payload.faq.id,
          title: payload.faq.title,
          contents: payload.faq.contents,
          regdate: payload.faq.regdate,
          reply: payload.faq.reply
        })
        .then(() => {
          console.log("추가하였습니다.");
          store.dispatch(Constant.GET_FAQLIST);
        })
        .catch(() => console.log("추가에 실패하였습니다."));
    },
    [Constant.GET_FAQ]: (store, payload) => {
      http
        .get("/faq/" + payload.no)
        .then(response => {
          store.commit(Constant.GET_FAQ, { faq: response.data.data });
        })
        .catch(exp => alert("조회에 실패하였습니다." + exp));
    },
    [Constant.GET_REPLYLIST]: (store, payload) => {
      http
        .get("/reply/" + payload.qno)
        .then(response =>
          store.commit(Constant.GET_REPLYLIST, { replys: response.data.data })
        )
        .catch(exp => alert("댓글 조회에 실패하였습니다." + exp));
    },
    [Constant.ADD_REPLY]:(store, payload)=>{
      http.post("/replyinsert", {
        no: payload.reply.no,
        id: payload.reply.id,
        contents: payload.reply.contents,
        regdate: payload.reply.regdate,
        fno: payload.reply.fno
      }).then(() => {
        store.dispatch(Constant.GET_REPLYLIST, { qno: payload.reply.fno });
        console.log("댓글을 추가하였습니다.");
      }).catch(() => console.log("댓글 추가에 실패하였습니다."));
    },
    // 로그인 정보 조회
    [Constant.GET_LOGINSTATUS]: store => {
      http
        .get("/getLoginInfo.do")
        .then(response => {
          store.commit(Constant.GET_LOGINSTATUS, {
            loginStatus: response.data
          });
        })
        .catch(exp => alert("로그인정보 조회 처리에 실패하였습니다." + exp));
    }
  },
  mutations: {
    [Constant.GET_FAQLIST]: (state, payload) => {
      state.faqItems = payload.faqItems;
    },
    [Constant.GET_FAQ]: (state, payload) => {
      state.faq = payload.faq;
    },
    [Constant.GET_REPLYLIST]: (state, payload) => {
      state.replys = payload.replys;
    },
    [Constant.GET_LOGINSTATUS]: (state, payload) => {
      state.loginStatus = payload.loginStatus;
    }
  }
});

export default store;
