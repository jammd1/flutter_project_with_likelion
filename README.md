---                                                                                                                 
  # ✈️ Tripy                                                                                                          
                                                                                                                      
  > AI 기반 여행 계획 & 여행지 탐색 Flutter 앱                                                                        
                                                                                                                      
  멋쟁이사자처럼 Flutter 미니 프로젝트로 개발한 여행 앱입니다.                                                        
  여행지를 둘러보고, 관련 뉴스를 확인하며, Gemini AI로 맞춤 여행 일정을 자동 생성할 수 있습니다.

  ---

  ## 주요 기능

  ### 홈 화면
  - 여행 광고 자동 재생 캐러셀 슬라이더
  - 여행지 그리드 목록 (외부 API 연동)
  - 검색 기능 + 검색 히스토리 자동완성
  - 다크 / 라이트 모드 전환
  - 사이드 드로어 내비게이션

  ### 여행지 상세 화면
  - **상품 탭**: 해당 여행지 관련 상품 목록
  - **뉴스 탭**: NewsAPI 연동으로 여행지 최신 뉴스 제공

  ### AI 여행 계획
  - Gemini AI(google_generative_ai) 기반 여행 일정 자동 생성
  - 입력 항목: 목적지, 여행 기간, 동반자 유형, 여행 스타일, 식사 선호도, 예산
  - 생성된 일정 로컬 DB(SQLite)에 저장 및 조회

  ### 내 정보
  - 사용자 프로필 정보 입력 및 저장 (shared_preferences)
  - 이미지 프로필 설정 (image_picker)

  ### About
  - 앱 소개 페이지
  - 가로 / 세로 방향(OrientationBuilder) 레이아웃 대응

  ---

  ## 기술 스택

  | 분류 | 기술 |
  |------|------|
  | 프레임워크 | Flutter (Dart) |
  | 상태 관리 | Provider |
  | 로컬 DB | sqflite (SQLite) |
  | 로컬 저장소 | shared_preferences |
  | AI | google_generative_ai (Gemini) |
  | 네트워크 | http |
  | 뉴스 API | NewsAPI |
  | UI | carousel_slider, Material Design 3 |
  | 기타 | image_picker, url_launcher |

  ---

  ## 아키텍처

  lib/
  ├── core/
  │   ├── routes/        # 라우트 정의
  │   ├── theme/         # 라이트/다크 테마
  │   └── assets/        # 이미지 에셋
  ├── models/            # 데이터 모델
  ├── services/          # API, DB, 저장소 서비스
  ├── providers/         # 상태 관리 (Provider)
  └── presentations/     # 화면 및 위젯
      ├── home/
      ├── detail/
      ├── trip_planning/
      ├── my_info/
      └── about/

  ---

  ## 시작하기

  ### 환경 변수 설정

  ```bash
  # NewsAPI 키 설정
  flutter run --dart-define=NEWS_API_KEY=your_news_api_key

  # Gemini API 키는 별도 환경변수로 설정
  flutter run --dart-define=GEMINI_API_KEY=your_gemini_api_key

  실행

  flutter pub get
  flutter run

  ---
  화면 구성

  ┌──────────────────┬─────────────────────────────┐
  │       화면       │            설명             │
  ├──────────────────┼─────────────────────────────┤
  │ Home             │ 여행지 탐색 메인 화면       │
  ├──────────────────┼─────────────────────────────┤
  │ Detail           │ 여행지 상품 & 뉴스          │
  ├──────────────────┼─────────────────────────────┤
  │ Trip Planning    │ AI 일정 생성 & 내 일정 목록 │
  ├──────────────────┼─────────────────────────────┤
  │ My Info          │ 사용자 프로필               │
  ├──────────────────┼─────────────────────────────┤
  │ About            │ 앱 소개                     │
  ├──────────────────┼─────────────────────────────┤
  │ All Destinations │ 전체 여행지 목록            │
  └──────────────────┴─────────────────────────────┘

  ---
