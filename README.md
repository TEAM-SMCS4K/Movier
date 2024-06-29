# MOVIER - 영화와 마음이 머무는 공간

숙명여자대학교 소프트웨어학부 데이터베이스프로그래밍 팀프로젝트 🎥 MOVIER 🎥 레포 (2024.05 ~ 2024.06 🛠)
<br>
<br>

## 🔑 Key Feature
<img src="https://github.com/TEAM-SMCS4K/Movier/assets/101168694/a30d91fa-4f74-43a2-a13c-84a049f9079a"> | <img src="https://github.com/TEAM-SMCS4K/Movier/assets/101168694/61e49174-3e60-4b62-b667-3a3c7e4dfe10"> |
:---------:|:----------:|
소셜 로그인 | 메인 페이지 |

<img src="https://github.com/TEAM-SMCS4K/Movier/assets/101168694/4f8e3ffc-29f7-4669-8f86-b98db10e8263"> | <img src="https://github.com/TEAM-SMCS4K/Movier/assets/101168694/1d01b76d-59ec-4c96-8d89-b909194311a0"> |
:---------:|:----------:|
메인 페이지(검색) | 영화 상세보기(영화 정보) |

<img src="https://github.com/TEAM-SMCS4K/Movier/assets/101168694/a107b7b6-434a-4093-84f5-ca4817342889"> | <img src="https://github.com/TEAM-SMCS4K/Movier/assets/101168694/68cfd4f3-70ac-4910-8294-e5f56b5e6e56"> |
:---------:|:----------:|
영화 상세보기(예외) | 영화 상세보기(리뷰 요청)|

<img src="https://github.com/TEAM-SMCS4K/Movier/assets/101168694/8bcbb437-d748-45e2-be18-c13c330d411a"> | <img src="https://github.com/TEAM-SMCS4K/Movier/assets/101168694/6cf8151d-d550-4067-aa8d-7613068a02df"> |
:---------:|:----------:|
영화 상세보기(리뷰 리스트, 공감하기) | 마이페이지 |

<img src="https://github.com/TEAM-SMCS4K/Movier/assets/101168694/24a0f193-3146-439c-b0ae-7e3263ec8d72"> | <img src="https://github.com/TEAM-SMCS4K/Movier/assets/101168694/825dc15f-9173-4420-9936-03305c3f4775"> |
:---------:|:----------:|
리뷰 상세보기 | 리뷰 상세보기(예외) |

<img src="https://github.com/TEAM-SMCS4K/Movier/assets/101168694/68f76a8f-1216-409d-966d-1fc47e6069a1"> | <img src="https://github.com/TEAM-SMCS4K/Movier/assets/101168694/a5d1f3b4-af1b-49ea-bbc3-cfd1b33495a4"> |
:---------:|:----------:|
리뷰 작성 | 리뷰 수정 |

<img src="https://github.com/TEAM-SMCS4K/Movier/assets/101168694/8f9ec77d-4a11-4796-af49-93907f1d0d6e"> | <img src="https://github.com/TEAM-SMCS4K/Movier/assets/101168694/c530007c-b36d-487e-a73d-c26782e8360f"> |
:---------:|:----------:|
리뷰 작성 & 수정 (예외) | 리뷰 작성 & 수정 (예외2) |

</br>

## 😊 역할분담 & 팀원 소개

| 담당자         | 담당 내용                                                                                               |
|----------------|---------------------------------------------------------------------------------------------------------|
| 권정 (@kj9470) | - [뷰] 메인 페이지 뷰 구현: `movieMain.jsp`<br>- [뷰] 네비게이션 바 이동 기능 구현: `navTabBar.jsp`<br>- [기능] 전체 영화 리스트 조회 기능 구현: `movieLists.jsp`, `MovieList.java`, `get_movie_list.sql`, `MovieDAO - getMovieList()`<br>- [기능] 검색 기능 구현: `searchMovieLists.jsp`, `get_search_movie_list.sql`, `MovieDAO - getSearchMovies()`<br>- [기능] 유저 정보 조회: `navTabBar.jsp`<br>- [기능] 로그아웃: `navTabBar.jsp`, `LogoutServlet.java` |
| 김성은 (@sung-silver) | - [뷰] Movier 소셜 로그인 뷰 구현: `socialLogin.jsp`<br>- [뷰] 영화 상세보기 뷰 구현: `movieDetail.jsp`, `filterReviews.jsp`, `reviewComponent.jsp`, `reviewRequest.jsp`, `reviewList.jsp`<br>- [기능] 카카오 소셜 로그인 기능 구현: `SocialLoginServlet.java`, `MemberDAO - getMemberIdBySocialPlatformId()`, `MemberDAO - insertMember()`, `get_member_id_by_kakao_platform_id.sql`, `insert_member.sql`<br>- [기능] 영화 정보(포스터, 이름, 개봉년도, 평점, 리뷰 개수 등) 조회 구현: `MovieDAO - getMovieById()`<br>- [기능] 사용자에게 리뷰를 요청하는 기능 구현: `MemberDAO - getMemberNameById()`<br>- [기능] 정렬(별점순, 최신순, 별점 필터)된 영화별 리뷰(작성자, 내용, 별점, 공감 개수) 리스트 조회 구현: `ReviewDAO - getSortedReviewsByMovieId()`, `SympathyDAO - getSympathyCount()`, `get_latest_review_by_movie_id.sql`, `get_rating_review_by_movie_id.sql`, `ToggleSympathyServlet.java`<br>- [기능] 리뷰 공감 기능 구현: `SympathyDAO - addSympathy()`<br>- [기능] 리뷰 공감 취소 구현: `SympathyDAO - removeSympathy()`<br>- [기능] 리뷰 공감 여부 조회 구현: `SympathyDAO - isSympathyExist()`, `check_sympathy.sql`, `create_sympathy_count_view.sql`<br>- [기능] 리뷰 작성/수정/삭제 시 영화 테이블 업데이트 트리거: 내부 호출 함수 구현 - `get_movie_review_info.sql` |
| 김윤지 (@jelliijoa) | - [뷰] 마이페이지 뷰 구현: `myPage.jsp`<br>- [뷰] 마이페이지 리뷰 상세보기 뷰 구현: `myReview.jsp`<br>- [뷰] 리뷰 CRUD 시 공통 영화 조회 뷰 구현: `DetailsComponent.jsp`<br>- [기능] 마이페이지 로그인 된 유저 정보 조회 기능 구현 (프로필 사진, 닉네임, 작성한 리뷰 개수): `MemberDAO - getMemberById()`, `ReviewDAO - getReviewCountByMemberId()`<br>- [기능] 유저가 작성한 모든 리뷰 리스트 조회 기능 구현 (영화 포스터, 제목, 별점, 리뷰 내용, 리뷰 작성일): `Review.java`, `MyPageReview.java`, `ReviewDAO - getMyPageReviewsByMemberId()`, `get_reviews_by_reviewer_id.sql`<br>- [기능] 유저가 작성한 리뷰 상세 조회 기능 구현 (리뷰 별점, 리뷰 내용, 영화 썸네일): `ReviewDetail.java`, `ReviewDAO - getReviewDetailsByMemberId()`, `get_review_details_by_reviewer_id.sql`<br>- [기능] 리뷰 생성, 조회, 수정, 삭제 시 공통 영화 정보 조회 기능 구현 (영화 제목, 포스터, 장르, 개봉일, 상영시간): `MovieDAO - getMovieInfoByMovieId()`, `get_movie_info_by_movie_id.sql`<br>- [기능] 리뷰 삭제 기능 구현: `ReviewDAO - deleteReviewById()` |
| 김채연 (@kcy24)    | - [뷰] 리뷰 작성 뷰 구현: `writeReview.jsp`<br>- [뷰] 리뷰 수정 뷰 구현: `editReview.jsp`<br>- [뷰] 리뷰 조회 뷰 구현: `myReview.jsp`<br>- [뷰] 리뷰 CRUD 시 공통 영화 조회 뷰 구현: `DetailsComponent.jsp`<br>- [기능] 별점 입력 기능 구현: `starRating.jsp`<br>- [기능] 리뷰 작성 기능 구현 (별점과 리뷰 내용 입력): `insert_review.sql`, `WriteReviewServlet.java`, `ReviewDAO.java - insertReview()`<br>- [기능] 리뷰 수정 기능 구현 (별점과 리뷰 내용 수정): `update_review.sql`, `EditReviewServlet.java`, `ReviewDAO.java - updateReview()`<br>- [기능] 리뷰 작성/수정/삭제 시 영화 테이블 업데이트 트리거 구현: `create_trg_review_changes.sql` |


</br>

## 🛠 기술 스택
![005](https://github.com/TEAM-SMCS4K/Movier/assets/101168694/3e9d2851-0268-42ba-8450-dc06af536615)


</br>

## 📁 Folder 구조

```
📦 Movier
└─ src
   └─ main
      ├─ java
      │  └─ cs
      │     └─ sookmyung
      │        └─ movier
      │           ├─ EditReviewServlet.java
      │           ├─ LogoutServlet.java
      │           ├─ SocialLoginServlet.java
      │           ├─ ToggleSympathyServlet.java
      │           ├─ WriteReviewServlet.java
      │           ├─ config
      │           │  └─ ConfigLoader.java
      │           ├─ dao
      │           │  ├─ MemberDAO.java
      │           │  ├─ MovieDAO.java
      │           │  ├─ ReviewDAO.java
      │           │  └─ SympathyDAO.java
      │           └─ model
      │              ├─ Member.java
      │              ├─ Movie.java
      │              ├─ MovieList.java
      │              ├─ MovieReview.java
      │              ├─ MyPageReview.java
      │              ├─ Review.java
      │              └─ ReviewDetail.java
      ├─ resources
      │  └─ sql
      │     ├─ check_sympathy.sql
      │     ├─ create_member.sql
      │     ├─ create_movie.sql
      │     ├─ create_review.sql
      │     ├─ create_sympathy.sql
      │     ├─ create_sympathy_count_view.sql
      │     ├─ create_trg_review_changes.sql
      │     ├─ dummy
      │     │  ├─ dummy_members.sql
      │     │  ├─ dummy_movies.sql
      │     │  ├─ dummy_reviews.sql
      │     │  └─ dummy_sympathy.sql
      │     ├─ get_latest_review_by_movie_id.sql
      │     ├─ get_member_id_by_kakao_platform_id.sql
      │     ├─ get_movie_info_by_movie_id.sql
      │     ├─ get_movie_list.sql
      │     ├─ get_movie_review_info.sql
      │     ├─ get_rating_review_by_movie_id.sql
      │     ├─ get_review_count_by_reviewer_id.sql
      │     ├─ get_review_details_by_reviewer_id.sql
      │     ├─ get_reviews_by_reviewer_id.sql
      │     ├─ get_search_movie_list.sql
      │     ├─ insert_member.sql
      │     ├─ insert_review.sql
      │     └─ update_review.sql
      └─ webapp
         ├─ WEB-INF
         │  └─ lib
         │     └─ ojdbc11.jar
         │  └─ web.xml
         ├─ css
         │  ├─ detailsComponent.css
         │  ├─ movieDetail.css
         │  ├─ movieLists.css
         │  ├─ movieMain.css
         │  ├─ myPage.css
         │  ├─ myReview.css
         │  ├─ navTabBar.css
         │  ├─ reviewComponent.css
         │  ├─ reviewList.css
         │  ├─ reviewRequest.css
         │  ├─ socialLogin.css
         │  ├─ starRating.css
         │  └─ writeReview.css
         ├─ detailsComponent.jsp
         ├─ editReview.jsp
         ├─ filterReviews.jsp
         ├─ img
         │  ├─ default_profile_img.svg
         │  ├─ icn_check.svg
         │  ├─ icn_search.svg
         │  ├─ icn_star_empty.svg
         │  ├─ icn_star_empty_set.svg
         │  ├─ icn_star_full.svg
         │  ├─ icn_star_full_set.svg
         │  ├─ kakao_logo.svg
         │  ├─ movie_poster_dummy.svg
         │  ├─ movier_logo.svg
         │  ├─ movier_white_logo.svg
         │  └─ profile.svg
         ├─ movieDetail.jsp
         ├─ movieLists.jsp
         ├─ movieMain.jsp
         ├─ myPage.jsp
         ├─ myReview.jsp
         ├─ navTabBar.jsp
         ├─ reviewComponent.jsp
         ├─ reviewList.jsp
         ├─ reviewRequest.jsp
         ├─ searchMovieLists.jsp
         ├─ socialLogin.jsp
         ├─ starRating.jsp
         └─ writeReview.jsp
```

</br>

## 💽 Database ERD
<img width="626" alt="image" src="https://github.com/TEAM-SMCS4K/Movier/assets/81363864/b4df3494-73f1-4114-97c3-35bbb1b07915">




</br>
</br>
