<div align="center">
  <img src="../docs/4weekdays.jpg" width="180" alt="4weekdays-logo" />
</div>

# 📌 4Weekdays

> 공급업체의 납품부터 발주, ASN, 입고, 작업, 재고, 출고까지 이어지는 흐름을 하나의 데이터 체계로 관리하기 위해 만든 창고 관리 플랫폼입니다.

- 기간: 2025.09 ~ 2025.11
- 구성: 4인 팀 프로젝트 / 팀장
- [4Weekdays 링크](https://www.4weekdays.kro.kr)
- [프론트엔드 Repository](https://github.com/tipsyboy/ESC-4Weekdays-FE)
- [백엔드 Repository](https://github.com/tipsyboy/ESC-4Weekdays-BE)

## 시스템 아키텍처
<div align="center">
  <img src="./docs/architecture.png" width="1000" alt="system-architecture" />
</div>

## 👨‍💻 ESC 팀원 구성

<div align="center">
  <img src="./docs/logo.png" width="150" alt="ESC 로고" />
</div>

<table align="center">
  <tbody>
    <tr>
      <td align="center">
        <a href="https://github.com/tipsyboy">
          <img src="https://github.com/tipsyboy.png" width="100" alt="양형모">
        </a>
        <br><b>양형모</b>
      </td>
      <td align="center">
        <a href="https://github.com/seol-kang">
          <img src="https://github.com/seol-kang.png" width="100" alt="강설">
        </a>
        <br><b>강설</b>
      </td>
      <td align="center">
        <a href="https://github.com/wonzzu">
          <img src="https://github.com/wonzzu.png" width="100" alt="김원중">
        </a>
        <br><b>김원중</b>
      </td>
      <td align="center">
        <a href="https://github.com/why48382">
          <img src="https://github.com/why48382.png" width="100" alt="이현식">
        </a>
        <br><b>이현식</b>
      </td>
    </tr>
  </tbody>
</table>


---

# 🙋 담당

## 👤 역할

### Backend

- Kubernetes 기반 배포 환경 구성
- Jenkins 기반 CI/CD 자동화
- 인증/인가 구조 설계 및 구현
- 상품, 입고, 재고, 작업 도메인 API 개발
- 검색 기능 설계 및 Elasticsearch 연동


### Frontend

- 주요 화면 설계
- API 연동 구조 정리
- 재사용 가능한 화면 템플릿 가이드 작성

## 🔥 주요 기여

### 1️⃣ Kubernetes 기반 배포 인프라 구축 및 CI/CD 자동화

<div align="center">
  <img src="./docs/pipline.png" width="1000" alt="ci-cd-pipline" />
</div>

- Kubernetes 클러스터 구축 및 서비스 운영 환경 마련
- GitHub Webhook과 Jenkins를 연동해 CI/CD 파이프라인 구성

#### 결과
- 수동 빌드·배포 과정의 반복과 실수 가능성을 파이프라인 자동화로 완화
- Grafana 기준 한 달간 서버 가동률 98.1% 달성


### 2️⃣ JWT 기반 인증/인가 서비스 구축

- K8s 다중 노드 환경을 고려한 JWT 기반 무상태 인증 구조 설계 및 구현
- Access Token, Refresh Token을 쿠키 기반으로 운영하도록 인증 흐름 구성
- 서버 필터에서 Refresh Token 자동 재발급 처리로 인증 요청 구조 단순화
- SSL 인증서 발급 및 HTTPS 환경 구축

#### 결과
- Kubernetes 다중 노드 환경에서 세션 상태 공유 문제를 무상태 구조로 전환해 해소
- 토큰 재발급 네트워크 왕복 3 → 1 단축

### 3️⃣ QueryDSL 기반 검색 최적화와 JPA 조회 성능 개선

- QueryDSL 도입으로 컴파일 시점 오류 체크 및 타입 안정성 확보
- BooleanExpression 모듈화를 통한 동적 필터링 로직 구현
- 연관관계 유형별 N+1 해결 전략 비교 및 최적안 적용

#### 결과
- 문자열 기반 쿼리 작성 방식에서 발생하던 유지보수성 문제를 개선
- 연관관계가 많은 조회 API에서 발생하던 N+1 문제를 완화
- 검색 조건 확장과 조회 성능 개선을 함께 고려할 수 있는 구조로 개선

### 4️⃣ Elasticsearch 검색 엔진 도입

<div align="center">
  <img src="./docs/elk.png" width="800" alt="elk" />
</div>

- Elasticsearch를 도입해 역색인 기반 검색 구조 구성
- Logstash JDBC 플러그인 기반 MariaDB-ES 간 데이터 동기화 파이프라인 구축
- 제한된 서버 자원 안에서 운영 가능하도록 리소스와 JVM 메모리 튜닝

#### 결과
- `%LIKE%` 기반 검색의 구조적 성능 한계를 역색인 기반 검색으로 개선
- 상품 검색 응답 속도와 검색 경험을 함께 개선할 수 있는 기반 마련
- 제한된 서버 자원 내에서도 운영 가능한 검색 인프라 구성

## 주요 기능

- 공급업체 등록, 상태 관리, 상품 연계
- 발주 생성, 수정, 승인, 상태 추적
- ASN 수신 및 입고 예정 자동 생성
- 입고 검수와 적치 작업 생성 및 배정
- 로케이션별 재고 조회와 LOT 이력 추적
- 피킹, 패킹, 출하 작업 흐름 관리
- 상품, 재고, 발주, 입고 통합 검색

## 기술 스택

### Backend

![Java](https://img.shields.io/badge/Java_17-007396?style=flat&logo=openjdk&logoColor=white)
![Spring Boot](https://img.shields.io/badge/Spring_Boot_3.5.6-6DB33F?style=flat&logo=springboot&logoColor=white)
![Spring Security](https://img.shields.io/badge/Spring_Security-6DB33F?style=flat&logo=springsecurity&logoColor=white)
![Spring Data JPA](https://img.shields.io/badge/Spring_Data_JPA-6DB33F?style=flat&logo=spring&logoColor=white)
![QueryDSL](https://img.shields.io/badge/QueryDSL-0769AD?style=flat)
![JWT](https://img.shields.io/badge/JWT-000000?style=flat&logo=jsonwebtokens&logoColor=white)
![Validation](https://img.shields.io/badge/Spring_Validation-6DB33F?style=flat&logo=spring&logoColor=white)
![Swagger](https://img.shields.io/badge/Springdoc_OpenAPI-85EA2D?style=flat&logo=swagger&logoColor=black)
![Actuator](https://img.shields.io/badge/Spring_Boot_Actuator-6DB33F?style=flat&logo=springboot&logoColor=white)

### Data and Infra

![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=flat&logo=mariadb&logoColor=white)
![Elasticsearch](https://img.shields.io/badge/Elasticsearch-005571?style=flat&logo=elasticsearch&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=flat&logo=kubernetes&logoColor=white)
![Jenkins](https://img.shields.io/badge/Jenkins-D24939?style=flat&logo=jenkins&logoColor=white)

### Test and Tooling

![Gradle](https://img.shields.io/badge/Gradle-02303A?style=flat&logo=gradle&logoColor=white)
![JUnit 5](https://img.shields.io/badge/JUnit_5-25A162?style=flat&logo=junit5&logoColor=white)
![H2](https://img.shields.io/badge/H2_Database-09476B?style=flat)
![Git](https://img.shields.io/badge/Git-F05032?style=flat&logo=git&logoColor=white)

## 문서

- [📖 Wiki](https://github.com/beyond-sw-camp/be17-fin-ESC-4Weekdays-BE/wiki)
- [프로젝트 기획서](https://github.com/beyond-sw-camp/be17-fin-ESC-4Weekdays-BE/wiki/ESC-%E2%80%90-4WeekDays-%E2%80%90-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-%EA%B8%B0%ED%9A%8D%EC%84%9C)
- [WBS](https://github.com/beyond-sw-camp/be17-fin-ESC-4Weekdays-BE/wiki/WBS)
- [ERD](https://github.com/beyond-sw-camp/be17-fin-ESC-4Weekdays-BE/wiki/ERD)
- [요구사항 정의서](https://github.com/beyond-sw-camp/be17-fin-ESC-4Weekdays-BE/wiki/%EC%9A%94%EA%B5%AC%EC%82%AC%ED%95%AD-%EB%AA%85%EC%84%B8%EC%84%9C)
- [시스템 아키텍처](https://github.com/beyond-sw-camp/be17-fin-ESC-4Weekdays-BE/wiki/%EC%8B%9C%EC%8A%A4%ED%85%9C-%EC%95%84%ED%82%A4%ED%85%8D%EC%B2%98)
- [Jenkins CI/CD 파이프라인](https://github.com/beyond-sw-camp/be17-fin-ESC-4Weekdays-BE/wiki/Jenkins%EB%A5%BC-%ED%86%B5%ED%95%9C-CI-CD-%ED%8C%8C%EC%9D%B4%ED%94%84%EB%9D%BC%EC%9D%B8-%EA%B5%AC%EC%B6%95%ED%95%98%EA%B8%B0)
