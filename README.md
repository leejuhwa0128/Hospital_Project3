# Hospital_Project3

# 👩‍💻 Lee Ju Hwa | Backend & Web Developer

> 💡 Spring 기반 병원 통합 포털 및 스터디 관리 웹 애플리케이션 개발 경험  
> 사용자 중심 기능 설계, 보안 프로세스 구축, 협업 환경에 강한 개발자

---

## 🪪 Profile
| 항목 | 내용 |
|------|------|
| **이름** | 이주화 (Lee Ju Hwa) |
| **생년월일** | 2001.01.28 |
| **연락처** | 📞 010-4803-9536 |
| **이메일** | ✉️ juhwa010128@gmail.com |
| **GitHub** | 🌐 [github.com/leejuhwa0128](https://github.com/leejuhwa0128) |
| **분야** | 백엔드 웹 개발, 데이터베이스, 보안 처리, UI 통합 |

---

## ⚙️ Skills
| 분야 | 기술 |
|------|------|
| **Language** | Java, JavaScript, HTML5, CSS3 |
| **Framework** | Spring MVC, MyBatis |
| **Database** | Oracle |
| **Server** | Apache Tomcat |
| **Tools** | STS4, VS Code, Maven, Git/GitHub |
| **API/Library** | Kakao Map API, Google reCAPTCHA, Naver SmartEditor2, JavaMailSender, TOSS API |
| **Security** | SHA-512 암호화, CAPTCHA, SSL, 세션 관리 |
| **Design** | Flowbite, Tailwind CSS, JSP 기반 UI 구성 |

---

## 🏥 Project 1 — 병원 통합 포털 시스템  

## 📘 프로젝트 개요
이 프로젝트는 단순한 병원 홈페이지 수준을 넘어,  
**환자**, **의료진**, **관리자** 각각의 요구를 통합적으로 관리할 수 있는  
**병원 포털 시스템**을 목표로 개발되었습니다.  

- **환자:** 진료 예약, 진료기록 및 증명서 발급  
- **의료진:** 스케줄 관리, 협진 요청 및 결과 확인  
- **관리자:** 회원가입 승인, 전체 데이터/예약 관리  

> 개발 기간: 2024.07.16 ~ 2024.08.27 (총 6주)  
> 과정명: K-Digital Training 3차 프로젝트

---

## 👩‍💻 팀 구성 및 역할

| 이름 | 역할 | 주요 담당 업무 |
|------|------|----------------|
| **이기탁** (팀장) | 백엔드 | 진료 예약 시스템 설계 및 구현, 환자번호 QR코드 자동 생성 |
| **안찬우** | 백엔드 | 의료진 관리, 진료 스케줄링, 협진 요청 프로세스 |
| **이주화** | 백엔드·프론트 | 협력기관 페이지, **보안 기능 (CAPTCHA)**, **네이버 스마트에디터 연동**, **이메일 임시비밀번호 발급** |
| **성소현** | 프론트 | 회원가입/로그인 (카카오 연동), 카카오맵 API, UI 컴포넌트 설계 (Flowbite + Tailwind) |
| **박성준** | 백엔드 | 관리자 모듈, 보안 강화 (ID/PW 암호화 – SHA-512) |
| **임세아** | 백엔드 | 병원 정보 서비스, 온라인 결제(TOSS) 연동 |
| **최서연** | 백엔드 | 고객 서비스 페이지, 통합 검색 엔진, 전자문서 발급(iText 기반) |
| **원윤희** (멘토) | 기술 자문 | 프로젝트 피드백 및 질의응답 |

---

## ⚙️ 개발 절차
| 단계 | 기간 | 주요 활동 |
|------|------|------------|
| 1. 사전 기획 | 7/16 ~ 7/18 | 주제 선정, 요구사항 분석 |
| 2. 개발환경 구축 | 7/21 ~ 7/23 | Spring/MyBatis 세팅, DB 연결 |
| 3. 핵심 기능 개발 | 7/24 ~ 8/15 | CRUD, 예약, 협진, 관리자 기능 구현 |
| 4. 통합 및 보완 | 8/18 ~ 8/22 | 세부 기능 보완, JSP 통합 |
| 5. 테스트 및 배포 | 8/25 ~ 8/27 | 통합 테스트, 오류 수정, 시연 준비 |

---

### 📌 주요 역할
- **협력기관 페이지** 설계 및 CRUD 구현  
- **CAPTCHA 보안** 기능 추가 (Google reCAPTCHA v2)  
- **이메일 임시 비밀번호 발급** (Gmail SMTP + JavaMailSender)  
- **SmartEditor2 연동** — 공지사항/게시판 작성 시 HTML 에디터 적용  
- **협진 게시판 / 소견 작성 페이지** 개발  
- **의료진 스케줄 관리** 모듈 구현  
- **Kakao Map API**를 이용한 병원 위치 안내 기능  

### 💡 기술적 포인트
- Spring MVC + MyBatis 구조 기반의 Controller-Service-DAO 계층 설계  
- SHA-512 암호화 및 세션 만료 처리로 보안 강화  
- 협진 테이블(doctor_id + date + time_slot)에 UNIQUE 제약 추가로 중복예약 방지  
- HTML 변환 시 `<p>, <br>` 처리 오류 해결 (Jsoup sanitize 적용)

### ⚙️ Troubleshooting 경험
| 문제 | 해결 방법 |
|------|-------------|
| reCAPTCHA 응답 누락 | AJAX 요청 본문에 토큰 포함하도록 수정 |
| SMTP 전송 지연 | `@Async` 비동기 메일 발송 적용 |
| SmartEditor XSS | 서버단 HTML sanitizing 적용 |
| 협진 일정 중복 | DB UNIQUE 제약 + Mapper 예외 처리 |
| KakaoMap 표시 오류 | API 키 재발급 및 URL referer 등록 |

## 🔐 보안 관련 구현 경험
| 기능 | 설명 |
|------|------|
| **CAPTCHA** | Google reCAPTCHA v2 적용, 비정상 로그인 방어 |
| **임시 비밀번호 발급** | Gmail SMTP 연동, SHA-512 암호화 |
| **세션 만료 관리** | 일정 시간 미사용 시 자동 로그아웃 처리 |
| **SSL 적용** | HTTPS 기반 통신 보안 구축 |

---

## ✨ Contact Me
📞 010-4803-9536  
📧 juhwa010128@gmail.com  
🌐 [https://github.com/leejuhwa0128](https://github.com/leejuhwa0128)

---

> “보안과 사용자 편의성을 함께 고민하는 개발자,  
> 협업 속에서 성장하는 개발자 이주화입니다.”
