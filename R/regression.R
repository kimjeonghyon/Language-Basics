R - Regression modeling.
E&C AI BigData Team
2018.07.26.
This is a regression model study document of E&C AI BigData Team.
all copyrights reserved by Daeun Go :)
###.Reg. study! Start!


solution 1 : basic linear regression model
http://stat-and-news-by-daragon9.tistory.com/92

##       year       annual_salary   
##  Min.   : 1.00   Min.   : 299.0  
##  1st Qu.: 7.75   1st Qu.: 551.5  
##  Median :16.00   Median : 915.5  
##  Mean   :15.80   Mean   : 930.5  
##  3rd Qu.:23.00   3rd Qu.:1240.8  
##  Max.   :30.00   Max.   :1713.0
## [1] "Regression of year & annual salary"



## [1] "As you can see from box-plot and histogram, it might be normalized data and also symmetric"



## [1] "Normalized "
## 
##  Shapiro-Wilk normality test
## 
## data:  annual_salary
## W = 0.9656, p-value = 0.6606
## [1] "Correlation"
## [1] 0.9775856
## [1] "corr. means that we assume two factors are based on simple linear regression model."
## 
## Call:
## lm(formula = annual_salary ~ year, data = Data)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -115.282  -59.636   -3.018   37.011  215.873 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  252.375     39.766   6.346 5.59e-06 ***
## year          42.922      2.179  19.700 1.25e-13 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 89.02 on 18 degrees of freedom
## Multiple R-squared:  0.9557, Adjusted R-squared:  0.9532 
## F-statistic: 388.1 on 1 and 18 DF,  p-value: 1.25e-13
## [1] " y= 252 + 42*X "



## [1] "F-value 388.1 , p-value 1.25e-13 \nw/ significant level 0.001\nreject H0\nAlso we can see that adjusted R-square explain this model by 95.57%"
## [1] "plot shows that there is no pattern and residuals are distributed nearby 0 evenly. Also in QQ plot the points are following the line appropriately."



Normalization
## 
##  Shapiro-Wilk normality test
## 
## data:  LSE$residuals
## W = 0.92985, p-value = 0.1534
## [1] "\np-value is 0.1534 over significant level 0.05. That means normalized. \n"
## Loading required package: zoo
## 
## Attaching package: 'zoo'
## The following objects are masked from 'package:base':
## 
##     as.Date, as.Date.numeric
## 
##  Durbin-Watson test
## 
## data:  LSE
## DW = 2.0333, p-value = 0.5291
## alternative hypothesis: true autocorrelation is greater than 0
## [1] "Durbin-Watson test result shows that p-value is 0.5291 over  significant level 0.05\nSo, it is satisfied with independence"





solution 2 : Lasso / Ridge / Elastic net regression


https://www4.stat.ncsu.edu/~post/josh/LASSO_Ridge_Elastic_Net_-_Examples.html
## Loading required package: Matrix
## Loading required package: foreach
## Loaded glmnet 2.0-16
Lasso / Ridge / Elastic Net plot





## [1] "RSS(Residual sum of squares + a*(L1 : Lasso) +(1-a)*(L2 : Ridge)"
## [1] "."
## [1] "a = 0 - Ridge"
## [1] 15.35769
## [1] 2.874594
## [1] 1.70568
## [1] 1.427271
## [1] 1.360383
## [1] "a = 0.5 - Elastic"
## [1] 1.291076
## [1] 1.267447
## [1] 1.256874
## [1] 1.27702
## [1] 1.234383
## [1] "a = 1 - Lasso"
## [1] 1.264402
minimum MSE
## [1] 1.234383

solution 3 : GLM (Logistic / Poisson)
https://www.statmethods.net/advstats/glm.html

glm(formula, family=familytype(link=linkfunction), data=)

binomial (link = “logit”)
gaussian (link = “identity”)
Gamma (link = “inverse”)
inverse.gaussian (link = “1/mu^2”)
poisson (link = “log”)
quasi (link = “identity”, variance = “constant”)
quasibinomial (link = “logit”)
quasipoisson (link = “log”)
##   numeracy anxiety success degree_S
## 1      6.6    13.8       0        0
## 2      7.1    14.6       0        0
## 3      7.3    17.4       0        0
## 4      7.5    14.9       1        3
## 5      7.9    13.4       0        0
## 6      7.9    13.5       1        2
## [1] "data"
##     numeracy         anxiety         success        degree_S   
##  Min.   : 6.600   Min.   :10.10   Min.   :0.00   Min.   :0.00  
##  1st Qu.: 8.625   1st Qu.:12.93   1st Qu.:0.00   1st Qu.:0.00  
##  Median :10.600   Median :13.90   Median :1.00   Median :1.00  
##  Mean   :10.722   Mean   :13.95   Mean   :0.58   Mean   :1.06  
##  3rd Qu.:12.800   3rd Qu.:15.32   3rd Qu.:1.00   3rd Qu.:2.00  
##  Max.   :15.700   Max.   :17.70   Max.   :1.00   Max.   :3.00
## [1] "GLM (Logistic)"
## 
## Call:
## glm(formula = success ~ numeracy + anxiety, family = binomial(link = "logit"), 
##     data = A)
## 
## Deviance Residuals: 
##      Min        1Q    Median        3Q       Max  
## -1.83958  -0.30510   0.04823   0.35431   2.08545  
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)   
## (Intercept)  14.2386     6.7985   2.094  0.03623 * 
## numeracy      0.5774     0.2481   2.327  0.01995 * 
## anxiety      -1.3841     0.4804  -2.881  0.00396 **
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 68.029  on 49  degrees of freedom
## Residual deviance: 28.286  on 47  degrees of freedom
## AIC: 34.286
## 
## Number of Fisher Scoring iterations: 6
## [1] "GLM (Poisson)"
## 
## Call:
## glm(formula = success ~ numeracy + anxiety, family = poisson(link = "log"), 
##     data = A)
## 
## Deviance Residuals: 
##     Min       1Q   Median       3Q      Max  
## -1.0029  -0.6721  -0.2485   0.4367   1.0773  
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)  
## (Intercept)   1.5718     1.9909   0.790   0.4298  
## numeracy      0.1010     0.0831   1.216   0.2241  
## anxiety      -0.2443     0.1065  -2.294   0.0218 *
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for poisson family taken to be 1)
## 
##     Null deviance: 31.594  on 49  degrees of freedom
## Residual deviance: 19.865  on 47  degrees of freedom
## AIC: 83.865
## 
## Number of Fisher Scoring iterations: 5
logistic reg. plot





possion reg. plot






solution 4 : Non-linear


https://www.r-bloggers.com/generalized-additive-models/
## Loading required package: gam
## Loading required package: splines
## Loaded gam 1.16
## Loading required package: ISLR
## The following object is masked _by_ .GlobalEnv:
## 
##     year
## [1] 3000   11
##        year age           maritl     race       education
## 231655 2006  18 1. Never Married 1. White    1. < HS Grad
## 86582  2004  24 1. Never Married 1. White 4. College Grad
## 161300 2003  45       2. Married 1. White 3. Some College
## 155159 2003  43       2. Married 3. Asian 4. College Grad
## 11443  2005  50      4. Divorced 1. White      2. HS Grad
## 376662 2008  54       2. Married 1. White 4. College Grad
##                    region       jobclass         health health_ins
## 231655 2. Middle Atlantic  1. Industrial      1. <=Good      2. No
## 86582  2. Middle Atlantic 2. Information 2. >=Very Good      2. No
## 161300 2. Middle Atlantic  1. Industrial      1. <=Good     1. Yes
## 155159 2. Middle Atlantic 2. Information 2. >=Very Good     1. Yes
## 11443  2. Middle Atlantic 2. Information      1. <=Good     1. Yes
## 376662 2. Middle Atlantic 2. Information 2. >=Very Good     1. Yes
##         logwage      wage
## 231655 4.318063  75.04315
## 86582  4.255273  70.47602
## 161300 4.875061 130.98218
## 155159 5.041393 154.68529
## 11443  4.318063  75.04315
## 376662 4.845098 127.11574
Wage data summary
##       year           age                     maritl           race     
##  Min.   :2003   Min.   :18.00   1. Never Married: 648   1. White:2480  
##  1st Qu.:2004   1st Qu.:33.75   2. Married      :2074   2. Black: 293  
##  Median :2006   Median :42.00   3. Widowed      :  19   3. Asian: 190  
##  Mean   :2006   Mean   :42.41   4. Divorced     : 204   4. Other:  37  
##  3rd Qu.:2008   3rd Qu.:51.00   5. Separated    :  55                  
##  Max.   :2009   Max.   :80.00                                          
##                                                                        
##               education                     region    
##  1. < HS Grad      :268   2. Middle Atlantic   :3000  
##  2. HS Grad        :971   1. New England       :   0  
##  3. Some College   :650   3. East North Central:   0  
##  4. College Grad   :685   4. West North Central:   0  
##  5. Advanced Degree:426   5. South Atlantic    :   0  
##                           6. East South Central:   0  
##                           (Other)              :   0  
##            jobclass               health      health_ins      logwage     
##  1. Industrial :1544   1. <=Good     : 858   1. Yes:2083   Min.   :3.000  
##  2. Information:1456   2. >=Very Good:2142   2. No : 917   1st Qu.:4.447  
##                                                            Median :4.653  
##                                                            Mean   :4.654  
##                                                            3rd Qu.:4.857  
##                                                            Max.   :5.763  
##                                                                           
##       wage        success  rank    
##  Min.   : 20.09   0:2047   1: 935  
##  1st Qu.: 85.38   1: 953   2:1112  
##  Median :104.92            3: 953  
##  Mean   :111.70                    
##  3rd Qu.:128.68                    
##  Max.   :318.34                    
## 
lm (linear reg.)
## 
## Call:
## lm(formula = wage ~ age + year + education + maritl + race, data = Wage)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -110.675  -19.269   -3.072   13.551  222.329 
## 
## Coefficients:
##                               Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                 -2.315e+03  6.364e+02  -3.638 0.000280 ***
## age                          3.145e-01  6.287e-02   5.003 5.99e-07 ***
## year                         1.184e+00  3.173e-01   3.730 0.000195 ***
## education2. HS Grad          1.108e+01  2.434e+00   4.552 5.53e-06 ***
## education3. Some College     2.419e+01  2.563e+00   9.438  < 2e-16 ***
## education4. College Grad     3.897e+01  2.551e+00  15.278  < 2e-16 ***
## education5. Advanced Degree  6.336e+01  2.775e+00  22.836  < 2e-16 ***
## maritl2. Married             1.840e+01  1.771e+00  10.390  < 2e-16 ***
## maritl3. Widowed             2.869e+00  8.261e+00   0.347 0.728400    
## maritl4. Divorced            4.955e+00  2.979e+00   1.663 0.096379 .  
## maritl5. Separated           1.277e+01  4.998e+00   2.556 0.010645 *  
## race2. Black                -4.697e+00  2.200e+00  -2.135 0.032867 *  
## race3. Asian                -4.409e+00  2.685e+00  -1.642 0.100668    
## race4. Other                -7.670e+00  5.847e+00  -1.312 0.189712    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 35.1 on 2986 degrees of freedom
## Multiple R-squared:  0.2954, Adjusted R-squared:  0.2923 
## F-statistic:  96.3 on 13 and 2986 DF,  p-value: < 2.2e-16









gam (generalized additive model)
## 
## Call: gam(formula = wage ~ s(age, df = 6, spar = 1) + ns(age, df = 3) + 
##     s(year, df = 6) + education + race + maritl, data = Wage)
## Deviance Residuals:
##      Min       1Q   Median       3Q      Max 
## -112.461  -19.031   -2.943   14.051  215.505 
## 
## (Dispersion Parameter for gaussian family taken to be 1204.879)
## 
##     Null Deviance: 5222086 on 2999 degrees of freedom
## Residual Deviance: 3583310 on 2974 degrees of freedom
## AIC: 29823.92 
## 
## Number of Local Scoring Iterations: 3 
## 
## Anova for Parametric Effects
##                            Df  Sum Sq Mean Sq  F value    Pr(>F)    
## s(age, df = 6, spar = 1)    1  200715  200715 166.5853 < 2.2e-16 ***
## ns(age, df = 3)             2  253946  126973 105.3824 < 2.2e-16 ***
## s(year, df = 6)             1   23488   23488  19.4942 1.045e-05 ***
## education                   4 1056122  264030 219.1344 < 2.2e-16 ***
## race                        3   12713    4238   3.5172   0.01453 *  
## maritl                      4   89725   22431  18.6171 3.986e-15 ***
## Residuals                2974 3583310    1205                       
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Anova for Nonparametric Effects
##                          Npar Df  Npar F  Pr(F)
## (Intercept)                                    
## s(age, df = 6, spar = 1)       5 1.35223 0.2394
## ns(age, df = 3)                                
## s(year, df = 6)                5 0.93958 0.4540
## education                                      
## race                                           
## maritl
## [1] 1194.437






logistic reg. (more thing)
## 
## Call:
## glm(formula = success ~ s(age, df = 6, spar = 1) + ns(age, df = 3) + 
##     s(year, df = 6) + education + maritl + race, family = binomial(link = "logit"), 
##     data = Wage)
## 
## Deviance Residuals: 
##     Min       1Q   Median       3Q      Max  
## -1.8621  -0.7252  -0.4208   0.7987   2.9905  
## 
## Coefficients: (1 not defined because of singularities)
##                               Estimate Std. Error z value Pr(>|z|)    
## (Intercept)                 -1.119e+02  4.602e+01  -2.431 0.015041 *  
## s(age, df = 6, spar = 1)     1.818e-03  1.027e-02   0.177 0.859506    
## ns(age, df = 3)1             1.986e+00  4.311e-01   4.606 4.11e-06 ***
## ns(age, df = 3)2             5.134e+00  6.814e-01   7.535 4.89e-14 ***
## ns(age, df = 3)3                    NA         NA      NA       NA    
## s(year, df = 6)              5.254e-02  2.293e-02   2.292 0.021933 *  
## education2. HS Grad          9.084e-01  2.716e-01   3.345 0.000823 ***
## education3. Some College     1.766e+00  2.722e-01   6.489 8.62e-11 ***
## education4. College Grad     2.725e+00  2.684e-01  10.155  < 2e-16 ***
## education5. Advanced Degree  3.447e+00  2.783e-01  12.384  < 2e-16 ***
## maritl2. Married             1.160e+00  1.525e-01   7.606 2.84e-14 ***
## maritl3. Widowed             6.910e-02  6.862e-01   0.101 0.919790    
## maritl4. Divorced            2.643e-01  2.374e-01   1.113 0.265545    
## maritl5. Separated           4.102e-01  4.257e-01   0.964 0.335281    
## race2. Black                -3.576e-01  1.740e-01  -2.055 0.039917 *  
## race3. Asian                 3.373e-02  1.834e-01   0.184 0.854051    
## race4. Other                -6.806e-03  5.253e-01  -0.013 0.989662    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 3750.6  on 2999  degrees of freedom
## Residual deviance: 2863.7  on 2984  degrees of freedom
## AIC: 2895.7
## 
## Number of Fisher Scoring iterations: 5






solution 5 : Comparison with each other


rf (random forest regressor)
## Loading required package: randomForest
## randomForest 4.6-14
## Type rfNews() to see new features/changes/bug fixes.
## 
## Call:
##  randomForest(formula = wage ~ age + year + education + race +      maritl, data = Wage) 
##                Type of random forest: regression
##                      Number of trees: 500
## No. of variables tried at each split: 1
## 
##           Mean of squared residuals: 1258.732
##                     % Var explained: 27.69
svr (support vector regressor)
## 
## Call:
## svm(formula = wage ~ age + year + education + race + maritl, 
##     data = Wage)
## 
## 
## Parameters:
##    SVM-Type:  eps-regression 
##  SVM-Kernel:  radial 
##        cost:  1 
##       gamma:  0.07142857 
##     epsilon:  0.1 
## 
## 
## Number of Support Vectors:  2595
comparison of methods for wage prediction
linear regression / Generalized Additive Model / Random Forest / Support Vector Regressor
## Loading required package: ggplot2
## 
## Attaching package: 'ggplot2'
## The following object is masked from 'package:randomForest':
## 
##     margin








 

Note that the echo = FALSE parameter was added to the code chunk to prevent printing of the R code that generated the plot.







 코드
◾# solution 1 : http://stat-and-news-by-daragon9.tistory.com/92 
## 데이터
year <- c(26,16,20,7,22,15,29,28,17,3,1,16,19,13,27,4,30,8,3,12)

annual_salary <- c(1267,887,1022,511,1193,795,1713,1477,991,455,324,944,1232,808,1296,486,1516,565,299,830)

Data <- data.frame(year,annual_salary)

summary(Data)

"대학졸업자의 근무연수와 연봉의 관계를 조사하여 어떤 함수관계가 있는지 찾아보자.

자료는 2개의 변수 20개의 관측치를 가지고 있으며, 결측치는 없다.

평균근무연수는 15.8년이며, 최장근무연수는 30년이다.

평균연봉은 930.5이며, 최고연봉은 1713.0이다. "




## Box Plot

par(mfrow=c(1,2))

boxplot(Data$annual_salary, xlab="annual_salary")

boxplot(Data$year, xlab="year")

## Histogram

par(mfrow=c(1,1))

hist(annual_salary, 6, freq=FALSE, main="Histogram of annual_salary", xlab="annual_salary")

lines(density(Data$annual_salary)) "상자그림과 히스토그램을 통해 이상치는 존재하지 않으며, 분포는 대칭인 것을 볼 수 있다."




## 정규성 검정

qqnorm(annual_salary)

qqline(annual_salary)

"정규성검정과 정규 Q-Q 그림을 통해 정규성이 만족됨을 알 수 있다."

shapiro.test(annual_salary)




## 상관계수

plot(year,annual_salary)

cor(year,annual_salary)

"산점도와 상관계수(0.9775856)를 통해서 근무연수와 연봉은 선형관계가 있다고 볼 수 있다."




## 회귀분석

LSE <- lm(annual_salary ~ year, data=Data)

summary(LSE) "따라서, 근무연수와 연봉이 단순선형회귀모형을 따른다고 가정하고 회귀분석을 실시한다.

추정된 회귀계수로 적합된 회귀직선은 다음과 같다. y= 252 + 42*X "

abline(LSE) "회귀모형의 유의성검정 결과 F값이 388.1이고, p-value가 1.25e-13로 유의수준 0.001에서 귀무가설을 기각한다.

추정된 회귀직성은 유의한 모형이라고 할 수 있는 근거가 아주 강하다.

회귀계수의 유의성검정 결과, 각 회귀계수의 p-value가 5.59e-06, 1.25e-13으로 유의수준 0.001에서 귀무가설을 기각한다.

각 회귀계수가 0이 아니라는 근거가 아주 강하다.

Adjusted R-squared값이 0.9532로 총변동 중 회귀직선에 의해 설명될 수 있는 부분이 95.57%이다. "

plot(year,annual_salary)

"•Residual vs Fitted에서 매우 랜덤하게 잔차들이 분호해 있응 것을 확인. •Scale-Location 역시 산포를 보이는 것을 보임. •Normal Q-Q Plot의 경우도 기준선에 대부분 점들이 놓여 정규성을 만족하는 것으로 판단. •Residuals vs Leverage Plot의 경우 대다수 값들이 한쪽으로 몰려있는 형태를 보이고 있기에 역시 모형이 잘 적합함을 나타냄. •정규성의 경우 그래프로 주관적 판단도 가능하지만 shapiro.test()함수를 이용한 Shapiro-Wilk normality test역시 가능.  " anova(LSE)




## 잔차분석

par(mfrow=c(2,2))

plot(LSE, which=c(1,2,3))

shapiro.test(LSE$residuals) "정규성 검정에서 p-value가 0.1534로 유의수준 0.05보다 작으므로 잔차들이 정규분포를 따른다고 할 수 있다." library(lmtest)

dwtest(LSE) "독립성을 검정하기 위해 사용된 Durbin-Watson 검정 결과 p-value가 0.5291로 유의수준 0.05보다 크므로 독립성이 만족된다."







# solution 2 : https://www4.stat.ncsu.edu/~post/josh/LASSO_Ridge_Elastic_Net_-_Examples.html

#create test and training sets install.packages("glmnet") library(glmnet) library(MASS)

# Generate data set.seed(1022)  # Set seed for reproducibility n <- 1000  # Number of observations p <- 5000  # Number of predictors included in model real_p <- 15  # Number of true predictors x <- matrix(rnorm(n*p), nrow=n, ncol=p) y <- apply(x[,1:real_p], 1, sum) + rnorm(n)

# Split data into train (2/3) and test (1/3) sets train_rows <- sample(1:n, .66*n) x.train <- x[train_rows, ] x.test <- x[-train_rows, ]

y.train <- y[train_rows] y.test <- y[-train_rows]

# Fit models # (For plots on left): fit.lasso <- glmnet(x.train, y.train, family="gaussian", alpha=1) fit.ridge <- glmnet(x.train, y.train, family="gaussian", alpha=0) fit.elnet <- glmnet(x.train, y.train, family="gaussian", alpha=.5)

# 10-fold Cross validation for each alpha = 0, 0.1, ... , 0.9, 1.0 # (For plots on Right) for (i in 0:10) {   assign(paste("fit", i, sep=""), cv.glmnet(x.train, y.train, type.measure="mse",  # Cross-validation for glmnet                                             alpha=i/10,family="gaussian")) }

# Plot solution paths: par(mfrow=c(3,2)) # For plotting options, type '?plot.glmnet' in R console plot(fit.lasso, xvar="lambda") plot(fit10, main="LASSO")

plot(fit.ridge, xvar="lambda") plot(fit0, main="Ridge")

plot(fit.elnet, xvar="lambda") plot(fit5, main="Elastic Net")

# test yhat0 <- predict(fit0, s=fit0$lambda.1se, newx=x.test) yhat1 <- predict(fit1, s=fit1$lambda.1se, newx=x.test) yhat2 <- predict(fit2, s=fit2$lambda.1se, newx=x.test) yhat3 <- predict(fit3, s=fit3$lambda.1se, newx=x.test) yhat4 <- predict(fit4, s=fit4$lambda.1se, newx=x.test) yhat5 <- predict(fit5, s=fit5$lambda.1se, newx=x.test) yhat6 <- predict(fit6, s=fit6$lambda.1se, newx=x.test) yhat7 <- predict(fit7, s=fit7$lambda.1se, newx=x.test) yhat8 <- predict(fit8, s=fit8$lambda.1se, newx=x.test) yhat9 <- predict(fit9, s=fit9$lambda.1se, newx=x.test) yhat10 <- predict(fit10, s=fit10$lambda.1se, newx=x.test)

mse0 <- mean((y.test - yhat0)^2) mse1 <- mean((y.test - yhat1)^2) mse2 <- mean((y.test - yhat2)^2) mse3 <- mean((y.test - yhat3)^2) mse4 <- mean((y.test - yhat4)^2) mse5 <- mean((y.test - yhat5)^2) mse6 <- mean((y.test - yhat6)^2) mse7 <- mean((y.test - yhat7)^2) mse8 <- mean((y.test - yhat8)^2) mse9 <- mean((y.test - yhat9)^2) mse10 <- mean((y.test - yhat10)^2)

# a values mse0 # a = 0 - Ridge mse1 mse2 mse3 mse4 mse5 # a = 0.5 - Elastic mse6 mse7 mse8 mse9 mse10 # a = 1 - Lasso

min(mse0 ,  mse1 ,  mse2 ,  mse3 ,  mse4 ,  mse5 ,  mse6 ,  mse7 ,  mse8 ,  mse9 ,  mse10 )




# solution 3 : https://www.statmethods.net/advstats/glm.html

# glm(formula, family=familytype(link=linkfunction), data=)

# binomial (link = "logit")  # gaussian (link = "identity")  # Gamma  (link = "inverse") # inverse.gaussian (link = "1/mu^2")  # poisson (link = "log") # quasi  (link = "identity", variance = "constant") # quasibinomial (link = "logit")  # quasipoisson (link = "log")

A <- structure(list(numeracy = c(6.6, 7.1, 7.3, 7.5, 7.9, 7.9, 8,                                  8.2, 8.3, 8.3, 8.4, 8.4, 8.6, 8.7, 8.8, 8.8, 9.1, 9.1, 9.1, 9.3,                                  9.5, 9.8, 10.1, 10.5, 10.6, 10.6, 10.6, 10.7, 10.8, 11, 11.1,                                  11.2, 11.3, 12, 12.3, 12.4, 12.8, 12.8, 12.9, 13.4, 13.5, 13.6,                                  13.8, 14.2, 14.3, 14.5, 14.6, 15, 15.1, 15.7),                     anxiety = c(13.8,                                 14.6, 17.4, 14.9, 13.4, 13.5, 13.8, 16.6, 13.5, 15.7, 13.6, 14,                                 16.1, 10.5, 16.9, 17.4, 13.9, 15.8, 16.4, 14.7, 15, 13.3, 10.9,                                 12.4, 12.9, 16.6, 16.9, 15.4, 13.1, 17.3, 13.1, 14, 17.7, 10.6,                                 14.7, 10.1, 11.6, 14.2, 12.1, 13.9, 11.4, 15.1, 13, 11.3, 11.4,                                 10.4, 14.4, 11, 14, 13.4),                     success = c(0L, 0L, 0L, 1L, 0L, 1L,                                 0L, 0L, 1L, 0L, 1L, 1L, 0L, 1L, 0L, 0L, 0L, 0L, 0L, 1L, 0L, 0L,                                 1L, 1L, 1L, 0L, 0L, 0L, 1L, 0L, 1L, 0L, 0L, 1L, 1L, 1L, 1L, 1L,                                 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L),                     degree_S = c(0L, 0L, 0L, 3L, 0L, 2L,                            0L, 0L, 1L, 0L, 1L, 1L, 0L, 1L, 0L, 0L, 0L, 0L, 0L, 1L, 1L, 0L,                            2L, 1L, 2L, 0L, 0L, 0L, 1L, 0L, 3L, 0L, 0L, 3L, 2L, 2L, 2L, 1L,                            1L, 1L, 1L, 2L, 2L, 2L, 3L, 2L, 2L, 2L, 2L, 3L)) ,                     .Names = c("numeracy", "anxiety", "success", "degree_S"), row.names = c(NA, -50L), class = "data.frame")

head(A) model1 <- glm(success ~ numeracy + anxiety, family=binomial(link="logit"), data=A) summary(model1) model2 <- glm(success ~ numeracy + anxiety, family=poisson(link="log"), data=A) summary(model2) par(mfrow=c(2,2)) plot(model1)  plot(model2)







# Non-linear # solution 4 :https://www.r-bloggers.com/generalized-additive-models/ install.packages("gam") install.packages("ISLR") #requiring the Package require(gam)

#ISLR package contains the 'Wage' Dataset require(ISLR) attach(Wage) #Mid-Atlantic Wage Data

?Wage # To search more on the dataset ?gam() # To search on the gam function

dim(Wage) head(Wage) summary(Wage) Wage$success <- ifelse(Wage$wage > 120 , 1 , 0) Wage$success <- as.factor(Wage$success) Wage$rank <- ifelse(Wage$wage > 120 , 3 , ifelse(Wage$wage > 90 , 2, 1 )) Wage$rank <- as.factor(Wage$rank) summary(Wage)

# lm wage0 <- lm(wage ~ age +                year +                education +                maritl +                race ,             data=Wage)

summary(wage0) par(mfrow=c(2,2)) plot(wage0)

# gam wage1 <-gam(wage ~ s(age,df=6, spar=1) +                   ns(age ,df=3) +                   s(year,df=6) +                   education +                   race +                    maritl,           data = Wage) # ns() is function used to fit a Natural Cubic Spline #gam1<-gam(wage~s(age,df=3)+year+education ,data = Wage) #in the above function s() is the shorthand for fitting smoothing splines #in gam() function

summary(wage1) mean(wage1$residuals^2)

#Plotting the Model par(mfrow=c(2,3)) #to partition the Plotting Window plot(wage1,se = TRUE) #se stands for standard error Bands

wage2 <- glm(success ~ s(age,df=6, spar=1) +                 ns(age ,df=3) +                 s(year,df=6) +                 education +                maritl +                 race,               family=binomial(link="logit"), data=Wage)

summary(wage2) par(mfrow=c(2,2)) plot(wage2) 

wage3 <- glm(rank ~ s(age,df=6, spar=1) +                 ns(age ,df=3) +                 s(year,df=6) +                 education +                maritl +                 race,               family=poisson(link="log"), data=Wage)

wage3 <- glm(rank ~ age +                 year,                 #education,                 #maritl +                 #race,               family=poisson(link="log"), data=Wage)

wage3 <- glm(rank ~ age +                 year,                 #education,                 #maritl +                 #race,               family=quasipoisson(link="log"), data=Wage)

wage3 <- glm(rank ~ age +                 year,                 #education,                 #maritl +                 #race,               family=gaussian(link = "identity") , data=Wage) summary(wage3)

plot(wage3)

# solution 5 : install.packages("randomForest") require(randomForest) #Install Package install.packages("e1071") #Load Library library(e1071) # rf wage_rf <- randomForest(wage ~ age +                year +                education +                race +                maritl , data = Wage ) #svr wage_svr <- svm(wage ~ age +                           year +                           education +                           race +                           maritl , data = Wage )




Linear <- mean(wage0$residuals^2) # linear model  GAM <- mean(wage1$residuals^2) # Generalized Additive Model RF <- mean(wage_rf$mse) # Random Forest SVR <- mean(wage_svr$residuals^2) # Support Vector Regressor

df <- data.frame(c("Linear",                    "GAM",                    "RF",                    "SVR") ,                  c(Linear,                     GAM,                     RF,                     SVR)  ) names(df) <- c( "Method" , "MSE")

ggplot(data=df , aes(x=Method , y = MSE)) +geom_bar(stat="identity") + theme_classic() +ggtitle("Comparison of methods for Wage prediction")+ geom_text(data=df ,aes( label=round(MSE)),vjust=1.6, color="white", size=3.5)

