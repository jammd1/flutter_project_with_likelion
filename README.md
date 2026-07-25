<h1 align="center">✈️ Tripy</h1>

<p align="center"><b>AI 기반 여행 계획 & 여행지 탐색 Flutter 앱</b><br>
<i>AI-powered travel planning & discovery app, built with Flutter</i></p>

<p align="center">
<img src="https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white">
<img src="https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white">
<img src="https://img.shields.io/badge/Provider-02569B?style=flat-square&logo=flutter&logoColor=white">
<img src="https://img.shields.io/badge/Gemini-8E75B2?style=flat-square&logo=googlegemini&logoColor=white">
<img src="https://img.shields.io/badge/SQLite-003B57?style=flat-square&logo=sqlite&logoColor=white">
</p>

<p align="center">멋쟁이사자처럼 Flutter 미니 프로젝트 · Likelion Flutter mini project</p>

---

여행지를 둘러보고, 관련 뉴스를 확인하며, **Gemini AI로 맞춤 여행 일정을 자동 생성**할 수 있는 앱입니다.

<!-- TODO: 스크린샷 3~4장 추가하면 완성도가 확 올라감 (홈 / 상세 / AI 일정 생성)
<p align="center">
  <img src="docs/home.png" width="220">
  <img src="docs/detail.png" width="220">
  <img src="docs/ai_plan.png" width="220">
</p>
-->

## 주요 기능

**홈 화면**
- 여행 광고 자동 재생 캐러셀 슬라이더
- 여행지 그리드 목록 (외부 API 연동)
- 검색 기능 + 검색 히스토리 자동완성
- 다크 / 라이트 모드 전환, 사이드 드로어 내비게이션

**여행지 상세**
- 상품 탭: 해당 여행지 관련 상품 목록
- 뉴스 탭: NewsAPI 연동으로 여행지 최신 뉴스 제공

**AI 여행 계획**
- Gemini(`google_generative_ai`) 기반 여행 일정 자동 생성
- 입력: 목적지, 기간, 동반자 유형, 여행 스타일, 식사 선호도, 예산
- 생성된 일정을 로컬에 저장 및 조회

**내 정보 / About**
- 프로필 입력·저장(`sqflite`), 프로필 이미지 설정(`image_picker`)
- 가로/세로 방향 대응(`OrientationBuilder`) 앱 소개 페이지

## 기술 스택

| 분류 | 기술 |
| --- | --- |
| 프레임워크 | Flutter (Dart) |
| 상태 관리 | Provider |
| 로컬 DB | sqflite (SQLite) |
| 로컬 저장소 | shared_preferences |
| AI | google_generative_ai (Gemini) |
| 네트워크 | http |
| 뉴스 | NewsAPI |
| UI | carousel_slider, Material Design 3 |
| 기타 | image_picker, url_launcher |

## 아키텍처

```
lib/
├── core/          # routes, theme(라이트/다크), assets
├── models/        # 데이터 모델
├── services/      # API · DB · 저장소 서비스
├── providers/     # 상태 관리 (Provider)
└── presentations/ # home / detail / trip_planning / my_info / about
```

## 시작하기

```bash
flutter pub get

# API 키를 dart-define으로 주입
flutter run \
  --dart-define=NEWS_API_KEY=your_news_api_key \
  --dart-define=GEMINI_API_KEY=your_gemini_api_key
```

## 화면 구성

| 화면 | 설명 |
| --- | --- |
| Home | 여행지 탐색 메인 |
| Detail | 여행지 상품 & 뉴스 |
| Trip Planning | AI 일정 생성 & 내 일정 목록 |
| My Info | 사용자 프로필 |
| About | 앱 소개 |
| All Destinations | 전체 여행지 목록 |
