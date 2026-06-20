import 'package:flutter/material.dart';
import 'package:flutter_2501045/custom_app_bar.dart';
import 'package:flutter_2501045/login_page.dart';
import 'package:flutter_2501045/screens/book_screen.dart';
import 'package:flutter_2501045/screens/exhibition_screen.dart';
import 'package:flutter_2501045/screens/movie_screen.dart';
import 'package:flutter_2501045/screens/performance_screen.dart';
import 'review_page.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onBackToHome;
  final List<Map<String, dynamic>> favoriteList;
  final Function(Map<String, dynamic>) onToggleFavorite;

  const HomePage({
    super.key,
    required this.onBackToHome,
    required this.favoriteList,
    required this.onToggleFavorite,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int _selectedMenuIndex = 0;
  final List<String> _menuItems = ['도서', '영화', '전시회', '공연'];
  final ScrollController _mdScrollController = ScrollController();
  final ScrollController _pubScrollController = ScrollController();
  final ScrollController _newScrollController = ScrollController();

  List<Map<String, dynamic>> favoriteList = [];

  @override
  void initState() {
    super.initState();
    favoriteList = List.from(widget.favoriteList);
  }

  // 제미나이: 상태 호이스팅을 통해 favoriteList를 관리하며, _toggleFavorite 콜백을 통해 상세 페이지에서의 즐겨찾기 변경 사항을 전체 앱 상태와 실시간 동기화
  void _toggleFavorite(Map<String, dynamic> bookData) {
    setState(() {
      bool exists = favoriteList.any((i) => i['title'] == bookData['title']);
      if (exists) {
        favoriteList.removeWhere((i) => i['title'] == bookData['title']);
      } else {
        favoriteList.add(bookData);
      }
    });
    widget.onToggleFavorite(bookData);
  }

  @override
  void dispose() {
    _mdScrollController.dispose();
    _pubScrollController.dispose();
    _newScrollController.dispose();
    super.dispose();
  }

  //제미나이: ScrollController를 활용하여 섹션별 가로 스크롤 버튼(좌우 화살표)을 구현
  void _scrollList(ScrollController controller, bool isLeft) {
    double targetOffset = isLeft
        ? controller.offset - 200
        : controller.offset + 200;
    if (targetOffset < 0) targetOffset = 0;
    if (targetOffset > controller.position.maxScrollExtent)
      // ignore: curly_braces_in_flow_control_structures
      targetOffset = controller.position.maxScrollExtent;
    controller.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // 제미나이: 카테고리(menuIndex)와 섹션(sessionType) 조합에 따라 해당하는 콘텐츠 목록을 동적으로 반환하는 데이터 관리 로직 구현
  List<Map<String, String>> _getBookData(int menuIndex, String sessionType) {
    if (menuIndex == 0) {
      if (sessionType == 'recommend') {
        return [
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
        ];
      } else if (sessionType == 'like') {
        return [
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
        ];
      } else {
        return [
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
        ];
      }
    } else if (menuIndex == 1) {
      if (sessionType == 'recommend') {
        return [
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
        ];
      } else if (sessionType == 'like') {
        return [
          {"title": "와일드 씽", "img": "assets/while.jpg", 'category': '영화'},
          {"title": "상자 속의 양", "img": "assets/sangja.jpg", 'category': '영화'},
          {"title": "왕과 사는 남자", "img": "assets/king.jpg", 'category': '영화'},
          {
            "title": "이상한 과자 가게 전천당",
            "img": "assets/esanghan.jpg",
            'category': '영화',
          },
          {"title": "노트북", "img": "assets/notbook.jpg", 'category': '영화'},
          {"title": "군체", "img": "assets/gunche.jpg", 'category': '영화'},
          {"title": "백룸", "img": "assets/back.jpg", 'category': '영화'},
        ];
      } else {
        return [
          {"title": "디스클로저 데이", "img": "assets/dis.jpg", 'category': '영화'},
          {"title": "쏜애플 플레이 필름", "img": "assets/sson.jpg", 'category': '영화'},
          {"title": "싱 스트리트", "img": "assets/sing.jpg", 'category': '영화'},
          {"title": "현상수배", "img": "assets/hyeonsang.jpg", 'category': '영화'},
          {"title": "이반리 장만옥", "img": "leeban.jpg", 'category': '영화'},
          {"title": "상자 속의 양", "img": "assets/sangja.jpg", 'category': '영화'},
          {"title": "울프 토템", "img": "assets/woolf.jpg", 'category': '영화'},
        ];
      }
    } else if (menuIndex == 2) {
      if (sessionType == 'recommend') {
        return [
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
        ];
      } else if (sessionType == 'like') {
        return [
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
        ];
      } else {
        return [
          {"title": "글짓, 쓰는 예술", "img": "assets/geljit.jpg", 'category': '전시회'},
          {
            "title": "페르난도 보테로: 형태의 미학",
            "img": "assets/pere.jpg",
            'category': '전시회',
          },
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
        ];
      }
    } else {
      if (sessionType == 'recommend') {
        return [
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
        ];
      } else if (sessionType == 'like') {
        return [
          {"title": "데스노트 - 대전", "img": "assets/desnote.jpg", 'category': '공연'},
          {"title": "디아길레프룸", "img": "assets/dia.jpg", 'category': '공연'},
          {"title": "더 펜", "img": "assets/the.jpg", 'category': '공연'},
          {
            "title": "인사이드 더 플레이 : 군체",
            "img": "assets/inside.jpg",
            'category': '공연',
          },
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
          {"title": "헤르츠클란", "img": "assets/haere.jpg", 'category': '공연'},
        ];
      } else {
        return [
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
        ];
      }
    }
  }

  Widget _buildBookItem(Map<String, String> data) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReviewPage(
                bookData: data,
                isFavorite: favoriteList.any(
                  (i) => i['title'] == data['title'],
                ),
                onAddFavorite: (item) {
                  _toggleFavorite(item);
                },
              ),
            ),
          );
        },
        child: Container(
          width: 120,
          margin: const EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                height: 160,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(data['img'] ?? '', fit: BoxFit.cover),
                ),
              ),
              Text(
                data['title'] ?? '',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  height: 2.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: unused_element
  Widget _buildMainHomeScreen() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const Text(
                      "오늘의 선택",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 30),
                    Row(
                      children: List.generate(_menuItems.length, (index) {
                        bool isSelected = _selectedMenuIndex == index;
                        return Row(
                          children: [
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () =>
                                    setState(() => _selectedMenuIndex = index),
                                child: Text(
                                  _menuItems[index],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: isSelected
                                        ? const Color.fromARGB(255, 0, 93, 167)
                                        : Colors.blueGrey[400],
                                  ),
                                ),
                              ),
                            ),
                            if (index < _menuItems.length - 1)
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "|",
                                  style: TextStyle(color: Color(0xFFE0E0E0)),
                                ),
                              ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(
                height: 30,
                thickness: 1,
                color: Color.fromARGB(255, 226, 226, 226),
              ),
            ),
            _buildSection("주간 인기 및 추천 콘텐츠", _mdScrollController, 'recommend'),
            _buildSection("회원님이 좋아할 만한 콘텐츠", _pubScrollController, 'like'),
            _buildSection("최근 신작", _newScrollController, 'new'),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, ScrollController controller, String type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),
        Stack(
          alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              // 제미나이: key: ValueKey(_selectedMenuIndex)를 통해 메뉴 전환 시 SingleChildScrollView가 새로 렌더링되도록 하여, 카테고리 변경 시 이전 카테고리의 스크롤 위치가 잔류하는 것을 방지
              key: ValueKey(_selectedMenuIndex),
              controller: controller,
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Row(
                  children: _getBookData(
                    _selectedMenuIndex,
                    type,
                  ).map((data) => _buildBookItem(data)).toList(),
                ),
              ),
            ),
            Positioned(
              left: 8,
              top: 57,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () => _scrollList(controller, true),
              ),
            ),
            Positioned(
              right: 8,
              top: 62,
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () => _scrollList(controller, false),
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildMainHomeScreen(), // 기존 홈 화면 (인덱스 0)
      BookScreen(), // 인덱스 1
      MovieListScreen(), // 인덱스 2
      ExhibitionScreen(), // 인덱스 3
      PerformanceScreen(), // 인덱스 4
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 26),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false,
            );
          },
        ),
        title: const Text(
          "REMO",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 173, 207),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      endDrawer: CustomDrawer(
        onMenuSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: Scrollbar(
        // 제미나이: 전체 body에 스크롤바 추가
        child: _selectedIndex < pages.length ? pages[_selectedIndex] : pages[0],
      ),
    );
  }
}
