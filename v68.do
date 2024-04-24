cd "C:\Users\1026o\Desktop\社研法\final\"
use "f040815-f044109-eass2012_release_3312015.dta", clear

// drop all "DK, refused"
// 類別變項在跑回歸時需用虛擬變數 (v13 => i.v13)
// cln = cleaned

// ========================
// control variables
// ========================

// 1. sex, 類別
recode sex (1=0)(2=1), gen(sex_b)
label define sex_b 0 "Male" 1 "Female"
label values sex_b sex_b

// 2. age
drop if age == 888

// 3. marital, 類別
drop if marital == 8
recode marital (1=1)(*=0), gen(marital_b)
label define marital_b 0 "Other" 1 "Married"
label values marital_b marital_b

// 4. fullpart, 類別
drop if fullpart == 8
recode fullpart (1=1)(*=0), gen(fullpart_b)
label define fullpart_b 0 "Other" 1 "Working full-time"
label values fullpart_b fullpart_b

// 5. degree
drop if degree == 8
recode degree (0 1=1)(2=2)(3=3)(4=4)(5 6=5), gen(degree_cln)

// ========================
// independent variables
// ========================

// bonding
// v16
drop if v16 == 88
gen v16_cln = v16 - 1

// v17
drop if v7 == 88
gen v17_cln = v17 - 1

// bridging
// v4-12
drop if v4 == 8
recode v4 (1 2=1)(3=0), gen(v4_b)

drop if v5 == 8
recode v5 (1 2=1)(3=0), gen(v5_b)

drop if v6 == 8
recode v6 (1 2=1)(3=0), gen(v6_b)

drop if v7 == 8
recode v7 (1 2=1)(3=0), gen(v7_b)

drop if v8 == 8
recode v8 (1 2=1)(3=0), gen(v8_b)

drop if v9 == 8
recode v9 (1 2=1)(3=0), gen(v9_b)

drop if v10 == 8
recode v10 (1 2=1)(3=0), gen(v10_b)

drop if v11 == 8
recode v11 (1 2=1)(3=0), gen(v11_b)

drop if v12 == 8
recode v12 (1 2=1)(3=0), gen(v12_b)

// recode v4 (1 2=1)(*=0), gen(v4_b)
// recode v5 (1 2=1)(*=0), gen(v5_b)
// recode v6 (1 2=1)(*=0), gen(v6_b)
// recode v7 (1 2=1)(*=0), gen(v7_b)
// recode v8 (1 2=1)(*=0), gen(v8_b)
// recode v9 (1 2=1)(*=0), gen(v9_b)
// recode v10 (1 2=1)(*=0), gen(v10_b)
// recode v11 (1 2=1)(*=0), gen(v11_b)
// recode v12 (1 2=1)(*=0), gen(v12_b)

gen join_groups_num = v4_b + v5_b + v6_b + v7_b + v8_b + v9_b + v10_b + v11_b + v12_b
tab v2, sum(join_groups_num)

// v13, 類別
drop if v13 == 88
recode v13 (10 77=0), gen(v13_cln)
label values v13_cln v13
// tab v2 v13_cln, row

// v19-28
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

// recode v19 (1=1)(*=0), gen(v19_b)
// recode v20 (1=1)(*=0), gen(v20_b)
// recode v21 (1=1)(*=0), gen(v21_b)
// recode v22 (1=1)(*=0), gen(v22_b)
// recode v23 (1=1)(*=0), gen(v23_b)
// recode v24 (1=1)(*=0), gen(v24_b)
// recode v25 (1=1)(*=0), gen(v25_b)
// recode v26 (1=1)(*=0), gen(v26_b)
// recode v27 (1=1)(*=0), gen(v27_b)
// recode v28 (1=1)(*=0), gen(v28_b)

gen contact_jobs_num = v19_b + v20_b + v21_b + v22_b + v23_b + v24_b + v25_b + v26_b + v27_b + v28_b

// linking
// v18, 類別
drop if v18 == 6
drop if v18 == 8
recode v18 (1 3=1)(2=0), gen(v18_cln)
label define v18_cln 0 "Other" 1 "Contact more people that are socially higher or lower"
label values v18_cln v18_cln

// ========================
// dependent variables
// ========================

// dependent var: v68
drop if v68 == 8
recode v68 (1=3)(2=2)(3=1)(4=0)(5=-1)(6=-2)(7=-3), gen(v68_cln)
recode v68 (1 2 3=1)(*=0), gen(v68_merge)

// ========================
// dependencies
// ========================
// output regression result figure as a microsoft word file
ssc install asdoc, replace

// ========================
// logistic regression (without control variable)
// ========================
// asdoc regress v68_cln v16_cln v17_cln join_groups_num i.v13_cln contact_jobs_num v18_cln if v2 == 1, nest replace
// asdoc regress v68_cln v16_cln v17_cln join_groups_num i.v13_cln contact_jobs_num v18_cln if v2 == 2, nest append
// asdoc regress v68_cln v16_cln v17_cln join_groups_num i.v13_cln contact_jobs_num v18_cln if v2 == 3, nest append
// asdoc regress v68_cln v16_cln v17_cln join_groups_num i.v13_cln contact_jobs_num v18_cln if v2 == 4, nest append

// ========================
// logistic regression (with jobs)
// ========================
// asdoc regress v68_cln sex_b age marital_b fullpart_b degree_cln v16_cln v17_cln v19_b v20_b v21_b v22_b v23_b v24_b v25_b v26_b v27_b v28_b join_groups_num i.v13_cln contact_jobs_num v18_cln if v2 == 1, nest replace
// asdoc regress v68_cln sex_b age marital_b fullpart_b degree_cln v16_cln v17_cln v19_b v20_b v21_b v22_b v23_b v24_b v25_b v26_b v27_b v28_b join_groups_num i.v13_cln contact_jobs_num v18_cln if v2 == 2, nest append
// asdoc regress v68_cln sex_b age marital_b fullpart_b degree_cln v16_cln v17_cln v19_b v20_b v21_b v22_b v23_b v24_b v25_b v26_b v27_b v28_b join_groups_num i.v13_cln contact_jobs_num v18_cln if v2 == 3, nest append
// asdoc regress v68_cln sex_b age marital_b fullpart_b degree_cln v16_cln v17_cln v19_b v20_b v21_b v22_b v23_b v24_b v25_b v26_b v27_b v28_b join_groups_num i.v13_cln contact_jobs_num v18_cln if v2 == 4, nest append

// ========================
// logistic regression
// ========================

// check correlation between independent var
pwcorr v68_cln sex_b age marital_b fullpart_b degree_cln v16_cln v17_cln join_groups_num v13_cln contact_jobs_num v18_cln, sig star(.05)

//
pcorr v68_cln sex_b age marital_b fullpart_b degree_cln v16_cln v17_cln join_groups_num v13_cln contact_jobs_num v18_cln

// // Taiwan
// asdoc regress v68_cln sex_b age marital_b degree_cln v16_cln v17_cln join_groups_num i.v13_cln contact_jobs_num v18_cln if v2 == 4, nest replace
//
// // China
// asdoc regress v68_cln sex_b age marital_b degree_cln v16_cln v17_cln join_groups_num i.v13_cln contact_jobs_num v18_cln if v2 == 1, nest append
//
// // Japan
// asdoc regress v68_cln sex_b age marital_b degree_cln v16_cln v17_cln join_groups_num i.v13_cln contact_jobs_num v18_cln if v2 == 2, nest append
//
// // Korea
// asdoc regress v68_cln sex_b age marital_b degree_cln v16_cln v17_cln join_groups_num i.v13_cln contact_jobs_num v18_cln if v2 == 3, nest append

// Taiwan
asdoc regress v68_cln sex_b age marital_b degree_cln v16_cln v17_cln join_groups_num i.v13_cln contact_jobs_num v18_cln if v2 == 4, nest replace

// China
asdoc regress v68_cln sex_b age marital_b degree_cln v16_cln v17_cln join_groups_num i.v13_cln contact_jobs_num v18_cln if v2 == 1, nest append

// Japan
asdoc regress v68_cln sex_b age marital_b degree_cln v16_cln v17_cln join_groups_num i.v13_cln contact_jobs_num v18_cln if v2 == 2, nest append

// Korea
asdoc regress v68_cln sex_b age marital_b degree_cln v16_cln v17_cln join_groups_num i.v13_cln contact_jobs_num v18_cln if v2 == 3, nest append


