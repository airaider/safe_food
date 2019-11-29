import Vue from "vue";
import Vuex from "vuex";
import Constant from "./Constant";
import http from "./http-common";

Vue.use(Vuex);
const store = new Vuex.Store({
  state: {
    noticeItems: [],
    notice: {},
    loginStatus: []
  },
  actions: {
    [Constant.GET_NOTICELIST]: store => {
      http
        .get("/notice")
        .then(response =>
          store.commit(Constant.GET_NOTICELIST, { noticeItems: response.data.data })
        )
        .catch(exp => alert("공지사항 목록 처리에 실패하였습니다." + exp));
    },
    [Constant.REMOVE_NOTICE]: (store, payload) => {
      http
        .delete("/notice/" + payload.no)
        .then(() => {
          console.log("삭제 처리되었습니다.");
          store.dispatch(Constant.GET_NOTICELIST);
        })
        .catch(exp => alert("삭제 처리에 실패하였습니다." + exp));
    },
    [Constant.UPDATE_NOTICE]: (store, payload) => {
      http
        .put("/notice/" + payload.notice.no, {
          no: payload.notice.no,
          id: payload.notice.id,
          title: payload.notice.title,
          contents: payload.notice.contents,
          regdate: payload.notice.regdate,
        })
        .then(() => {
          console.log("공지사항을 수정했습니다.");
          store.dispatch(Constant.GET_NOTICELIST);
        })
        .catch(exp => alert("공지사항 수정 처리에 실패하였습니다." + exp));
    },
    [Constant.ADD_NOTICE]: (store, payload) => {
      http
        .post("/noticeinsert", {
          id: payload.notice.id,
          title: payload.notice.title,
          contents: payload.notice.contents,
          regdate: payload.notice.regdate,
        })
        .then(() => {
          console.log("추가하였습니다.");
          store.dispatch(Constant.GET_NOTICELIST);
        })
        .catch(() => console.log("추가에 실패하였습니다."));
    },
    [Constant.GET_NOTICE]: (store, payload) => {
      http
        .get("/notice/" + payload.no)
        .then(response => {
          store.commit(Constant.GET_NOTICE, { notice: response.data.data });
        })
        .catch(exp => alert("글 조회에 실패하였습니다." + exp));
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
    [Constant.GET_NOTICELIST]: (state, payload) => {
      state.noticeItems = payload.noticeItems;
    },
    [Constant.GET_NOTICE]: (state, payload) => {
      state.notice = payload.notice;
    },
    [Constant.GET_LOGINSTATUS]: (state, payload) => {
      state.loginStatus = payload.loginStatus;
    }
  }
});

export default store;
