
# Trip Together

<img src="https://github.com/JeongKiKi/TripTogether/assets/125369115/ca11c0de-dc10-4e91-9636-448cfa7832d9" width="300" height="300">
<br>

## 프로젝트 기간
2024.5.20 ~ 2024.6.24


<br>


##  프로젝트 소개 
### 나만 알고 있는 여행장소를 추천해주는 어플
Trip Together는 소셜미디어로 다른 유저와 경험을 공유할 수 있습니다.<br>
<br>

1. 다양한 여행지를 확인할수 있습니다. <br>
    <br>

2. 좋아요 기능으로 내가 가고 싶은 장소를 한 번에 찾아볼 수 있습니다. <br>
    <br>

3.  마이페이지에서 닉네임 변경, 게시물 수정, 회원탈퇴가 가능합니다. <br>
    <br><br>
   
### 프로젝트 목표
잘 알려지지 않은 여행지를 공유하며 유저들에게 새로운 여행정보를 추천해 주는 것이 목표입니다. 
<br>


##  구현 기능
0. **주요 기능**
   - firebaseAuth로 회원가입, 로그인 관리.
   - firebaseDatabase로 회원정보, 게시물 관리.
   - firebaseStorage으로 게시물의 사진 관리.
   - MVVM 패턴 적용중
   
   <br>

1. **메인 페이지**
   - 유저들의 추천 여행지를 사진과 텍스트로 표현
   - 좋아요 기능으로 좋아요 페이지에 모아서 확인 가능
   <br>

2. **좋아요 페이지**
   - 자신이 좋아요한 게시물 표시 

   <br>
   
3. **마이 페이지**
   - 다른 유저의 게시물에 대한 좋아요 수 확인과 자신이 올린 게시물의 갯수와 총 종아요 수 확인 가능
   - 유저가 올린 게시물을 확인 및 수정 가능
   - 유저 탈퇴, 닉네임 변경 기능
   - 로그아웃 기능

   <br>

   <br> 트러블 슈팅
   - 메인화면에서 사진을 불러올때 사진 버벅 거리는 현상발생
       - 이미지 캐싱을 통해 미리 저장된 사진은 통신을 통해 가져오지 않아서 오류 해결
  
   - 파이어베이스 사용하면서 규칙을 설정하지 않아서 일정 기간 뒤에 연동이 되지않는 문제 발생
       - 파이어베이스 규칙을 설정하여 문제 해결
   - MVC 학습을 위해 기존 코드를 MVC패턴으로 리펙토링
   - 게시물 수정할때 사진을 바꾸면 새로운 사진으로 업데이트 되지 않는 현상 발생
       - 기존 이미지에 대한 값을 가지고 그에 따른 변경 사항에 대한 비지니스 로직 변경
   - 초기에 설정한 좋아요는 Int값이였는데 배열로 수정
    <br>
##  Tech Stack
<img src="https://img.shields.io/badge/Xcode-147EFB?style=for-the-badge&logo=Xcode&logoColor=white"/></a>
<img src="https://img.shields.io/badge/Swift-F05138?style=for-the-badge&logo=Swift&logoColor=white"/></a>
<img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=Firebase&logoColor=white"/></a>
<br><br>
##  라이브러리 사용, 이유
 ***SnapKit*** <br>
    Auto Layout을 쉽게 설정하기 위해 사용   
<br>
 ***Firebase*** <br>
    유저 데이터, 유저가 생성한 콘텐츠 데이터 저장을 위해 사용
<br>
## 앱 
### 앱 시연영상
- [Trip Together](https://www.youtube.com/watch?v=RC5WamosELo)

### 앱 캡쳐본
<img src="https://github.com/JeongKiKi/WordMemory/assets/125369115/380aef7a-7694-407f-82d5-f0ab5e08a40b" width="150" height="300"/>
<img src="https://github.com/JeongKiKi/WordMemory/assets/125369115/8a6f7c7b-c4f4-4f06-add7-60a7d1473cec" width="150" height="300"/>
<img src="https://github.com/JeongKiKi/WordMemory/assets/125369115/96ed45fb-02d9-4a4e-9f53-f6f40558879f" width="150" height="300"/>
<img src="https://github.com/JeongKiKi/WordMemory/assets/125369115/a1adfce2-0857-4f33-aa4f-d7e0450ee5fb" width="150" height="300"/>
<img src="https://github.com/JeongKiKi/WordMemory/assets/125369115/d38045b2-d2c5-40cf-b961-98b32bc60327" width="150" height="300"/>
<img src="https://github.com/JeongKiKi/WordMemory/assets/125369115/cba56173-c089-40e8-902a-c619be01172c" width="150" height="300"/>
<img src="https://github.com/JeongKiKi/WordMemory/assets/125369115/af1725b7-6300-464e-8cc8-c877cee8a237" width="150" height="300"/>
<img src="https://github.com/JeongKiKi/WordMemory/assets/125369115/29e08979-0229-4e6c-987f-864de969f391" width="150" height="300"/>
<img src="https://github.com/JeongKiKi/WordMemory/assets/125369115/734fb93e-7898-4a7c-8739-798c235e5818" width="150" height="300"/>
<img src="https://github.com/JeongKiKi/WordMemory/assets/125369115/2aa44c5d-a531-44da-95d2-4a63410db405" width="150" height="300"/>
<img src="https://github.com/JeongKiKi/WordMemory/assets/125369115/8de18ce0-05fc-4c85-81a5-5d0a5545f73a" width="150" height="300"/>
<img src="https://github.com/JeongKiKi/WordMemory/assets/125369115/4a7e41ba-a37b-4eda-806a-36eafceb33a9" width="150" height="300"/>


