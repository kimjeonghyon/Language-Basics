setwd('c:/temp/jason')
rm(list=ls())
##############################################################################################################
# 파일 읽기
suppressMessages(library(tidyverse)) 
suppressMessages(library(Hmisc))
suppressMessages(library(lubridate))
suppressMessages(library(data.table))

options(scipen = 999)

setwd("C:/temp/jason")

# 300 사용일자 12.08 전체 추출
df.300 <- read.csv('./data/tbaad300_20181208.csv', header = TRUE, 
                   stringsAsFactors=F)
# 320 사용일자 12.08 1% 표본 추출 
df.320 <- read.csv('./data/tbaad320_20181208.csv', header = TRUE, 
                   stringsAsFactors=F)

#####################################################################
# 모든 데이터가 NULL 인 Column 제거
df.300 <- df.300 %>% 
  select (
    -LINE_ID
    ,-BEF_ZONE_CD
    ,-DELAY_SETTM_DT
    ,-BUS_STOP_ID
    ,-VADT_TRANSM_SEQ
    ,-PROFILE_AREA_CD   
    ,-DRIVER_MANIPLTR_ID
  )


df.320 <- df.320 %>% 
  select (
    -BEF_ZONE_CD
    ,-DELAY_SETTM_DT
    ,-LINE_ID
    ,-VADT_TRANSM_SEQ
    ,-PROFILE_AREA_CD
    ,-DRIVER_MANIPLTR_ID
    ,-TELMT_LINE_ID 
  )


#####################################################################
# 모든 데이터가 값이 1개인 (NULL or 0 or N) Column 제거

df.300 <- df.300 %>% 
  select ( 
    -BEF_DRIVER_MANIPLTR_ID
    ,-CANCEL_BEF_TRNSCTN_SEQ
    ,-PASS_ABNRM_CD1
    ,-PASS_ABNRM_CD2
    ,-HSM_AUTH_RSLT_CD
    ,-DESTINATION_ZONE_CD
  )


df.320 <- df.320 %>% 
  select (
    -BEF_DRIVER_MANIPLTR_ID
    ,-PASS_ABNRM_CD1
    ,-PASS_ABNRM_CD2
    ,-HSM_AUTH_RSLT_CD
    ,-REGISTR_ID
    ,-STAFF_CARD_SUB_TYPE_CD
    ,-TRNSCTN_VALID_YN
    ,-DAILY_CLOSING_YN
    ,-DESTINATION_ZONE_CD
  ) 


# 300 : 범주화, 컬럼 추가 
df.300 <-df.300 %>% 
  mutate(device_id2 = str_pad(DEVICE_ID,9,pad='0'), 
         device_cd = substr(device_id2,1,2),
         device_gb = factor(device_cd, levels = c("01","04","22","23"),
                            labels = c("GATE",
                                       "SCVM",
                                       "OVMC",
                                       "OSCVM")),
         bef_device_id2 = str_pad(BEF_DEVICE_ID,9,pad='0'), 
         bef_device_cd = substr(bef_device_id2,1,2),
         bef_device_gb = factor(bef_device_cd, levels = c("01","04","22","23"),
                                labels = c("GATE",
                                           "SCVM",
                                           "OVMC",
                                           "OSCVM")),
         FARE_MEDIA_TYPE = factor(FARE_MEDIA_TYPE_CD, levels=c("7","8"),labels = c("Multiple","Desfire")),
         TRFFMEAN_GROUP = factor(TRFFMEAN_GROUP_CD, levels = c("1","2","3","4"),
                                 labels = c("Bus","Metro","Tram","Suburban"), ordered = T),
         FARE_PROFILE = factor (FARE_PROFILE_CD, levels=c("1","2","3","4","5","6","7"),
                                labels = c("Full","Free","80% DC","Child","50% DC","25% DC","15% DC")),
        sCARD_NUM = paste0("'", CARD_NUM),
        sUSE_DATE = paste0("'", USE_DATE),
        sBEF_USE_DATE = paste0("'", BEF_USE_DATE)
  )

# 320 : 범주화, 컬럼 추가
df.320 <-df.320 %>% 
  mutate(device_id2 = str_pad(DEVICE_ID,9,pad='0'), 
         device_cd = substr(device_id2,1,2),
         device_gb = factor(device_cd, levels = c("01","04","22","23"),
                            labels = c("GATE",
                                       "SCVM",
                                       "OVMC",
                                       "OSCVM")),
         bef_device_id2 = str_pad(BEF_DEVICE_ID,9,pad='0'), 
         bef_device_cd = substr(bef_device_id2,1,2),
         bef_device_gb = factor(bef_device_cd, levels = c("01","04","22","23"),
                                labels = c("GATE",
                                           "SCVM",
                                           "OVMC",
                                           "OSCVM")),
         FARE_MEDIA_TYPE = factor(FARE_MEDIA_TYPE_CD, levels = c("7","8"), labels = c("Multiple","Desfire")),
         PASS_TYPE = factor(PASS_TYPE_CD, levels = c("1","2","5","6","7","8","9","A"), 
                            labels = c("Period",
                                       "Count",
                                       "Time Single",
                                       "Time Round-Trip",
                                       "Period + Airport",
                                       "Period OD",
                                       "Time OD Single",
                                       "Time OD Round-Trip")),
         TRFFMEAN_GROUP = factor(TRFFMEAN_GROUP_CD, levels = c("1","2","3","4"),
                                 labels = c("Bus","Metro","Tram","Suburban"), ordered = T),
         FARE_PROFILE = factor (FARE_PROFILE_CD, levels=c("1","2","3","4","5","6","7"),
                                labels = c("Full","Free","80% DC","Child","50% DC","25% DC","15% DC")),

         PROD_GROUP = factor (PROD_GROUP_ID, levels=c("11","15","31","33","36","42","52","55","60","90","92"),
                              labels = c("24 hours","5 Days","30 Days","90 Days","180 Days","365 Days",
                                         "2 Trips","5 Trips","10+1 Trips",
                                         "30 Days Unemployed","90 Days Disabled")),
         sCARD_NUM = paste0("'", CARD_NUM),
         sUSE_DATE = paste0("'", USE_DATE),
         sBEF_USE_DATE = paste0("'", BEF_USE_DATE)
         )

# use_day : 사용일 컬럼 추가
df.300 <- df.300 %>% 
  mutate(use_day = substr(USE_DATE, 1,8),
         bef_use_day = substr(BEF_USE_DATE, 1,8)) 

df.320 <- df.320 %>% 
  mutate(use_day = substr(USE_DATE, 1,8),
         bef_use_day = substr(BEF_USE_DATE, 1,8)) 
         

# 카드번호, 사용일자로 정렬
df.300 <- df.300 %>% 
  arrange(sCARD_NUM, sUSE_DATE)

df.320 <- df.320 %>% 
  arrange(sCARD_NUM, sUSE_DATE)

# sort : sCard, use_day, TRNSCTN_ID, TRNSFR_CNT, BOARDNG_DISEMBRK_CD
# df.300 <- df.300 %>% 
#   arrange(sCARD_NUM, use_day, TRNSCTN_ID, TRNSFR_CNT, BOARDNG_DISEMBRK_CD)
# 
# df.320 <- df.320 %>% 
#   arrange(sCARD_NUM, use_day, TRNSCTN_ID, TRNSFR_CNT, BOARDNG_DISEMBRK_CD)


# accm_use_amt_m : ACCM_USE_AMT 100배 오류 보정
df.300 <- df.300 %>% 
  mutate(accm_use_amt_m = ifelse(ACCM_USE_AMT > 10, ACCM_USE_AMT/100,ACCM_USE_AMT))
df.320 <- df.320 %>% 
  mutate(accm_use_amt_m = ifelse(ACCM_USE_AMT > 10, ACCM_USE_AMT/100,ACCM_USE_AMT))




##############################################################################################################
# 초기화 작업 끝!
##############################################################################################################

##############################################################################################################
# 코드 마스터 조회하기
##############################################################################################################
# 카드 프로파일 AA034
# PROD_GROUP_ID AA027
# FARE 프로파일 AA029
# 장비 구분 코드 AF002
df.master <- read.csv('./data/tbaed141.csv', header = TRUE, stringsAsFactors=F)
df.master %>% 
  filter(COMN_CD == "AF002") %>% 
  dplyr::select (COMN_DETAIL_CD, COMN_DETAIL_CD_EN_NM) %>% 
  arrange(COMN_DETAIL_CD)
##############################################################################################################
# 코드 마스터 조회하기 끝! 
##############################################################################################################

##############################################################################################################
# 카드번호별 전후 데이터 비교를 위한 샘플링  
##############################################################################################################
# - 320 을 다른 파일에서 읽어 들인다. 800 도 추가했다.

##############################################################################################################
# 규모 파악 
# 무작위 샘플링이 아닌 카드번호에 따른 샘플링을 하고자 한다. (전후데이터 이어 보기)
# 적당한 볼륨의 카드 prefix 정하기 
table(
  df.320 %>% 
    filter(CARD_NUM %like% "F", PASS_TYPE_CD == "2") %>% 
    mutate(prefix = substr(CARD_NUM,1,1)) %>%
    select(prefix))

#########
# 원장 샘플링
# 1% 카드번호만 있는 파일 
df.800 <- read.csv('./data/tbaad800_20181114_closedt_cardno_only.csv', header = TRUE, 
                            stringsAsFactors=F)
table(
  df.800 %>% 
    filter(CARD_NUM %like% "30010100210") %>% 
    mutate(prefix = substr(CARD_NUM,1,11)) %>%
    select(prefix))

####################################################################################
# 오라클 db에서 내려받는 데이터를 합쳐서 df.320을 만든다. 
# Period 샘플링 데이터_1
# pass period(1) - multiple (7) : F804 로 시작하는 카드 전체, 12/08 1일치
df.320.period.m <- read.csv('./data/tbaad320_20181208_period_multiple.csv', header = TRUE, 
                         stringsAsFactors=F)


# pass period(1) - desfire (8)  : 30010100210 로 시작하는 카드 전체, 12/08 1일치
df.320.period.d <- read.csv('./data/tbaad320_20181208_period_desfire.csv', header = TRUE, 
                         stringsAsFactors=F)

df.320 <- rbind(df.320.period.m, df.320.period.d)
rm(df.320.period.m)
rm(df.320.period.d)
################################################################################################
# Period 샘플링 데이터_2
# pass period(1) - multiple (7) : F80462 로 시작하는 카드 전체, 2018년 전체
df.320.period.m <- read.csv('./data/tbaad320_20181114_period_multiple_2018.csv', header = TRUE, 
                            stringsAsFactors=F)


# pass period(1) - desfire (8)  : 300101002100 로 시작하는 카드 전체, 2018년 전체
df.320.period.d <- read.csv('./data/tbaad320_20181114_period_desfire_2018.csv', header = TRUE, 
                            stringsAsFactors=F)

df.320 <- rbind(df.320.period.m, df.320.period.d)
rm(df.320.period.m)
rm(df.320.period.d)

#########################################################################################
# CBT 샘플링 데이터 
# pass cbt(2) - multiple (7) : F8046 로 시작하는 카드 전체, 12/08 1일치 
df.320.cbt.m <- read.csv('./data/tbaad320_20181208_cbt_multiple.csv', header = TRUE, 
                         stringsAsFactors=F)


# pass cbt(2) - desfire (8)  : 300101002 로 시작하는 카드 전체, 12/08 1일치 
df.320.cbt.d <- read.csv('./data/tbaad320_20181208_cbt_desfire.csv', header = TRUE, 
                         stringsAsFactors=F)

df.320 <- rbind(df.320.cbt.m, df.320.cbt.d)
rm(df.320.cbt.m)
rm(df.320.cbt.d)

#########################################################################################
# Time Single 샘플링 데이터 
# pass time single(5) - multiple (7) : F8046 로 시작하는 카드 전체, 12/08 1일치 
df.320.ts.m <- read.csv('./data/tbaad320_20181208_ts_multiple.csv', header = TRUE, 
                         stringsAsFactors=F)

# pass time single(5) - desfire (8)  : 3 로 시작하는 카드 전체, 12/08 1일치 
df.320.ts.d <- read.csv('./data/tbaad320_20181208_ts_desfire.csv', header = TRUE, 
                         stringsAsFactors=F)

df.320 <- rbind(df.320.ts.m, df.320.ts.d)
rm(df.320.ts.m)
rm(df.320.ts.d)

#########################################################################################
# 원장 샘플링 데이터 
# F8046 로 시작하는 카드 전체, 12/08 1일치 
df.800.m <- read.csv('./data/tbaad800_20181208_multiple.csv', header = TRUE, 
                        stringsAsFactors=F)

# 30010100210 로 시작하는 카드 전체, 12/08 1일치 
df.800.d <- read.csv('./data/tbaad800_20181208_desfire.csv', header = TRUE, 
                     stringsAsFactors=F)

df.800 <- rbind(df.800.m, df.800.d)
rm(df.800.m)
rm(df.800.d)


rm(list=ls())
setwd('c:/temp/jason/')

#       7     8
# 1   359 12643
# 2  2685  1078
# 5  1608    82
# 6     6     0
# 7    38     0

# 누락 - 카드기준 
#  sCARD_NUM, USE_DATE, BEF_USE_DATE, CARD_TRNSCTN_SEQ
#  누락 기준 : 직전사용일시의 거래가 없음. 
#  오류 거래 제외 : 공통 - 시간 역전 제외
#  1. SVT 거래: period 의 하차 패널티 거래 제외 하고 누락 확인 
#  2. Period 거래 : 
#    2.1 desfire : 카드번호별 Period 거래와 SVT Period 패널티 하차 거래 조합하여 누락 확인
#    2.2 multiple : 카드번호별 Period 거래 누락 확인 
#  3. CBT 거래 : 
#    3.1 desfire : 카드번호별 CBT 거래와 SVT 거래 조합하여 누락 확인
#    3.2 multiple : 카드번호별 CBT 거래 누락 확인

# 분석 시 참고 사항
# CARD_TRNSCTN_SEQ
# Desfire : 무조건 1증가
# Multiple : 카드에 writing 할 때만 1증가
# - period (1) / timeSingle(5) : 상품 충전 후 첫 사용시만 증가
# - CBT : Trip의 변동이 생길 때만 증가 ( use_trips = 1) 
# - Time Round /Airport : 위 두가지 조합
################################################################################################

# 원장으로 확인
df.800 <- df.800 %>% 
  mutate(TRNSCTN_DATE = as.character(TRNSCTN_DATE),
         BEF_TRNSCTN_DATE = as.character(BEF_TRNSCTN_DATE))

# 정렬
df.800 <- df.800 %>% 
  arrange(CARD_NUM, CARD_TRNSCTN_SEQ, TRNSCTN_DATE)

# group by sCARD_NUM
df.800 <- df.800 %>% 
  group_by (CARD_NUM)

# 윈도우 컬럼
df.800 <- df.800 %>% 
  mutate (td_lag = lag(TRNSCTN_DATE,1),
          bef_td_lag = lag(BEF_TRNSCTN_DATE,1),
          card_trnsctn_seq_lag = lag(CARD_TRNSCTN_SEQ,1))

df.800 %>% 
  filter(!is.na(td_lag),BEF_TRNSCTN_DATE != td_lag,BEF_TRNSCTN_DATE != bef_td_lag) %>% 
  select (CARD_NUM, TRNSCTN_DATE, BEF_TRNSCTN_DATE, CARD_TRNSCTN_SEQ,card_trnsctn_seq_lag,INTEG_TRNSCTN_DETAIL_CLASS_CD,DEVICE_ID,BEF_TRFFMEAN_GROUP_CD,BEF_TRFFMEAN_CD)










#  1. SVT 거래: period 의 하차 패널티 거래 제외 하고 누락 확인 

# 하차 패널티 제외 
tempcards <- df.300 %>% 
  filter(PENAL_AMT > 0) %>% 
  select(sCARD_NUM) %>% 
  distinct(sCARD_NUM)

df.300 <- df.300 %>% 
  filter(!sCARD_NUM %in% tempcards$sCARD_NUM)

# 누락 확인
# group by sCARD_NUM
df.300 <- df.300 %>% 
  group_by (sCARD_NUM)

# 정렬기준 : 카드번호, 카드거래일련번호, 사용일자
df.300 <- df.300 %>% 
  arrange(sCARD_NUM, CARD_TRNSCTN_SEQ, sUSE_DATE)

# 윈도우 컬럼
df.300 <- df.300 %>% 
  mutate (use_date_lag = lag(sUSE_DATE,1),
          bef_date_lag = lag(sBEF_USE_DATE,1),
          card_trnsctn_seq_lag = lag(CARD_TRNSCTN_SEQ,1))

write.csv(
df.300 %>% 
  filter(!is.na(use_date_lag),sBEF_USE_DATE != use_date_lag,sBEF_USE_DATE != bef_date_lag) %>% 
  select (sCARD_NUM, sUSE_DATE, sBEF_USE_DATE, CARD_TRNSCTN_SEQ,card_trnsctn_seq_lag,BOARDNG_DISEMBRK_CD,DEVICE_ID,BEF_TRFFMEAN_GROUP_CD,BEF_DEVICE_ID)
 , 'missing.csv')



################################################################################################
#  2. Period 거래 : 
#    2.1 desfire : 카드번호별 Period 거래와 SVT Period 패널티 하차 거래 조합하여 누락 확인
df.320 <- df.320.period.d
rm(df.320.period.d)

tempcards <- df.320 %>% 
  select (sCARD_NUM) %>% 
  distinct(sCARD_NUM)

# 2건
df.300 <- df.300 %>% 
  filter(sCARD_NUM %in% tempcards$sCARD_NUM)

# 거래 합치기 
df <- rbind(
df.320 %>% 
  select (sCARD_NUM, sUSE_DATE, sBEF_USE_DATE, CARD_TRNSCTN_SEQ,BOARDNG_DISEMBRK_CD,DEVICE_ID,BEF_TRFFMEAN_GROUP_CD,BEF_DEVICE_ID)
,df.300 %>% 
  select (sCARD_NUM, sUSE_DATE, sBEF_USE_DATE, CARD_TRNSCTN_SEQ,BOARDNG_DISEMBRK_CD,DEVICE_ID,BEF_TRFFMEAN_GROUP_CD,BEF_DEVICE_ID)
)

# 누락 확인
# group by sCARD_NUM
df <- df %>% 
  group_by (sCARD_NUM)

# 정렬기준 : 카드번호, 카드거래일련번호, 사용일자
df <- df %>% 
  arrange(sCARD_NUM, CARD_TRNSCTN_SEQ, sUSE_DATE)

# 윈도우 컬럼
df <- df %>% 
  mutate (use_date_lag = lag(sUSE_DATE,1),
          bef_date_lag = lag(sBEF_USE_DATE,1),
          card_trnsctn_seq_lag = lag(CARD_TRNSCTN_SEQ,1))

write.csv(
df %>% 
    filter(!is.na(use_date_lag),sBEF_USE_DATE != use_date_lag,sBEF_USE_DATE != bef_date_lag) %>% 
    select (sCARD_NUM, sUSE_DATE, sBEF_USE_DATE, CARD_TRNSCTN_SEQ,card_trnsctn_seq_lag,BOARDNG_DISEMBRK_CD,DEVICE_ID,BEF_TRFFMEAN_GROUP_CD,BEF_DEVICE_ID)
  , 'missing.csv')

################################################################################################
# 2.2 multiple : 카드번호별 Period 거래 누락 확인 
rm(list = ls())
df.320 <- df.320.period.m
rm(df.320.period.m)

# 누락 확인
# group by sCARD_NUM
df.320 <- df.320 %>% 
  group_by(sCARD_NUM)

# 정렬기준 : 카드번호, 카드거래일련번호, 사용일자
df.320 <- df.320 %>% 
  # arrange(sCARD_NUM, CARD_TRNSCTN_SEQ, sUSE_DATE)
  arrange(sCARD_NUM, sUSE_DATE)
# 윈도우 컬럼
df.320 <- df.320 %>% 
  mutate (use_date_lag = lag(sUSE_DATE,1),
          bef_date_lag = lag(sBEF_USE_DATE,1),
          card_trnsctn_seq_lag = lag(CARD_TRNSCTN_SEQ,1))

df.missing <- df.320 %>% 
  filter(!is.na(use_date_lag),sBEF_USE_DATE != use_date_lag,sBEF_USE_DATE != bef_date_lag,
         BEF_USE_DATE != "19700101085959",
         BEF_USE_DATE != "0") %>% 
  select (sCARD_NUM, sUSE_DATE, sBEF_USE_DATE,BOARDNG_DISEMBRK_CD,DEVICE_ID,BEF_TRFFMEAN_GROUP_CD,BEF_DEVICE_ID)
write.csv(
  df.missing 
, 'missing.csv')


################################################################################################
#  3. CBT 거래 : 
#    3.1 desfire : 카드번호별 CBT 거래와 SVT 거래 조합하여 누락 확인
df.320 <- df.320.cbt.d
rm(df.320.cbt.d)

tempcards <- df.320 %>% 
  select (sCARD_NUM) %>% 
  distinct(sCARD_NUM)

# 2건
df.300 <- df.300 %>% 
  filter(sCARD_NUM %in% tempcards$sCARD_NUM)

# 거래 합치기 
df <- rbind(
  df.320 %>% 
    select (sCARD_NUM, sUSE_DATE, sBEF_USE_DATE, CARD_TRNSCTN_SEQ,BOARDNG_DISEMBRK_CD,DEVICE_ID,BEF_TRFFMEAN_GROUP_CD,BEF_DEVICE_ID)
  ,df.300 %>% 
    select (sCARD_NUM, sUSE_DATE, sBEF_USE_DATE, CARD_TRNSCTN_SEQ,BOARDNG_DISEMBRK_CD,DEVICE_ID,BEF_TRFFMEAN_GROUP_CD,BEF_DEVICE_ID)
)

# 누락 확인
# group by sCARD_NUM
df <- df %>% 
  group_by (sCARD_NUM)

# 정렬기준 : 카드번호, 카드거래일련번호, 사용일자
df <- df %>% 
  arrange(sCARD_NUM, CARD_TRNSCTN_SEQ, sUSE_DATE)

# 윈도우 컬럼
df <- df %>% 
  mutate (use_date_lag = lag(sUSE_DATE,1),
          bef_date_lag = lag(sBEF_USE_DATE,1),
          card_trnsctn_seq_lag = lag(CARD_TRNSCTN_SEQ,1))

df.missing <- df %>% 
  filter(!is.na(use_date_lag),sBEF_USE_DATE != use_date_lag,sBEF_USE_DATE != bef_date_lag,
         sBEF_USE_DATE != "19700101085959",
         sBEF_USE_DATE != "0") %>% 
  select (sCARD_NUM, sUSE_DATE, sBEF_USE_DATE, CARD_TRNSCTN_SEQ,card_trnsctn_seq_lag,BOARDNG_DISEMBRK_CD,DEVICE_ID,BEF_TRFFMEAN_GROUP_CD,BEF_DEVICE_ID)

write.csv(
  df.missing
   , 'missing.csv')

################################################################################################
#    3.2 multiple : 카드번호별 CBT 거래 누락 확인
rm(list=ls())
df.320 <- df.320.cbt.m
rm(df.320.cbt.m)

# 누락 확인
# group by sCARD_NUM
df.320 <- df.320 %>% 
  group_by(sCARD_NUM)

# 정렬기준 : 카드번호, 사용일자
df.320 <- df.320 %>% 
  arrange(sCARD_NUM, sUSE_DATE)

# 윈도우 컬럼
df.320 <- df.320 %>% 
  mutate (use_date_lag = lag(sUSE_DATE,1),
          use_date_lag2 = lag(sUSE_DATE,2),
          use_date_lag3 = lag(sUSE_DATE,3),
          use_date_lag4 = lag(sUSE_DATE,4),
          bef_date_lag = lag(sBEF_USE_DATE,1),
          card_trnsctn_seq_lag = lag(CARD_TRNSCTN_SEQ,1))


df.missing <- df.320 %>% 
  filter(!is.na(use_date_lag),sBEF_USE_DATE != use_date_lag,sBEF_USE_DATE != bef_date_lag,
         sBEF_USE_DATE != use_date_lag2,
         sBEF_USE_DATE != use_date_lag3,
         sBEF_USE_DATE != use_date_lag4,
         sBEF_USE_DATE != "19700101085959",
         sBEF_USE_DATE != "0")%>% 
  select (sCARD_NUM, sUSE_DATE, sBEF_USE_DATE,use_date_lag,CARD_TRNSCTN_SEQ,TRNSCTN_ID, TRNSFR_CNT, card_trnsctn_seq_lag, BEGIN_USE_DATE, TRFFMEAN_GROUP, DEVICE_ID, BEF_TRFFMEAN_GROUP_CD, BEF_DEVICE_ID)
          #BOARDNG_DISEMBRK_CD,DEVICE_ID,BEF_TRFFMEAN_GROUP_CD,BEF_DEVICE_ID)

View(
df.320 %>% 
  filter(sCARD_NUM == "'F804D023B2B45D84")%>% 
  select (sCARD_NUM, sUSE_DATE, sBEF_USE_DATE,use_date_lag,CARD_TRNSCTN_SEQ, device_gb, TRFFMEAN_GROUP, DEVICE_ID, BEF_TRFFMEAN_GROUP_CD, BEF_DEVICE_ID)
)
#BOARDNG_DISEMBRK_CD,DEVICE_ID,BEF_TRFFMEAN_GROUP_CD,BEF_DEVICE_ID)

write.csv(
  df.missing 
  , 'missing.csv')

