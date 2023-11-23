cd "C:\Users\1026o\Desktop\社研法\final\"
use "f040815-f044109-eass2012_release_3312015.dta", clear

// drop all "DK, refused"
// 類別變項在跑回歸時需用虛擬變數 (v13 => i.v13)

// ========================
// control variables
// ========================

// 1. sex, 類別
recode sex (1=0)(2=1), gen(sex_cln)
label drop sex
label define sex 0 "Male" 1 "Female"
label values sex_cln sex

// 2. age
drop if age == 888

// 3. marital
drop if marital == 8
recode marital (1=1)(*=0), gen(marital_b)

// 4. fullpart
drop if fullpart == 8
recode fullpart (1=1)(*=0), gen(fullpart_b)

// ========================
// independent variables
// ========================

// 1. degree
drop if degree == 8
recode degree (0 1=1)(2=2)(3=3)(4=4)(5 6=5), gen(degree_cln) // cln = cleaned

// 2. educyrs, ignored
// drop if educyrs == 88

// 3. v19-28
drop if v19 == 8
recode v19 (2=0), gen(v19_b)

drop if v20 == 8
recode v20 (2=0), gen(v20_b)

drop if v21 == 8
recode v21 (2=0), gen(v21_b)

drop if v22 == 8
recode v22 (2=0), gen(v22_b)

drop if v23 == 8
recode v23 (2=0), gen(v23_b)

drop if v24 == 8
recode v24 (2=0), gen(v24_b)

drop if v25 == 8
recode v25 (2=0), gen(v25_b)

drop if v26 == 8
recode v26 (2=0), gen(v26_b)

drop if v27 == 8
recode v27 (2=0), gen(v27_b)

drop if v28 == 8
recode v28 (2=0), gen(v28_b)

// 4. v13, 類別
drop if v13 == 88
recode v13 (10 77=0), gen(v13_cln)
label values v13_cln v13

// income, ignored
// drop if cn_rinc == 7777777 | cn_rinc == 8888888
// drop if jp_rinc == 7777777 | jp_rinc == 8888888
// drop if kr_rinc == 7777777 | kr_rinc == 8888888
// drop if tw_rinc == 7777777 | tw_rinc == 8888888
// recode cn_rinc (9999999=0)
// recode jp_rinc (9999999=0)
// recode kr_rinc (9999999=0)
// recode tw_rinc (9999999=0)

// ========================
// independent variables
// ========================

// dependent var: v68
drop if v68 == 8
recode v68 (1=7)(2=6)(3=5)(4=4)(5=3)(6=2)(7=1), gen(v68_cln)

// ========================
// logistic regression
// ========================

// check correlation between independent var
pwcorr v68_cln marital_b fullpart_b degree_cln educyrs , sig star(0.5)

// install asdoc to output regression results as a figure
ssc install asdoc, replace

// China
asdoc regress v68_cln i.sex_cln age marital_b fullpart_b degree_cln v19 v20 v21 v22 v23 v24 v25 v26 v27 v28 i.v13_cln if v2 == 1, nest replace

// Japan
asdoc regress v68_cln i.sex_cln age marital_b fullpart_b degree_cln v19 v20 v21 v22 v23 v24 v25 v26 v27 v28 i.v13_cln if v2 == 2, nest append

// Korea
asdoc regress v68_cln i.sex_cln age marital_b fullpart_b degree_cln v19 v20 v21 v22 v23 v24 v25 v26 v27 v28 i.v13_cln if v2 == 3, nest append

// Taiwan
asdoc regress v68_cln i.sex_cln age marital_b fullpart_b degree_cln v19 v20 v21 v22 v23 v24 v25 v26 v27 v28 i.v13_cln if v2 == 4, nest append




