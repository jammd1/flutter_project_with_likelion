const express = require('express');
const path = require('path');
const app = express();
const PORT = 3000;

// 정적 파일 제공 (이미지)
app.use('/images', express.static(path.join(__dirname, 'images')));

// 여행지 데이터
const destinations = [
  {
    id: 1,
    name: '스위스',
    country: 'Swiss',
    description: '아름다운 알프스 산맥과 호수로 유명한 스위스',
    imageUrl: 'http://192.168.200.101:3000/images/main_swiss.jpg',
    discount: '최대 20% 할인',
  },
  {
    id: 2,
    name: '호주',
    country: 'Australia',
    description: '광활한 자연과 독특한 문화를 체험할 수 있는 호주',
    imageUrl: 'http://192.168.200.101:3000/images/main_australia.jpg',
    discount: '최대 10% 할인',
  },
  {
    id: 3,
    name: '조지아',
    country: 'Georgia',
    description: '코카서스의 숨겨진 왕국 조지아',
    imageUrl: 'http://192.168.200.101:3000/images/main_georgia.jpg',
    discount: '최대 15% 할인',
  },
  {
    id: 4,
    name: '몽골',
    country: 'Mongolia',
    description: '끝없는 초원과 유목민의 나라',
    imageUrl: 'http://192.168.200.101:3000/images/main_mongolia.jpg',
    discount: '최대 10% 할인',
  },
  {
    id: 5,
    name: '네팔',
    country: 'Nepal',
    description: '소박하지만 화려한 빛을 내는 나라',
    imageUrl: 'http://192.168.200.101:3000/images/main_nepal.jpg',
    discount: '최대 10% 할인',
  },
  {
    id: 6,
    name: '하와이',
    country: 'Hawaii',
    description: '세계 허니무너들의 지상낙원',
    imageUrl: 'http://192.168.200.101:3000/images/main_hawaii.jpg',
    discount: '최대 10% 할인',
  },
  {
    id: 7,
    name: '아이슬란드',
    country: 'Iceland',
    description: '얼음과 불의 섬, 오로라의 성지',
    imageUrl: 'http://192.168.200.101:3000/images/main_iceland.jpg',
    discount: '최대 5% 할인',
  },
  {
    id: 8,
    name: '이탈리아',
    country: 'Italy',
    description: '역사와 예술, 미식의 중심지 로마와 피렌체',
    imageUrl: 'http://192.168.200.101:3000/images/main_italy.jpg',
    discount: '최대 25% 할인',
  },
  {
    id: 9,
    name: '일본',
    country: 'Japan',
    description: '가깝고도 즐길 거리 가득한 삿포로와 오사카',
    imageUrl: 'http://192.168.200.101:3000/images/main_japan.jpg',
    discount: '최대 30% 할인',
  },
  {
    id: 10,
    name: '태국',
    country: 'Thailand',
    description: '에메랄드빛 바다와 화려한 밤문화의 방콕',
    imageUrl: 'http://192.168.200.101:3000/images/main_thailand.jpg',
    discount: '최대 20% 할인',
  },
  {
    id: 11,
    name: '프랑스',
    country: 'France',
    description: '낭만이 가득한 에펠탑의 도시 파리',
    imageUrl: 'http://192.168.200.101:3000/images/main_france.jpg',
    discount: '최대 15% 할인',
  },
  {
    id: 12,
    name: '스페인',
    country: 'Spain',
    description: '태양의 나라, 가우디의 숨결이 닿은 바르셀로나',
    imageUrl: 'http://192.168.200.101:3000/images/main_spain.jpg',
    discount: '최대 10% 할인',
  },
  {
    id: 13,
    name: '캐나다',
    country: 'Canada',
    description: '단풍으로 물든 나이아가라 폭포의 장관',
    imageUrl: 'http://192.168.200.101:3000/images/main_canada.jpg',
    discount: '최대 12% 할인',
  },
  {
    id: 14,
    name: '포르투갈',
    country: 'Portugal',
    description: '리스본의 노란 트램과 대항해 시대의 흔적',
    imageUrl: 'http://192.168.200.101:3000/images/main_portugal.jpg',
    discount: '최대 20% 할인',
  },
  {
    id: 15,
    name: '터키',
    country: 'Turkey',
    description: '열기구를 타고 즐기는 카파도키아의 비경',
    imageUrl: 'http://192.168.200.101:3000/images/main_turkey.jpg',
    discount: '최대 15% 할인',
  },
  {
    id: 16,
    name: '뉴질랜드',
    country: 'New Zealand',
    description: '반지의 제왕 촬영지, 순수 자연의 끝판왕',
    imageUrl: 'http://192.168.200.101:3000/images/main_newzealand.jpg',
    discount: '최대 10% 할인',
  },
  {
    id: 17,
    name: '그리스',
    country: 'Greece',
    description: '산토리니의 파란 지붕과 하얀 골목길',
    imageUrl: 'http://192.168.200.101:3000/images/main_greece.jpg',
    discount: '최대 18% 할인',
  },
  {
    id: 18,
    name: '크로아티아',
    country: 'Croatia',
    description: '아드리아해의 진주, 두브로브니크 성벽',
    imageUrl: 'http://192.168.200.101:3000/images/main_croatia.jpg',
    discount: '최대 10% 할인',
  },
  {
    id: 19,
    name: '모로코',
    country: 'Morocco',
    description: '사하라 사막과 푸른 도시 쉐프샤우엔',
    imageUrl: 'http://192.168.200.101:3000/images/main_morocco.jpg',
    discount: '최대 20% 할인',
  },
  {
    id: 20,
    name: '베트남',
    country: 'Vietnam',
    description: '천혜의 자연 하롱베이와 활기찬 다낭',
    imageUrl: 'http://192.168.200.101:3000/images/main_vietnam.jpg',
    discount: '최대 35% 할인',
  },
  {
    id: 21,
    name: '오스트리아',
    country: 'Austria',
    description: '모차르트의 고향과 아름다운 할슈타트',
    imageUrl: 'http://192.168.200.101:3000/images/main_austria.jpg',
    discount: '최대 15% 할인',
  },
  {
    id: 22,
    name: '페루',
    country: 'Peru',
    description: '잉카 문명의 신비가 살아있는 마추픽추',
    imageUrl: 'http://192.168.200.101:3000/images/main_peru.jpg',
    discount: '최대 10% 할인',
  },
  {
    id: 23,
    name: '핀란드',
    country: 'Finland',
    description: '산타클로스 마을과 사우나의 본고장',
    imageUrl: 'http://192.168.200.101:3000/images/main_finland.jpg',
    discount: '최대 10% 할인',
  },
  {
    id: 24,
    name: '멕시코',
    country: 'Mexico',
    description: '칸쿤의 에메랄드 해변과 마야 유적지',
    imageUrl: 'http://192.168.200.101:3000/images/main_mexico.jpg',
    discount: '최대 25% 할인',
  },
  {
    id: 25,
    name: '몰디브',
    country: 'Maldives',
    description: '프라이빗한 휴양을 위한 완벽한 섬',
    imageUrl: 'http://192.168.200.101:3000/images/main_maldives.jpg',
    discount: '최대 5% 할인',
  },
  {
    id: 26,
    name: '라오스',
    country: 'Laos',
    description: '방비엥의 액티비티와 루앙프라방의 평화',
    imageUrl: 'http://192.168.200.101:3000/images/main_laos.jpg',
    discount: '최대 30% 할인',
  },
  {
    id: 27,
    name: '남아프리카 공화국',
    country: 'South Africa',
    description: '테이블 마운틴과 야생의 사파리 투어',
    imageUrl: 'http://192.168.200.101:3000/images/main_safrica.jpg',
    discount: '최대 15% 할인',
  },
  {
    id: 28,
    name: '영국',
    country: 'UK',
    description: '해리포터의 배경과 클래식한 런던의 거리',
    imageUrl: 'http://192.168.200.101:3000/images/main_uk.jpg',
    discount: '최대 12% 할인',
  },
  {
    id: 29,
    name: '대만',
    country: 'Taiwan',
    description: '지우펀의 야경과 끝없는 미식 탐방',
    imageUrl: 'http://192.168.200.101:3000/images/main_taiwan.jpg',
    discount: '최대 20% 할인',
  },
  {
    id: 30,
    name: '체코',
    country: 'Czech',
    description: '프라하 성의 야경과 낭만적인 까를교',
    imageUrl: 'http://192.168.200.101:3000/images/main_czech.jpg',
    discount: '최대 15% 할인',
  },
];

// 전체 목록 API
app.get('/destinations', (req, res) => {
  res.json(destinations);
});

// 단건 조회 API
app.get('/destinations/:id', (req, res) => {
  const destination = destinations.find(d => d.id === parseInt(req.params.id));
  if (!destination) {
    return res.status(404).json({ message: 'Not found' });
  }
  res.json(destination);
});

app.listen(PORT, () => {
  console.log(`서버 실행 중: http://localhost:${PORT}`);
});