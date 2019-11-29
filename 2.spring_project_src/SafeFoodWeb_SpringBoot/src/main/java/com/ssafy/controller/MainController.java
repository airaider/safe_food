package com.ssafy.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.ssafy.model.dto.EatInfo;
import com.ssafy.model.dto.Food;
import com.ssafy.model.dto.FoodPageBean;
import com.ssafy.model.dto.Member;
import com.ssafy.model.dto.Steam;
import com.ssafy.model.service.EatInfoService;
import com.ssafy.model.service.FoodService;
import com.ssafy.model.service.MemberService;
import com.ssafy.model.service.SteamService;

@CrossOrigin(origins = {"*"}, maxAge = 6000)
@Controller
public class MainController {
	@Autowired
	private FoodService foodService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private EatInfoService eatinfoService;
	@Autowired
	private SteamService steamService;

	@ExceptionHandler
	public ModelAndView handler(Exception e) {
		ModelAndView mav = new ModelAndView("ErrorHandler");
		return mav.addObject("msg", e.getMessage());
	}

	@RequestMapping(value = { "/", "main.do" })
	private String mainLoad(Model model, HttpSession session) {
		try {
			FoodPageBean bean = new FoodPageBean("all", null, 1);
			List<Food> list = foodService.searchAll(bean);
			model.addAttribute("list", foodService.searchAll(bean));
			session.setAttribute("list", foodService.searchAll(bean));
			session.setAttribute("isAllergyList", isAllergyList(list, session));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "main";
	}

	// list에 있는 food가 현재 로그인 된 유저의 알러지에 포함되어 있는지
	// 알레르기 포함 식품 icon 띄우기 위한 것
	private List<Boolean> isAllergyList(List<Food> list, HttpSession session) {
		List<Boolean> isAllergy = new ArrayList();
		String id = (String) session.getAttribute("id");
		if(id == null) return isAllergy;
		Member member = memberService.search(id); // member 정보 받아옴 (allergy 알기 위해서)
		String[] memberAllergy = member.getAllergy().split(",");
		
		// 먹은 food 알러지마다 +1 해주기
		for (Food food : list) {
			String foodAller = food.getAllergy();
			Boolean check = false;
			for (String aller : memberAllergy) {
				if(foodAller.contains(aller)) {
					check = true;
					break;
				}
			}
			isAllergy.add(check);
		}
		return isAllergy;
	}

	@PostMapping("login.do")
	private String login(String id, String password, HttpSession session) {
		try {
			boolean result = memberService.login(id, password);
			if (result) {
				System.out.println("sessionId : " + session.getId());
				session.setAttribute("id", id);
			}
			return "redirect:main.do";
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("loginMsg", e.getMessage());
			return "main";
		}
	}

	@GetMapping("logout.do")
	private String logout(HttpSession session) {
		session.invalidate();
		return "redirect:main.do";
	}

	@PostMapping("signUp.do")
	private String signUp(Model model, Member member, String passwordCheck) {
		try {
			// 비밀번호와 비밀번호확인이랑 서로 일치하지 않을때
			if (!(member.getPassword().equals(passwordCheck))) {
				model.addAttribute("msg", "비밀번호가 서로 일치하지 않습니다.");
				return "signup";
			}
			// 아이디, 이름, 휴대폰번호 양식에 맞춰 썼는지 확인
			memberService.CheckValue(member);
			memberService.add(member);
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", e.getMessage());
			return "signup";
		}
		return "redirect:main.do";
	}

	@GetMapping("myInfo.do")
	private String myInfo(HttpSession session, Model model) {
		String sessionId = session.getId();
		System.out.println("sessionId : " + sessionId);
		String id = (String) session.getAttribute("id");
		model.addAttribute("member", memberService.search(id));
		return "myInfo";
	}

	@PostMapping("memberUpdateForm.do")
	private String updateMemberForm(HttpSession session, Model model) {
		String id = (String) session.getAttribute("id");
		model.addAttribute("member", memberService.search(id));
		return "edit";
	}

	@PostMapping("updateMember.do")
	private String updateMember(Model model, Member member, String passwordCheck) {
		try {
			System.out.println(member.toString());
			// 비밀번호와 비밀번호확인이랑 서로 일치하지 않을때
			if (!(member.getPassword().equals(passwordCheck))) {
				model.addAttribute("msg", "비밀번호가 서로 일치하지 않습니다.");
				return "edit";
			}
			// 아이디, 이름, 휴대폰번호 양식에 맞춰 썼는지 확인
			memberService.CheckValue(member);
			memberService.update(member);
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", e.getMessage());
			return "edit";
		}
		return "myInfo";
	}

	@GetMapping("delete.do")
	private String delete(HttpSession session) {
		String id = (String) session.getAttribute("id");
		memberService.delete(id);
		session.invalidate();
		return "redirect:main.do";
	}

	@GetMapping("detailInfo.do")
	private String detailInfo(String code, Model model) {
		Food f = foodService.search(code);
		model.addAttribute("food", f);
		return "detailInfo";
	}
	
	@GetMapping("searchMain.do")
	private String searchMain(String key, String word, String pageNo, Model model, HttpSession session) {
		System.out.println(key + " " + word + " " + pageNo);
		System.out.println("??");
		FoodPageBean bean = new FoodPageBean(key, word, Integer.parseInt(pageNo));
		List<Food> list = foodService.searchAll(bean);
		model.addAttribute("bean", bean);
		model.addAttribute("list", list);
		session.setAttribute("list", list);
		return "main";
	}

	@GetMapping("searchFood.do")
	private String searchFood(String key, String word, String pageNo, Model model, HttpSession session) {
		System.out.println(key + " " + word + " " + pageNo);
		System.out.println("!!");
		FoodPageBean bean = new FoodPageBean(key, word, Integer.parseInt(pageNo));
		List<Food> list = foodService.searchAll(bean);
		model.addAttribute("bean", bean);
		model.addAttribute("list", list);
		session.setAttribute("list", list);
		return "foodlist";
	}

	@PostMapping("Findpassword.do")
	private String Findpassword(String id, String name, String phoneNumber, Model model) {
		try {
			Member m = memberService.search(id);
			if (m.getName().equals(name) && m.getPhone().equals(phoneNumber)) {
				model.addAttribute("member", m);
			}
			System.out.println("password....." + m.getPassword());
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", e.getMessage());
		}
		return "Findpassword";
	} // 수정해야함 .... 나오는데 화면에 안떠ㅡㅡ

	@GetMapping("foodList.do")
	private String foodList(Model model) {
		try {
			FoodPageBean bean = new FoodPageBean("all", null, 1);
			model.addAttribute("list", foodService.searchAll(bean));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "foodlist";
	}
	
	@GetMapping("sortMain.do") // 됨!!
	private String sortMain(String tmp, Model model, HttpSession session) {
		List<Food> list = (List<Food>) session.getAttribute("list");
		Collections.sort(list, new Comparator<Food>() {
			@Override
			public int compare(Food o1, Food o2) {
				int order = 1;
				if (tmp.equals("descend"))
					order = -1;
				return o1.getName().compareTo(o2.getName()) * order;

			}
		});
		model.addAttribute("list", list);
		session.setAttribute("list", list);
		return "main";
	}

	@PostMapping("sortFood.do")
	private String sortFood(String tmp, Model model, HttpSession session) {
		List<Food> list = (List<Food>) session.getAttribute("list");
		Collections.sort(list, new Comparator<Food>() {
			@Override
			public int compare(Food o1, Food o2) {
				int order = 1;
				if (tmp.equals("descend"))
					order = -1;
				return o1.getName().compareTo(o2.getName()) * order;

			}
		});
		model.addAttribute("list", list);
		session.setAttribute("list", list);
		return "foodlist.jsp";
	}

	@GetMapping("foodadd.do")
	private String foodAdd(String code, String eat_cnt, HttpSession session) {
		String id = (String) session.getAttribute("id");
		System.out.println("id" + id + "cnt" + eat_cnt + "code" + code);
		if (id != null) {
			if (eat_cnt != null && code != null) {
				eatinfoService.add(new EatInfo(id, code, Integer.parseInt(eat_cnt), ""));
				System.out.println("add food!!!");
			}
			getFood(session);
		}
		return "foodadd";
	}
	
	@GetMapping("steam.do")
	private String steam(String code, String eat_cnt, HttpSession session) {
		System.out.println("steam");
		String id = (String) session.getAttribute("id");
		System.out.println("id"+id+"cnt"+eat_cnt+"code"+code);
		if(id!=null) {
			if(eat_cnt!=null && code!=null) {
				steamService.add(new Steam(id, code, Integer.parseInt(eat_cnt), ""));
			}
			List<Steam> info = steamService.searchSteamList(id);
			HashMap<String, Integer> steam = new HashMap<>();
			for (Steam s : info) {
				if(steam.containsKey(s.getCode())) {
					steam.put(s.getCode(), steam.get(s.getCode())+s.getCnt());
				}else {
					steam.put(s.getCode(), s.getCnt());
				}
			}
			List<Food> slist = new ArrayList<>();
			List<Integer> scnt = new ArrayList<>();
			for(String aa : steam.keySet()) {
				slist.add(foodService.search(aa));
				scnt.add(steam.get(aa));
			}
			session.setAttribute("slist", slist);
			session.setAttribute("scnt", scnt);
		}
		return "steam";
	}

	private void getFood(HttpSession session) {
		String id = (String) session.getAttribute("id");
		if (id != null) {
			List<EatInfo> info = eatinfoService.searchEatList(id); // 먹은 정보들 받아옴
			HashMap<String, Integer> eatlist = new HashMap<>();
			// List마다 음식끼리 합쳐주기
			for (EatInfo eatInfo : info) {
				if (eatlist.containsKey(eatInfo.getCode())) {
					eatlist.put(eatInfo.getCode(), eatlist.get(eatInfo.getCode()) + eatInfo.getCnt());
				} else {
					eatlist.put(eatInfo.getCode(), eatInfo.getCnt());
				}
			}
			List<Food> list2 = new ArrayList<>();
			List<Integer> cnt2 = new ArrayList<>();
			for (String aa : eatlist.keySet()) {
				list2.add(foodService.search(aa));
				cnt2.add(eatlist.get(aa));
			}
			session.setAttribute("list2", list2);
			session.setAttribute("cnt2", cnt2);
		}
	}
	
	// foodadd에서 먹은 알러지 정보 받아오는 method
	@GetMapping("getAllergyInfo.do")
	@ResponseBody
	private String getAllergyInfo(HttpSession session) {
		String id = (String) session.getAttribute("id");
		List<Food> list = (List) session.getAttribute("list2");
		List<Integer> cnt = (List) session.getAttribute("cnt2");
		Member member = memberService.search(id); // member 정보 받아옴 (allergy 알기 위해서)
		HashMap<String, Integer> eatAllergyList = new HashMap<>();
		String[] memberAllergy = member.getAllergy().split(","); // 우유 게
		for (String allergy : memberAllergy) {
			eatAllergyList.put(allergy, 0); // member의 알러지 map에 다 넣어줌
		}
		// 먹은 food 알러지마다 +1 해주기
		int index = -1;
		for (Food food : list) {
			index++;
			if(food.getAllergy().equals("")) continue;
			String[] foodAllergy = food.getAllergy().split("\\s"); // 우유 게 땅콩
			String memberAllergyString = member.getAllergy();
			// 지금 food 먹은 갯수
			int cntFood = cnt.get(index);
			for (String allergy : foodAllergy) {
				if(memberAllergyString.contains(allergy)) {
					eatAllergyList.put(allergy, eatAllergyList.get(allergy) + (1 * cntFood));
				}
			}
		}
		// 그래프
		Gson gson = new Gson();
		System.out.println(gson.toJson(eatAllergyList));
		return gson.toJson(eatAllergyList);
	}

	@GetMapping("detail.do")
	@ResponseBody
	private String detail(String code) {
		Food f = foodService.search(code);
		Gson gson = new Gson();
		System.out.println(gson.toJson(f));
		return gson.toJson(f);
	}

	@GetMapping("bestList.do")
	private String bestList(HttpSession session) {
		Best(session);
		return "best";
	}

	private void Best(HttpSession session) {
		String id = (String) session.getAttribute("id");
		List<EatInfo> info = eatinfoService.searchEatList(id);
		Map<String, Integer> eatlist = new HashMap<>();
		// List마다 음식끼리 합쳐주기
		for (EatInfo eatInfo : info) {
			if (eatlist.containsKey(eatInfo.getCode())) {
				eatlist.put(eatInfo.getCode(), eatlist.get(eatInfo.getCode()) + eatInfo.getCnt());
			} else {
				eatlist.put(eatInfo.getCode(), eatInfo.getCnt());
			}
		}
		Iterator it = sortByValue(eatlist).iterator();
		List<Food> list2 = new ArrayList<>();
		List<Integer> cnt2 = new ArrayList<>();
		int i=0;
		while(it.hasNext()) {
			if(i++>4) break;
			String temp = (String) it.next();
			list2.add(foodService.search(temp));
			cnt2.add(eatlist.get(temp));
		}
		session.setAttribute("blist", list2);
		session.setAttribute("bcnt", cnt2);
	}

	public static List sortByValue(final Map map) {
		List<String> list = new ArrayList();
		list.addAll(map.keySet());
		Collections.sort(list,new Comparator() {
			public int compare(Object o1,Object o2) {
					Object v1 = map.get(o1);
					Object v2 = map.get(o2);
					return ((Comparable) v2).compareTo(v1);
			}
		});
		return list;
	}

	@GetMapping("bb.do")
	@ResponseBody
	private String bb(HttpSession session) {
		List<Food> list = (List<Food>) session.getAttribute("blist");
		List<Integer> cnt2 = (List<Integer>) session.getAttribute("bcnt");
		HashMap<String, Integer> top = new HashMap<>();
		int i = 0;
		for (Food ss : list) {
			top.put(ss.getName(), cnt2.get(i++));
		}
		Gson gson = new Gson();
		System.out.println(gson.toJson(top));
		return gson.toJson(top);
	}
	
	@GetMapping("pp.do")
	@ResponseBody
	private String pp(HttpSession session) {
		List<EatInfo> list = eatinfoService.searchEatList((String)session.getAttribute("id"));
		Calendar cal = Calendar.getInstance();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		cal.add(Calendar.DATE, 0);
		String now = dateFormat.format(cal.getTime());
		cal.add(Calendar.DATE, -1);
		String yes = dateFormat.format(cal.getTime());
		cal.add(Calendar.DATE, -1);
		String yess = dateFormat.format(cal.getTime());
		int kal=0, car=0, pro=0, fat=0, sugar=0, nat=0, kol=0, fatacid=0, trans=0;
		int kal1=0, car1=0, pro1=0, fat1=0, sugar1=0, nat1=0, kol1=0, fatacid1=0, trans1=0;
		int kal2=0, car2=0, pro2=0, fat2=0, sugar2=0, nat2=0, kol2=0, fatacid2=0, trans2=0;
		for (EatInfo eatInfo : list) {
			String date = eatInfo.getDate();
			Food food = foodService.search(eatInfo.getCode());
			if(date.equals(now)) {
				int cnt = eatInfo.getCnt();
				kal+=food.getCalory()*cnt;
				car+=food.getCarbo()*cnt;
				pro+=food.getProtein()*cnt;
				fat+=food.getFat()*cnt;
				sugar+=food.getSugar()*cnt;
				nat+=food.getNatrium()*cnt;
				kol+=food.getChole()*cnt;
				fatacid+=food.getFattyacid()*cnt;
				trans+=food.getTransfat()*cnt;
			}
			else if(date.equals(yes)) {
				int cnt = eatInfo.getCnt();
				kal1+=food.getCalory()*cnt;
				car1+=food.getCarbo()*cnt;
				pro1+=food.getProtein()*cnt;
				fat1+=food.getFat()*cnt;
				sugar1+=food.getSugar()*cnt;
				nat1+=food.getNatrium()*cnt;
				kol1+=food.getChole()*cnt;
				fatacid1+=food.getFattyacid()*cnt;
				trans1+=food.getTransfat()*cnt;
			}
			else if(date.equals(yess)) {
				int cnt = eatInfo.getCnt();
				kal2+=food.getCalory()*cnt;
				car2+=food.getCarbo()*cnt;
				pro2+=food.getProtein()*cnt;
				fat2+=food.getFat()*cnt;
				sugar2+=food.getSugar()*cnt;
				nat2+=food.getNatrium()*cnt;
				kol2+=food.getChole()*cnt;
				fatacid2+=food.getFattyacid()*cnt;
				trans2+=food.getTransfat()*cnt;
			}
		}
		HashMap<String, HashMap<String, Integer>> info = new HashMap<>();
		HashMap<String, Integer> info1 = new HashMap<>();
		info1.put("kal", kal);
		info1.put("car", car);
		info1.put("pro", pro);
		info1.put("fat", fat);
		info1.put("sugar", sugar);
		info1.put("nat", nat);
		info1.put("kol", kol);
		info1.put("fatacid", fatacid);
		info1.put("trans", trans);
		info.put(now, info1);
		HashMap<String, Integer> info2 = new HashMap<>();
		info2.put("kal", kal1);
		info2.put("car", car1);
		info2.put("pro", pro1);
		info2.put("fat", fat1);
		info2.put("sugar", sugar1);
		info2.put("nat", nat1);
		info2.put("kol", kol1);
		info2.put("fatacid", fatacid1);
		info2.put("trans", trans1);
		info.put(yes, info2);
		HashMap<String, Integer> info3 = new HashMap<>();
		info3.put("kal", kal2);
		info3.put("car", car2);
		info3.put("pro", pro2);
		info3.put("fat", fat2);
		info3.put("sugar", sugar2);
		info3.put("nat", nat2);
		info3.put("kol", kol2);
		info3.put("fatacid", fatacid2);
		info3.put("trans", trans2);
		info.put(yess, info3);
		Gson gson = new Gson();
		System.out.println(gson.toJson(info));
		return gson.toJson(info);
	}
	
	// login.do
	@GetMapping("getLoginInfo.do")
	@ResponseBody
	public Map getLoginInfo(HttpSession session) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		String id = (String) session.getAttribute("id");
		if (id != null) {
			map.put("status", true);
			map.put("id", id);
		} else {
			map.put("status", false);
		}
		System.out.println(map);
		return map;
	}
	
	@GetMapping("eatsteam.do")
	public String eatsteam(HttpSession session, String cnt, String code) {
		System.out.println(cnt);
		System.out.println(code);
		foodAdd(code, cnt, session);
		System.out.println("check");
		String id = (String) session.getAttribute("id");
		System.out.println("steam");
		if(id!=null) {
			List<Steam> info = steamService.searchSteamList(id);
			for (Steam s : info) {
				if(s.getCode().equals(code)) {
					System.out.println(s.getNo());
					steamService.remove(s.getNo());
				}
			}
		}
		return "redirect:foodadd.do";
	}
	
	@GetMapping("deletesteam.do")
	public String deletesteam(HttpSession session, String code) {
		String id = (String) session.getAttribute("id");
		if(id!=null) {
			List<Steam> info = steamService.searchSteamList(id);
			for (Steam s : info) {
				if(s.getCode().equals(code)) {
					System.out.println(s.getNo());
					steamService.remove(s.getNo());
				}
			}
		}
		return "redirect:steam.do";
	}
	
	@GetMapping("world.do")
	public String world(HttpSession session) {
		List<Food> list = (List<Food>) session.getAttribute("list");
		HashMap<Food, String> nara = (HashMap<Food, String>) session.getAttribute("nara");
		if(nara==null) {
			nara = new HashMap<>();
			for (Food food : list) {
				String guk="";
				Set<String> gg = new HashSet<>();
				for (String re : findBracketTextByPattern(food.getMaterial())) {
					for (String find : nations) {
						if(re.contains(find)) gg.add(find);
					}
				}
				for (String f : gg) {
					guk+=f+"산, ";
				}
				if(guk.length()>0) {
					guk=guk.substring(0, guk.length()-2);
				}
				nara.put(food, guk);
			}
			session.setAttribute("nara", nara);
		}
		return "world";
	}
	
	private static List<String> findBracketTextByPattern(String text){
		ArrayList<String> bracketTextList = new ArrayList<String>();
		Pattern PATTERN_BRACKET = Pattern.compile("\\([^\\(\\)]+\\)");
		String VOID = "";
        Matcher matcher = PATTERN_BRACKET.matcher(text);
        String pureText = text;
        String findText = new String();
        while(matcher.find()) {
            int startIndex = matcher.start();
            int endIndex = matcher.end();
            findText = pureText.substring(startIndex, endIndex);
            pureText = pureText.replace(findText, VOID);
            matcher = PATTERN_BRACKET.matcher(pureText);
            System.out.println(findText);
            bracketTextList.add(findText);
        }
        return bracketTextList;
    }
	
	String[] nations = {"가나","가봉","가이아나","감비아","과테말라","그레나다","그리스","기니","기니비사우",//ㄱ
			"나미비아","나우루","나이지리아","남수단","남아프리카","네덜란드","네팔","노르웨이","뉴질랜드","니제르","니카라과","남오세티야",//ㄴ
			"대만","덴마크","도미니카","독일","동티모르",//ㄷ
			"라오스","라이베리아","라트비아","러시아","레바논","레소토","루마니아","룩셈부르크","르완다","리비아","리투아니아","리히텐슈타인",//ㄹ
			"마다가스카르","마셜","말라위","말레이시아","말리","멕시코","모나코","모로코","모리셔스","모리타니","모잠비크","몬테네그로","몰도바","몰디브","몰타","몽골","미국","미얀마","미크로네시아",//ㅁ
			"바누아투","바레인","바베이도스","바티칸","바하마","방글라데시","베냉","베네수엘라","베트남","벨기에","벨라루스","벨리즈","벨라루스","벨리즈","보스니아","보츠와나","볼리비아","부룬디","부르키나파소","부탄","북마케도니아","북키프로스","불가리아","브라질","브루나이",//ㅂ
			"사모아","사우디아라비아","사하라 아랍 민주 공화국","산마리노","상투메 프린시페","세네갈","세르비아","세이셸","세인트루시아","소말리아","수단","스리랑카","스웨덴","스위스","스페인","슬로바키아","슬로베니아","시리아","싱가포르",//ㅅ
			"아랍에미리트","아르헨티나","아이슬란드","아이티","아일랜드","아프가니스탄","알바니아","에스토니아","에콰도르","에티오피아","영국","예멘","오만","오스트레일리아","오스트리아","온두라스","요르단","우간다","우루과이","우즈베키스탄","우크라이나","이라크","이란","이스라엘","이집트","이탈리아","인도","인도네시아","일본",//ㅇ
			"중국","자메이카","잠비아","북한","짐바브웨",//ㅈ
			"체코","칠레",//ㅊ
			"카메룬","카타르","캄보디아","캐나다","콜롬비아","콩고","쿠바","쿠웨이트","크로아티아",//ㅋ
			"타이완","타지키스탄","탄자니아","태국","터키","토고","튀니지",//ㅌ
			"파나마","파라과이","파키스탄","파푸아뉴기니","페루","포르투칼","폴란드","프랑스","피지","핀란드","필리핀",//ㅍ
			"헝가리","호주","홍콩",//ㅎ
			"외국","수입"//번외
			};
	
	String[][] ff = {
			{"신라면큰사발", "진라면컵매운맛", "큰컵삼양라면", "새우탕큰사발", "육개장큰사발면"},
			{"메로나", "누크바", "비비빅", "수박바", "죠스바"},
			{"서울우유바나나", "맛있는우유GT"},
			{"칠성사이다", "비타500칼슘", "비타파워"},
			{"칸타타아메리카노", "칸타타프리미엄라떼", "맥심티오피스위트아메리카노", "맥심티오피마스터라떼", "아카페라아메리카노"}
	};
	
	@GetMapping("map.do")
	private String map (HttpSession session, Model model) {
		List<Food> top = (List<Food>)session.getAttribute("blist");
		if(top==null) {
			Best(session);
			top = (List<Food>)session.getAttribute("blist");
		}
		String first = top.get(0).getName();
		int i=0;
		loop:
		for (i = 0; i < 5; i++) {
			for (int j = 0; j < ff[i].length; j++) {
				if(ff[i][j].contains(first)) {
					break loop;
				}
			}
		}
		String cat="";
		HashMap<Integer, String> pid = new HashMap<>();
		switch (i) {
		case 0:
			pid.put(0,"ChIJ5YpmeP6jfDURYlTDm9cQJN0");
			pid.put(1,"ChIJGW_o-VWhfDURlTMRvIGkDuI");
			pid.put(2,"ChIJtRzcaeCjfDURniEcjwd7QhE");
			cat="라면";
			break;
		case 1:
			pid.put(0,"ChIJbf56Of6jfDURpQRnsB_csSY");
			pid.put(1,"ChIJbaEHifijfDURP3ZxyJuJ2mE");
			pid.put(2,"ChIJL7a_RRCjfDURRQjz82U-Twg");
			cat = "빙수";
			break;
		case 2:
			pid.put(0,"ChIJxzbVLBFYezURd3qlBxoGGJs");
			pid.put(1,"ChIJqb2_sPijfDURrXLSyvA3oO");
			pid.put(2,"ChIJ01chzP2jfDURfc_wp-aJxtA");
			cat="빵집";
			break;
		case 3:
			pid.put(0,"ChIJI8pUMv-jfDURkrMlrqcoINQ");
			pid.put(1,"ChIJ04kx3P6jfDUREQ5yPh3VzJ8");
			pid.put(2,"ChIJ_3HpmgCkfDUR9ntcIy5mYxg");
			cat = "편의점";
			break;
		case 4:
			pid.put(0,"ChIJw7X-Q_-jfDURyRnNi9ddt3A");
			pid.put(1,"ChIJE5qKiFWhfDURGj3o-vJ5XlU");
			pid.put(2,"ChIJ769iKfyjfDURyaWau3yF4VM");
			cat="커피";
			break;
		}
		Gson gson = new Gson();
		session.setAttribute("pid", gson.toJson(pid));
		session.setAttribute("cat", cat);
		return "map";
	}
	
	@GetMapping("top.do")
	@ResponseBody
	private String top (HttpSession session) {
		List<EatInfo> list = eatinfoService.searchAll();
		Map<String, Integer> eatlist = new HashMap<>();
		// List마다 음식끼리 합쳐주기
		for (EatInfo eatInfo : list) {
			if (eatlist.containsKey(eatInfo.getCode())) {
				eatlist.put(eatInfo.getCode(), eatlist.get(eatInfo.getCode()) + eatInfo.getCnt());
			} else {
				eatlist.put(eatInfo.getCode(), eatInfo.getCnt());
			}
		}
		Iterator it = sortByValue(eatlist).iterator();
		HashMap<String, Integer> t = new HashMap<>();
		int i=0;
		while(it.hasNext()) {
			if(i++>4) break;
			String temp = (String) it.next();
			t.put(foodService.search(temp).getName(), eatlist.get(temp));
		}
		session.setAttribute("top", t);
		Gson gson = new Gson();
		return gson.toJson(t);
	}
	
	/*
	 * @PostMapping("deatil.do") private String detail(HttpServletRequest request,
	 * HttpServletResponse response) { String code = request.getParameter("code");
	 * Food f = foodService.search(Integer.parseInt(code)); Gson gson = new Gson();
	 * =======
	 * 
	 * /*
	 * 
	 * @PostMapping("deatil.do") private String detail(HttpServletRequest request,
	 * HttpServletResponse response) { String code = request.getParameter("code");
	 * Food f = foodService.search(Integer.parseInt(code)); Gson gson = new Gson();
	 * 
	 * return gson.toJson(f);
	 * 
	 * }
	 * 
	 * 
	 * 
	 * @PostMapping("sortFood.do") private String sortFood(HttpServletRequest
	 * request, HttpServletResponse response) { String tmp =
	 * request.getParameter("tmp"); List<Food> list = (List<Food>)
	 * request.getSession().getAttribute("list"); Collections.sort(list, new
	 * Comparator<Food>() {
	 * 
	 * @Override public int compare(Food o1, Food o2) { int order = 1; if
	 * (tmp.equals("descend")) order = -1; return
	 * o1.getName().compareTo(o2.getName()) * order;
	 * 
	 * } }); request.setAttribute("list", list);
	 * 
	 * return "foodlist.jsp"; }
	 * 
	 * @PostMapping("sortBest.do") private String sortBest(HttpServletRequest
	 * request, HttpServletResponse response) { String tmp =
	 * request.getParameter("tmp"); List<Food> list = (List<Food>)
	 * request.getSession().getAttribute("blist"); Collections.sort(list, new
	 * Comparator<Food>() {
	 * 
	 * @Override public int compare(Food o1, Food o2) { int order = 1; if
	 * (tmp.equals("descend")) order = -1; return
	 * o1.getName().compareTo(o2.getName()) * order;
	 * 
	 * } }); request.setAttribute("list", list);
	 * 
	 * return "best.jsp"; }
	 * 
	 * @PostMapping("bestList.do") private String bestList(HttpServletRequest
	 * request, HttpServletResponse response) { String key =
	 * request.getParameter("key"); // 검색 조건 if (key == null) key = "all"; String
	 * word = request.getParameter("word"); // 검색할 단어 String page =
	 * request.getParameter("pageNo"); int pageNo = page == null ? 1 :
	 * Integer.parseInt(page); // 현재 페이지 번호 FoodPageBean bean = new
	 * FoodPageBean(key, word, pageNo);
	 * 
	 * request.setAttribute("bean", bean);
	 * 
	 * String id = (String) request.getSession().getAttribute("id");
	 * System.out.println(id); if (id != null) { Member member =
	 * memberService.search(id); String allergy = member.getAllergy(); String[]
	 * member_allergy = allergy.split(","); List<Food> list =
	 * foodService.searchAll(bean); List<Food> bestList = new ArrayList<>();
	 * 
	 * // System.out.println(list); if (member_allergy != null) { start: for (int i
	 * = 0; i < list.size(); i++) { String materials = list.get(i).getMaterial();
	 * materials = materials.concat(list.get(i).getName()); for (int j = 0; j <
	 * member_allergy.length; j++) { if (KMP(materials, member_allergy[j])) {
	 * continue start; } } bestList.add(list.get(i)); } // 다 담음
	 * request.getSession().setAttribute("blist", bestList); } return "best.jsp"; }
	 * 
	 * return "best.jsp"; }
	 * 
	 * 
	 * public static boolean KMP(String name, String keyword) { boolean result =
	 * false; char[] T = name.toCharArray(); char[] P = keyword.toCharArray();
	 * 
	 * int tLength = T.length, pLength = P.length; int[] fail = new int[pLength];
	 * 
	 * // 실패 함수 만들기: P에서 P를 찾는 형태로... // 해당 부분문자열의 최대접미사의 길이 for (int i = 1, j = 0;
	 * i < pLength; i++) { // i: 접미사포인터, j: 접두사포인터 // j 위치에서 틀리면 j-1 위치까지는 맞았다는 이야기
	 * // fai[j-1]: j-1 위치까지 일치하는 접미사의 길이 ==> 이동해야하는 다음 비교 j 위치 while (j > 0 && P[i]
	 * != P[j]) j = fail[j - 1];
	 * 
	 * if (P[i] == P[j]) fail[i] = ++j; }
	 * 
	 * int cnt = 0; // i: 텍스트포인터, j: 패턴포인터 // i는 계속 증가하는 형태 for (int i = 0, j = 0; i
	 * < tLength; i++) { while (j > 0 && T[i] != P[j]) j = fail[j - 1];
	 * 
	 * if (T[i] == P[j]) { if (j == pLength - 1) { // 패턴의 끝까지 일치 cnt++; j = fail[j];
	 * // 주의!!!!! 끝까지 일치했다는 것은 j까지 맞았다는 의미이므로 => j-1아니고 j임에 주의!!! } else { j++; } }
	 * if (cnt > 0) { result = true; break; } } return result; }
	 */
}
