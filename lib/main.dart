import 'package:flutter/material.dart';
import 'package:flutter_2501045/screens/book_screen.dart';
import 'package:flutter_2501045/screens/exhibition_screen.dart';
import 'package:flutter_2501045/screens/performance_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'home_page.dart';
import 'search_page.dart';
import 'favorites_page.dart';
import 'profile_page.dart';
import 'login_page.dart';
import 'screens/movie_screen.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 제미나이: FutureBuilder를 이용하여 SharedPreferences에서 'user_email'을 비동기로 불러와, 로그인이 되어 있으면 MainNavigation을 아니면 LoginPage를 보여주는 조건부 렌더링을 수행
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<String?>(
        future: _checkLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasData && snapshot.data != null) {
            return const MainNavigation();
          }
          return const LoginPage();
        },
      ),
    );
  }

  Future<String?> _checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email');
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> favoriteList = [];

  List<Widget> _pages = [
    HomePage(
      onBackToHome: () {},
      favoriteList: [],
      onToggleFavorite: (Map<String, dynamic> p1) {},
    ), // 0: 홈 화면
    BookScreen(), // 1: 도서 화면
    MovieListScreen(), // 2: 영화 화면
    ExhibitionScreen(), // 3: 전시회 화면
    PerformanceScreen(), // 4: 공연 화면
  ];

  // 제미나이: 즐겨찾기 리스트 상태 변경 시 페이지를 실시간으로 업데이트하는 콜백 로직 구현
  void _toggleFavorite(Map<String, dynamic> item) {
    setState(() {
      if (favoriteList.contains(item)) {
        favoriteList.remove(item);
      } else {
        favoriteList.add(item);
      }
      _updatePages();
    });
  }

  @override
  void initState() {
    super.initState();
    _updatePages();
  }

  // 전체 데이터와 페이지 구조를 포함한 최종 함수
  // 제미나이: 콜백 함수(onBackToHome)를 통해 자식 페이지에서 부모의 상태를 변경하여 메인 화면(홈 탭)으로 전환하는 기능 구현
  void _updatePages() {
    _pages = [
      HomePage(
        onBackToHome: () => setState(() => _selectedIndex = 0),
        favoriteList: favoriteList,
        onToggleFavorite: _toggleFavorite,
      ),
      SearchPage(
        onBackToHome: () => setState(() => _selectedIndex = 0),
        // 제미나이: 에러 해결을 위한 콜백 함수 추가
        onMenuSelectedFromSearch: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        allData: const [
          // 홈페이지 카테고리별 리스트
          {
            "title": "세상에 나쁜 사춘기는 없다",
            "img": "assets/sesang.jpg",
            'category': '도서',
          },
          {"title": "반짝이는 안녕", "img": "assets/banjack.jpg", 'category': '도서'},
          {"title": "은둔하는 청년들", "img": "assets/eundun.jpg", 'category': '도서'},
          {"title": "말하지 않고 말하기", "img": "assets/mal.jpg", 'category': '도서'},
          {
            "title": "나의 첫 번째 부동산 교과서",
            "img": "assets/na.jpg",
            'category': '도서',
          },
          {"title": "감정 수업", "img": "assets/gamjung.jpg", 'category': '도서'},
          {
            "title": "품격있는 대화를 위한 지식 브리핑",
            "img": "assets/poom.jpg",
            'category': '도서',
          },
          {"title": "내면 근력", "img": "assets/nae.jpg", 'category': '도서'},
          {"title": "쓰는 사람", "img": "assets/sse.jpg", 'category': '도서'},
          {"title": "밤과 나침반", "img": "assets/bam.jpg", 'category': '도서'},
          {
            "title": "미루는 사람을 위한 실행 기술",
            "img": "assets/miru.jpg",
            'category': '도서',
          },
          {
            "title": "말투만 바꿨을 뿐인데(10만 부 기념 개정판)",
            "img": "assets/maltoo.jpg",
            'category': '도서',
          },
          {
            "title": "안전 척척박사의 똘똘한 자격증 하나 인생을 바꾼다",
            "img": "assets/anjun.jpg",
            'category': '도서',
          },
          {"title": "쪼개기 법칙", "img": "assets/jjo.jpg", 'category': '도서'},
          {
            "title": "생각만 바꿔도 인생이 바뀐다",
            "img": "assets/thingking.jpg",
            'category': '도서',
          },
          {"title": "보물전", "img": "assets/bomul.jpg", 'category': '도서'},
          {"title": "마음은 아직 수습입니다", "img": "assets/maem.jpg", 'category': '도서'},
          {
            "title": "돈 때문에 불안하다는 착각",
            "img": "assets/money.jpg",
            'category': '도서',
          },
          {
            "title": "척추는 습관을 기억한다",
            "img": "assets/chuck.jpg",
            'category': '도서',
          },
          {
            "title": "소니아의 지중해식 헬스 팩토리",
            "img": "assets/soney.jpg",
            'category': '도서',
          },
          {
            "title": "작전명 파도 폐교는 거절합니다",
            "img": "assets/jackjun.jpg",
            'category': '도서',
          },
          {"title": "우리들의 호수", "img": "assets/uri.jpg", 'category': '도서'},
          {"title": "사람의 마지막 직업", "img": "assets/saram.jpg", 'category': '도서'},
          {
            "title": "흔한남매 세계사 탐험대 6",
            "img": "assets/henhan.jpg",
            'category': '도서',
          },
          {"title": "군체", "img": "assets/gunche.jpg", 'category': '영화'},
          {"title": "와일드 씽", "img": "assets/while.jpg", 'category': '영화'},
          {"title": "백룸", "img": "assets/back.jpg", 'category': '영화'},
          {"title": "만달로리안과 그로구", "img": "assets/mandal.jpg", 'category': '영화'},
          {"title": "마이클", "img": "assets/maicle.jpg", 'category': '영화'},
          {
            "title": "플레이브 아시아 투어 앙코르 인 시네마",
            "img": "assets/play.jpg",
            'category': '영화',
          },
          {"title": "너바나 더 밴드", "img": "assets/nubana.jpg", 'category': '영화'},
          {"title": "상자 속의 양", "img": "assets/sangja.jpg", 'category': '영화'},
          {"title": "왕과 사는 남자", "img": "assets/king.jpg", 'category': '영화'},
          {
            "title": "이상한 과자 가게 전천당",
            "img": "assets/esanghan.jpg",
            'category': '영화',
          },
          {"title": "노트북", "img": "assets/notbook.jpg", 'category': '영화'},
          {"title": "디스클로저 데이", "img": "assets/dis.jpg", 'category': '영화'},
          {"title": "쏜애플 플레이 필름", "img": "assets/sson.jpg", 'category': '영화'},
          {"title": "싱 스트리트", "img": "assets/sing.jpg", 'category': '영화'},
          {"title": "현상수배", "img": "assets/hyeonsang.jpg", 'category': '영화'},
          {"title": "이반리 장만옥", "img": "leeban.jpg", 'category': '영화'},
          {"title": "울프 토템", "img": "assets/woolf.jpg", 'category': '영화'},
          {"title": "그림책이 살아있다!", "img": "assets/gerim.jpg", 'category': '전시회'},
          {"title": "오~ 감각미술관", "img": "assets/ooh.jpg", 'category': '전시회'},
          {
            "title": "한국근현대미술 | MMCA Collection",
            "img": "assets/hangook.jpg",
            'category': '전시회',
          },
          {
            "title": "워너 브롱크호스트: 온 세상이 캔버스",
            "img": "assets/woner.jpg",
            'category': '전시회',
          },
          {
            "title": "MMCA 해외 명작: 수련과 샹들리에",
            "img": "assets/MMCA.jpg",
            'category': '전시회',
          },
          {"title": "영원히 교차하는 춤", "img": "assets/yeong.jpg", 'category': '전시회'},
          {
            "title": "스펙트로신테시스 서울 Spectrosynthesis Seoul",
            "img": "assets/spec.jpg",
            'category': '전시회',
          },
          {"title": "최현준 개인전", "img": "assets/choi.jpg", 'category': '전시회'},
          {
            "title": "이승택: 조각의 바깥에서",
            "img": "assets/lee_s.jpg",
            'category': '전시회',
          },
          {
            "title": "베르디(VERDY)개인전 《아이 빌리브 인 미(I Believe in Me)》",
            "img": "assets/VERDY.jpg",
            'category': '전시회',
          },
          {
            "title": "난지미술창작스튜디오 20주년 기념전 《사랑의 기원》",
            "img": "assets/nanji.jpg",
            'category': '전시회',
          },
          {
            "title": "페르난도 보테로: 형태의 미학",
            "img": "assets/pere.jpg",
            'category': '전시회',
          },
          {
            "title": "유영국: 산은 내 안에 있다",
            "img": "assets/yoo.jpg",
            'category': '전시회',
          },
          {"title": "글짓, 쓰는 예술", "img": "assets/geljit.jpg", 'category': '전시회'},
          {
            "title": "2026 투어링 케이-아츠 《아마도, 모두 우리》",
            "img": "assets/tour.jpg",
            'category': '전시회',
          },
          {
            "title": "[2026 신진미술인 지원 프로그램] 신재은 개인전 《GAIA-피식의 서》",
            "img": "assets/sinjin.jpg",
            'category': '전시회',
          },
          {
            "title": "《권병준: 내 마음속에 너는》",
            "img": "assets/kwon.jpg",
            'category': '전시회',
          },
          {"title": "강채연 개인전", "img": "assets/kang.jpg", 'category': '전시회'},
          {"title": "양희아 개인전", "img": "assets/yang.jpg", 'category': '전시회'},
          {
            "title": "인사이드 더 플레이 : 군체",
            "img": "assets/inside.jpg",
            'category': '공연',
          },
          {"title": "기억의 날", "img": "assets/riuk.jpg", 'category': '공연'},
          {
            "title": "달수랑 정직이랑 바다아이",
            "img": "assets/dalsu.jpg",
            'category': '공연',
          },
          {"title": "서편제 - 서울", "img": "assets/seo.jpg", 'category': '공연'},
          {"title": "그날들", "img": "assets/renal.jpg", 'category': '공연'},
          {"title": "더 펜", "img": "assets/the.jpg", 'category': '공연'},
          {"title": "헤르츠클란", "img": "assets/haere.jpg", 'category': '공연'},
          {"title": "데스노트 - 대전", "img": "assets/desnote.jpg", 'category': '공연'},
          {"title": "디아길레프룸", "img": "assets/dia.jpg", 'category': '공연'},
          {
            "title": "마우스피스 : 연극열전10_여덟 번째 작품",
            "img": "assets/mouse.jpg",
            'category': '공연',
          },
          {
            "title": "렁스 : 연극열전10_아홉 번째 작품",
            "img": "assets/rungse.jpg",
            'category': '공연',
          },
          {"title": "피리 부는 사나이", "img": "assets/piri.jpg", 'category': '공연'},
          {
            "title": "소프라노 최정원 가장 아름다운 노래",
            "img": "assets/sofe.jpg",
            'category': '공연',
          },
          {"title": "박열", "img": "assets/bak.jpg", 'category': '공연'},
          {"title": "김종욱 찾기 - 아산", "img": "assets/kim.jpg", 'category': '공연'},
          {
            "title": "ARTINCLOUD 콘서트",
            "img": "assets/ARTINCLOUD.jpg",
            'category': '공연',
          },
          {"title": "고무동력기", "img": "assets/romoo.jpg", 'category': '공연'},
          {
            "title": "히로시마 메시지 - 부산",
            "img": "assets/hiro.jpg",
            'category': '공연',
          },
        ],
        favoriteList: favoriteList,
        onToggleFavorite: _toggleFavorite,
        userEmail: '',
      ),
      FavoriteScreen(
        key: ValueKey(favoriteList.length),
        favoriteList: favoriteList,
        onRemoveFavorite: (item) {
          setState(() {
            favoriteList.remove(item);
            _updatePages();
          });
        },
        onBackToHome: () => setState(() => _selectedIndex = 0),
      ),
      const ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          color: Colors.blueGrey[50],
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.blueGrey[50],
            elevation: 0,
            currentIndex: _selectedIndex,
            onTap: (int index) => setState(() => _selectedIndex = index),
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 35),
                label: "홈",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search, size: 35),
                label: "검색",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite, size: 35),
                label: "즐겨찾기",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 35),
                label: "프로필",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 제미나이: HttpOverrides이용하여 외부 서버에서 이미지를 가져올 때 SSL 인증서 문제로 에러가 나는 것을 방지
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
