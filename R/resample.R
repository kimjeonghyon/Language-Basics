1) Excel  or DB상에서 통계분석 예정 데이터를  리샘플링 처리함

     : 결손값 및 이상치 값 처리 동시 진행 가능

2) 1)에서 데이터 리 샘플링한 결과 값을 .CSV 파일로 생성해서 (read.csv())  명령어 이용 R로 업로드 후 통계분석 수행

3) 실습

     3.1) R Local 작업 디렉토리에 Excel or DB상 리샘플링한 테스트를 해당 디렉토리에  .cdv파일로 저장

     3.2)  >   x <- read.csv("a.csv")  명령어로 R 메모리로 데이터 업로드 처리함. (데이터 프레임으로 저장됨)

             : 문자형 데이터가 범주형(Factor)로 저장될 수 있으므로 Option 명령어 stringsAsFactors= FALSE 지정

             : >x <- read.csv("a.csv", stringsAsFactors = FALSE)

     3.3) 데이터 업로드 후 통계 분석 진행

     3.4)

################## 데이터 불균형 만들기 #######################

data()                                                               #  R 내장 dataset 보기  

data(iris)                                                          # data 불러오기

iris_data = iris                                                  # data 불러와서 변수 저장
summary(iris_data )                                         # data 요약 정보
head(iris_data)                                                 # data 일부 확인
iris_data$Y <- 0                                               # data 내에 0을 갖는 컬럼 Y 추가
iris_data$Y[iris_data$Species=='setosa'] = 1  # Species가 setosa인 data는 Y를 1로 바꿈
table(iris_data$Y)                                             # 테이블로 데이터 불균형 확인
barplot(table(iris_data$Y))                               # 바플랏으로 데이터 불균형 확인




################## 데이터 균형 만들기 #######################

1) Under Sampling( Versicolor, Virginica  기준)

ind = sample(51:150,50)
X1 = data[ind,]
new_data = rbind(X1, iris_data[1:50,])            #  데이터 균형 확인 생성


table(iris_data$Y)                                            # 테이블로 데이터 불균형 확인
table(new_data$Y)                                          # 테이블로 데이터 균형 확인

new_data                                                         # 데이터 균형 확인


2) Over Sampling( Setosa 기준)

new_data2 = rbind(iris_data, iris_data[1:50,])
table(new_data2$Y)

new_data2                                                       # 데이터 균형 확인
