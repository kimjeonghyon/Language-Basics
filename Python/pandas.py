%matplotlib inline
import pandas as pd
import numpy as np


# 300 사용일자 11.14 전체 추출
df300 = pd.read_csv('./data/tbaad300_20181114.csv', sep=",")
# 320 사용일자 11.14 1% 표본 추출 
df320 = pd.read_csv('./data/tbaad320_20181114.csv', sep=",")

# pass period(1) - desfire (8)  : 30010100210 로 시작하는 카드 전체, 11/14 1일치
# df320period_d = pd.read_csv('./data/tbaad320_20181114_period_desfire.csv', dtype='unicode')
df320period_d[['CARD_NUM']].query("CARD_NUM.str.startswith('3')").tail()
# 규모 파악 
# 무작위 샘플링이 아닌 카드번호에 따른 샘플링을 하고자 한다. (전후데이터 이어 보기)
# 적당한 볼륨의 카드 prefix 정하기 
df320.\
    query("CARD_NUM.str.startswith('F804') & PASS_TYPE_CD == '2'").\
    assign(prefix = lambda x: x.CARD_NUM.str[:5]).groupby('prefix')[['prefix']].count()

# Period 샘플링 데이터_1
# pass period(1) - multiple (7) : F804 로 시작하는 카드 전체, 11/14 1일치
df320period_m = pd.read_csv('./data/tbaad320_20181114_period_multiple.csv', dtype='unicode')


# pass period(1) - desfire (8)  : 30010100210 로 시작하는 카드 전체, 11/14 1일치
df320period_d = pd.read_csv('./data/tbaad320_20181114_period_desfire.csv', dtype='unicode')

df320 = pd.concat([df320period_m, df320period_d])
del df320period_m
del df320period_d

#########
# 원장 샘플링
# 1% 카드번호만 있는 파일 
df800 = pd.read_csv('./data/tbaad800_20181114_closedt_cardno_only.csv')
df800.\
    query("CARD_NUM.str.startswith('30010100210')").\
    assign(prefix = lambda x: x.CARD_NUM.str[:12]).groupby('prefix')[['prefix']].count()


# 카드 프로파일 AA034 
# PROD_GROUP_ID AA027, DETAIL AA028
# FARE 프로파일 AA029
# 장비 구분 코드 AF002
df_master = pd.read_csv('./data/tbaed141.csv', encoding = "cp1252")

df_master.\
    query("COMN_CD == 'AA027'")\
    [['COMN_DETAIL_CD', 'COMN_DETAIL_CD_EN_NM']].\
    sort_values(['COMN_DETAIL_CD'])

# 모든 데이터가 값이 1개인 (NULL or 0 or N) Column 제거
df300 = df300.drop(['BEF_DRIVER_MANIPLTR_ID','CANCEL_BEF_TRNSCTN_SEQ','PASS_ABNRM_CD1','PASS_ABNRM_CD2','HSM_AUTH_RSLT_CD','DESTINATION_ZONE_CD'],1)
df320 = df320.drop(['BEF_DRIVER_MANIPLTR_ID','PASS_ABNRM_CD1','PASS_ABNRM_CD2','HSM_AUTH_RSLT_CD','REGISTR_ID','STAFF_CARD_SUB_TYPE_CD','TRNSCTN_VALID_YN','DAILY_CLOSING_YN','DESTINATION_ZONE_CD'],1)

# 300 : 범주화, 컬럼 추가 
df300 = df300.assign(device_id2 = lambda x: x.DEVICE_ID.astype('str').str.zfill(9)).\
    assign(device_cd = lambda x: x.device_id2.str[:2]).\
    assign(device_gb = lambda x: pd.Categorical(x.device_cd, categories=["01","04","22","23"], ordered=False)).\
    assign(bef_device_id2 = lambda x: x.BEF_DEVICE_ID.astype('str').str.zfill(9)).\
    assign(bef_device_cd = lambda x: x.bef_device_id2.str[:2]).\
    assign(bef_device_gb = lambda x: pd.Categorical(x.bef_device_cd, categories=["00","01","04","22","23"], ordered=False)).\
    assign(FARE_MEDIA_TYPE = lambda x: pd.Categorical(x.FARE_MEDIA_TYPE_CD, categories=[7,8], ordered=False)).\
    assign(TRFFMEAN_GROUP = lambda x: pd.Categorical(x.TRFFMEAN_GROUP_CD, categories=[1,2,3,4], ordered=True)).\
    assign(FARE_PROFILE = lambda x: pd.Categorical(x.FARE_PROFILE_CD, categories=[1,2,3,4,5,6,7], ordered=False)).\
    assign(sCARD_NUM = lambda x: "'" + x.CARD_NUM.astype('str')).\
    assign(sUSE_DATE = lambda x: "'" + x.USE_DATE.astype('str')).\
    assign(sBEF_USE_DATE = lambda x:"'" + x.BEF_USE_DATE.astype('str')).\
    assign(use_day = lambda x: x.USE_DATE.astype('str').str[:8]).\
    assign(bef_use_day = lambda x: x.BEF_USE_DATE.astype('str').str[:8])

# 300 : 범주 컬럼 라벨 변경 
df300 = df300.assign(device_gb = lambda x: x.device_gb.cat.rename_categories(["GATE","SCVM","OVMC","OSCVM"])).\
    assign(bef_device_gb = lambda x: x.bef_device_gb.cat.rename_categories(["NONE","GATE","SCVM","OVMC","OSCVM"])).\
    assign(FARE_MEDIA_TYPE = lambda x: x.FARE_MEDIA_TYPE.cat.rename_categories(["Multiple","Desfire"])).\
    assign(TRFFMEAN_GROUP = lambda x: x.TRFFMEAN_GROUP.cat.rename_categories(["Bus","Metro","Tram","Suburban"])).\
    assign(FARE_PROFILE = lambda x: x.FARE_PROFILE.cat.rename_categories(["Full","Free","80% DC","Child","50% DC","25% DC","15% DC"]))


# accm_use_amt_m : ACCM_USE_AMT 100배 오류 보정
df300 = df300.assign(accm_use_amt_m = lambda x: np.where(x.ACCM_USE_AMT > 10, x.ACCM_USE_AMT/100, x.ACCM_USE_AMT))
df320 = df320.assign(accm_use_amt_m = lambda x: np.where(x.ACCM_USE_AMT > 10, x.ACCM_USE_AMT/100, x.ACCM_USE_AMT))

# 카드번호, 사용일자로 정렬
df300 = df300.sort_values(['sCARD_NUM','sUSE_DATE'])
df320 = df320.sort_values(['sCARD_NUM','sUSE_DATE'])


# Desfire Card 의 시퀀스 조사
# 카드거래 일련번호로 정렬
df800 = df800.sort_values(['CARD_NUM', 'CARD_TRNSCTN_SEQ'])
    

# lag 함수 적용
df800['card_trnsctn_seq_lag'] = df800.groupby('CARD_NUM')['CARD_TRNSCTN_SEQ'].shift(1)
df800['itdcc_lag'] = df800.groupby('CARD_NUM')['INTEG_TRNSCTN_DETAIL_CLASS_CD'].shift(1)
df800['td_lag'] = df800.groupby('CARD_NUM')['TRNSCTN_DATE'].shift(1)
df800['rd_lag'] = df800.groupby('CARD_NUM')['REM_DAYS'].shift(1)
df800['rt_lag'] = df800.groupby('CARD_NUM')['REM_TRIPS'].shift(1)


# data 조회
df800.query("card_trnsctn_seq_lag.notnull() \
    & CARD_NUM.str.startswith('3') \
    & CARD_TRNSCTN_SEQ == card_trnsctn_seq_lag").\
    rename(columns={'INTEG_TRNSCTN_DETAIL_CLASS_CD': 'itdcc'})\
    [['CARD_NUM','itdcc','itdcc_lag','REM_DAYS','rd_lag','TRNSCTN_DATE','td_lag','REM_TRIPS','rt_lag','USE_BEGIN_DATE']]



