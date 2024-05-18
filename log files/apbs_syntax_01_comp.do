****************************************************************************
*************************** FSP APBS  **************************************
****************** Annual Participant-based Survey (APBS) ******************
******************* Data Preparation Syntax ********************************
****************************************************************************
****************************************************************************
/*
Author: Arno Bratz | MEL Manager, DFAP/DFSA | Mercy Corps | DRC
		MAJ John NTABALA | MEL Manager, DFAP/DFSA | Mercy Corps | DRC (18/10/2020)
		MAJ John NTABALA | MEL Manager, DFAP/DFSA | Mercy Corps | DRC (13/09/2021)
		MAJ Fanny LUNZE | MEL Manager, DFAP/DFSA | Mercy Corps | DRC (16/09/2022)
		MAJ Jehdai CIRUHULA | Database Assistant, DFAP/DFSA | Mercy Corps | DRC (16/05/2023)

Date: 17/10/2019
Objective: To generate analytic indicator dataset and tabulation outputs for the FSP SFBS (agriculture indicators only)
Results of the syntax:
			1. Demographic variables are computed
			2. Indicator variables are computed
			3. Research analytical variables are computed
			4. Final datasets are stored.
 
Syntax file name: $syntax\fsp_apbs
Inputs: $source\apbs_clean
Log Outputs: $log\fsp_sfbs_ag_indicators.log
Data Outputs: $final\fsp_sfbs_final.dta*/

****************************************************************************

/*
DEMOGRAPHIC VARIABLES
	Number of participants
	Sex
	Age categories
	Head of household status
	Educational status of participants
	Marital status of participants
	Profession of participants
	Participants' household size
	Number of children under 60 months
	Number of children under 24 months
	Number of children under 6 months
	Land access status of participants
	Participation in FSP structures
	Project exposure level (defined by participation in FFA activities exclusively)
	
INDICATORS
Sampling frame: All participants (var "smplfrm_all_participants")
	EXTERNAL INDICATORS
		IN 1.0.0.0.2 % women, youth and men who earned cash in the last 12 months
		IN 2.1.1.3.1 % of project participants who hear or see SBCC messages focussing on FP and HTSP
		IN 2.2.2.0.2 % of men and women with children under two who have knowledge of MCHN practices (RM)
		IN 2.3.1.1.1 % of project participants who hear or see SBCC messages focusing on community health
		IN 2.3.2.1.1 % of project participants who hear or see SBCC messages focussing on MCHN
		IN 2.3.5.0.1 % of people reporting confidence in the quality of services provided by their local HC/HP staff
		IN 3.1.1.0.1  % of women, men and youth who report that they feel confident to participate in community decision-making
		IN 3.1.2.0.1 % of individuals who agree with the statement, ""Women and youth should express their opinions and influence community decision-making""
		IN 3.2.0.0.3 # of participants who reported increased access to targeted public services
		IN 3.2.1.0.2 % of community members participating in collective actions
		IN 3.2.2.1.1  % of project participants who hear or see SBCC messages focusing on key resilience-related topics
		IN 3.3.0.0.2 Index of social capital at HH level
		IN 2.2.2.1.1 # of pregnant women reached with nutrition-specific interventions through USG-supported programs
		IN 4.0.0.0.6 # of CU5 reached with nutrition-specific interventions through USG-supported programs
		IN 4.0.0.0.7  # of CU2 reached with community-level nutrition interventions through USG-supported programs
		IN 2.3.4.0.7 % of project participant who washing hands with soap and water for at least 20 seconds
		MC_IN 2.3.4.1.3 % of latrines that were properly cited and in good condition
		2.3.4.1.7 % of beneficiaries cooking in well ventilated spaces
		MC_ IN 3.2.1.1.6 % of beneficiaries aware of proper disposal and reuse of bags and containers
		IN 2.3.1.1.3 % of project participant reached with handwashing/hygiene messaging (washing hands with soap and water at last 20 seconds)

	INTERNAL INDICATORS
		IN 1.1.3.0.1 (BL/FE) % of men/women in union and earning cash who make decisions jointly with spouse/partner about the use of self-earned cash
		IN 1.1.3.0.2 (BL/FE)  % of men/women in union and earning cash who make decisions alone about the use of self-earned cash
		IN 2.2.0.0.2 (BL/FE) Prevalence of exclusive breast-feeding of children under six months of age
		IN 2.2.0.0.3 (BL/FE) Prevalence of children 6–23 months receiving a minimum acceptable diet (MAD)
		IN 2.3.4.0.1 (BL/FE) % of households with soap and water at a handwashing station commonly used by family members
		IN 2.3.4.1.2 CORROBORATION OF RM DATA  # of people gaining access to a basic sanitation service as a result of USG assistance
		IN 2.3.4.0.3 (BL/FE) % HHs using an improved sanitation facility
		IN 2.4.0.0.1_int % of participants of community-level nutrition interventions who practice promoted infant and 
			young child feeding behaviors (early initiation of breastfeeding, continued breastfeeding, timely introduction 
			of solid, semi-solid or soft foods, minimum acceptable diet)
		IN 3.3.1.0.4_int % of project participants with access to land (Internal indicator)
		IN r_12 % of project participants who see or hear SBCC messages focusing on crop theft
		IN r_14 % of households with soap and water at a handwashing station commonly used by family members (FFP #42 BL/FE)
		IN r_15 % of households using improved drinking water sources (FFP #40 BL/FE)
		IN r_19 % of individuals who wash their hands during the 5+1 key moments
		IN r_20 % of households who have and use hygienic toilets
		IN 0.0.0.0.1  Prevalence of moderate or severe food insecurity in the HHs (FIES)
		Shock exposure index
		Shock severity-weighted shock exposure index
		Ability to recover from shocks index
		IN 3_emmp % of handwashing stations with proper drainage or absorption systems
		IN 2_emmp % of beneficiaries cooking in well-ventilated spaces

Sampling frame: Care Groups/Neigbourhood Groups (var "smplfrm_cg")
	EXTERNAL INDICATORS
		IN 2.1.0.0.1 Contraceptive Prevalence Rate (CPR) (RM)
		IN 2.3.2.0.1 % of participants of community-level nutrition interventions who can identify MCHN services, need for services and benefits of services
	INTERNAL INDICATORS
		IN 2.3.0.0.1  % of children under age five who had diarrhea in the prior two weeks 
		IN 2.3.1.0.3_int % CU5 with diarrhea treated with ORT
		IN 1_emmp % of households who report a reduction in fuelwood and charcoal consumption

Sampling frame: Female farmer and female Care Group members having received permagarden and rabbit distributions
	IN 2.2.1.0.4 % female direct beneficiaries of USG nutrition-sensitive agriculture activities consuming a diet of minimum diversity
*/


********************************************************************************
version 16
set more off
clear all
pwd

global source "G:\Drive partagés\DRC - MEL FSP\05 Data System Reports\5.15 AM - Enquête annuelle\5.15.5 2023-08 APBS\05_data\05.2_clean" // source data
global output "G:\Drive partagés\DRC - MEL FSP\05 Data System Reports\5.15 AM - Enquête annuelle\5.15.5 2023-08 APBS\05_data\05.3_final" // output data
global syntax "G:\Drive partagés\DRC - MEL FSP\05 Data System Reports\5.15 AM - Enquête annuelle\5.15.5 2023-08 APBS\06_analysis\06.2_syntax" // syntax
global sampling "G:\Drive partagés\DRC - MEL FSP\05 Data System Reports\5.15 AM - Enquête annuelle\5.15.5 2023-08 APBS\04_sampling\04.2_weights" // sample weights
global log "G:\Drive partagés\DRC - MEL FSP\05 Data System Reports\5.15 AM - Enquête annuelle\5.15.5 2023-08 APBS\06_analysis\06.3_log_files" // log file
global results "G:\Drive partagés\DRC - MEL FSP\05 Data System Reports\5.15 AM - Enquête annuelle\5.15.5 2023-08 APBS\06_analysis\06.4_analytic_outputs" // analytic outputs

clear
log using "$log\apbs_comp", replace

import excel "$source\apbs_clean.xlsx", sheet("clean") firstrow case(lower)
destring *, replace // CommCare did not recognize scientific values as numeric, all numeric values need to be destringed.
save "$output\apbs_final", replace
clear all

********************************************************************************
***Adding sample weights for APBS (point-in-time estimates) in progress
********************************************************************************

clear all

import excel "$sampling\apbs_wgts.xlsx", sheet("pw_final_integrate") firstrow case(lower)
save "$sampling\apbs_wgts", replace // creating sample weights file in STATA .dta format
clear all

use "$output\apbs_final" // open APBS dataset
mmerge uid_cluster using "$sampling\apbs_wgts" // merge with sample weights file
list formid case_id uid_cluster if _merge == -2 // Lists observations which are missing in using data.
drop if _merge != 3 // drops mismatched observations created during the merger

count // final number of respondents: 1537

***Stockage globale
save "$output\apbs_final", replace
export excel using "$output\apbs_final.xslx", firstrow(variables) replace

clear all


********************************************************************************
***COMPUTATION OF DEMOGRAPHIC VARIABLES
********************************************************************************
clear all

use "$output\apbs_final"

***Health zone
gen health_zone = c1_12_zone_sante

***Sex
gen sex = ""
replace sex = "female" if c1_04_2_sexe_num == 1
replace sex = "male" if c1_04_2_sexe_num == 0

gen female = .
replace female = 0 if c1_04_2_sexe_num == 0
replace female = 1 if c1_04_2_sexe_num == 1
total female

gen male = .
replace male = 0 if c1_04_2_sexe_num == 1
replace male = 1 if c1_04_2_sexe_num == 0
total male

*** Age categories
gen age_u15 = .
replace age_u15 = 0 if c1_05_2_age >= 15
replace age_u15 = 1 if c1_05_2_age < 15
la var age_u15 "Aged under 15"

gen age_1529 = .
replace age_1529 = 0 if c1_05_2_age < 15 | c1_05_2_age >= 30
replace age_1529 = 1 if c1_05_2_age >= 15 & c1_05_2_age <30
la var age_1529 "Aged between 15 and 29"

gen age_30plus = .
replace age_30plus = 0 if c1_05_2_age < 30
replace age_30plus = 1 if c1_05_2_age >= 30
la var age_30plus "Aged over 30"

gen age_cat_ffp = ""
replace age_cat_ffp = "30+" if age_30plus == 1
replace age_cat_ffp = "15-29" if age_1529 == 1
replace age_cat_ffp = "00-14" if age_u15 == 1

gen age_cat_mc = ""
replace age_cat_mc = "46+" if c1_05_2_age >= 46
replace age_cat_mc = "35-45" if c1_05_2_age < 45
replace age_cat_mc = "25-34" if c1_05_2_age < 35
replace age_cat_mc = "20-24" if c1_05_2_age < 25
replace age_cat_mc = "15-19" if c1_05_2_age < 20
replace age_cat_mc = "10-14" if c1_05_2_age < 15
replace age_cat_mc = "05-09" if c1_05_2_age < 10
replace age_cat_mc = "02-04" if c1_05_2_age < 5
replace age_cat_mc = "0-1" if c1_05_2_age < 2
replace age_cat_mc = "" if c1_05_2_age == .
la var age_cat_mc "Mercy Corps age category (0-1,2-4,5-9,10-14,15-19,20-24,25-34,35-45,46+)"

***Household composition
//Note: The household composition questions should be revised in the FY2020 questionnaire to improve the quality of categories.
//Currently, widowed/separated male caretakers of underage respondents currently fall through the cracks.
//Next time, the marital status of the HOHH should be asked if the respondent is underage and not the HOHH.
list formid c2_02_1_hohh_relation_autre if c2_02_1_hohh_relation_autre !="" // All "other" categories are male persons. No further changes needed.
gen hh_comp = ""

	*AMNAF
	//A HH is Adult Female No Adult Male (AFNAM) if the respondent is an adult, no married, the head of household and female, 
	//OR: if the respondent is not an adult, not the head of household, and the head of household is female. (Females are the main caretakers of children but males are the HOHH.)
	replace hh_comp = "afnam" if c1_05_2_age >= 18 & c2_4_marital_status != 1 & c2_1_hohh == 1 & c1_04_2_sexe_num == 1
	replace hh_comp = "afnam" if c1_05_2_age < 18 & c2_1_hohh == 0 & (c2_02_hohh_relation == 2 | c2_02_hohh_relation == 4 | c2_02_hohh_relation == 7 | c2_02_hohh_relation == 8)

	*A HH is Adult Male No Adult Female (AMNAF) if the respondent is an adult, no married, the head of household and male.
	replace hh_comp = "amnaf" if c1_05_2_age >= 18 & c2_4_marital_status != 1 & c2_1_hohh == 1 & c1_04_2_sexe_num == 0

	*AMAF
	//A HH is Adult Male, Adult Female (AMAF) if the respondent is not an adult, not the head of household, and the head of household is a male. (As females are the main caretakers of children, a male HOHH of an underage respondent indicates that there is also a female.)
	//OR: If the respondent is an adult, not married, and not the head of household. (Indicating that there is at least one other adult)
	//ORT: If the respondent is an adult and married.
	replace hh_comp = "amaf" if c1_05_2_age < 18  & c2_1_hohh == 0 &(c2_02_hohh_relation == 1 | c2_02_hohh_relation == 3 | c2_02_hohh_relation == 5 | c2_02_hohh_relation == 6 | c2_02_hohh_relation == 9 | c2_02_hohh_relation == 10)
	replace hh_comp = "amaf" if c1_05_2_age >= 18 & c2_4_marital_status != 1 & c2_1_hohh == 0
	replace hh_comp = "amaf" if c1_05_2_age >= 18 & c2_4_marital_status == 1 

	*NAMNAF
	// HH is No Adult Male, No Adult Female (NAMNAF) if the respondent is not an adult and is the Head of Household.
	replace hh_comp = "namnaf" if c1_05_2_age < 18 & c2_1_hohh == 1

tab hh_comp, m // No missings have been produced.
	
***Educational status
gen edu_level_str = ""
replace edu_level_str = "1 No education" if c2_3_edu_level == 1
replace edu_level_str = "2 Primary education" if c2_3_edu_level == 2
replace edu_level_str = "3 Secondary education" if c2_3_edu_level == 3
replace edu_level_str = "4 University education" if c2_3_edu_level == 4
replace edu_level_str = "5 Professional training" if c2_3_edu_level == 5

***Marital status
gen mar_status_str = "" 
replace mar_status_str = "1 Married or living together" if c2_4_marital_status == 1
replace mar_status_str = "2 Divorced or separated" if c2_4_marital_status == 2
replace mar_status_str = "3 Widowed" if c2_4_marital_status == 3
replace mar_status_str = "4 Single" if c2_4_marital_status == 4

***Number of activities involved in
egen i_fsp_act = rowtotal(d1_23_part_p1  d1_24_part_p2  d1_25_part_p3)
sum i_fsp_act

***Community members sampling frame
gen smplfrm_all_community = smplfrm_all_participants
gen pw_final_allcomm = pw_final_allpart / 0.8

***Health zone dummy vars
gen hz_kalehe = 0
replace hz_kalehe = 1 if health_zone == "kalehe"
gen hz_katana = 0
replace hz_katana = 1 if health_zone == "katana"
gen hz_miti_murhesa = 0
replace hz_miti_murhesa = 1 if health_zone == "miti_murhesa"

*** Project exposure proxy, measured through 10th percentile of sessions with FSP.
gen exposetime = d1_2_exptime_length * d1_3_exptime_depth
la var exposetime "Number of encounters with the FSP program"

egen expose_20th = pctile(exposetime), p(20)
la var expose_20th "Number of encounters with the FSP program of the 20th percentile"
gen expose_d20 = 1 if exposetime > expose_20th
replace expose_d20 = 0 if expose_d20 != 1
la var expose_d20 "FSP exposure proxy: >20th percentile exposure to FSP activities (1=yes,0=no)" 

***Index of FSP exposure time proxied by the number of encounters with FSP activities
histogram exposetime, percent addlabel
graph save Graph "G:\Drive partagés\DRC - MEL FSP\05 Data System Reports\5.15 AM - Enquête annuelle\5.15.4 2022-08 APBS\06_analysis\06.4_analytic_outputs\hist-exposetime.png", replace
graph save Graph "G:\Drive partagés\DRC - MEL FSP\05 Data System Reports\5.15 AM - Enquête annuelle\5.15.4 2022-08 APBS\06_analysis\06.4_analytic_outputs\hist-exposetime.gph", replace


********************************************************************************
********************************************************************************
***COMPUTATION OF INDICATOR VARIABLES
********************************************************************************
********************************************************************************

********************************************************************************
***Sampling frame: All participants (var "smplfrm_all_participants")
********************************************************************************

***EXTERNAL INDICATORS
*IN C 1.0.0.0.2 % women, youth and men who earned cash in the last 12 months
gen in_10002 = 0 if smplfrm_all_participants == 1
replace in_10002 = 1 if c2_6_is_paid == 1 | c2_6_is_paid == 2

*IN C 1.0.0.0.2 % women, youth and men who earned cash in the last 12 months v2
gen in_10002v2 = 0 if smplfrm_all_participants == 1
replace in_10002v2 = 1 if c2_6_b_is_paid2 == 1 | c2_6_b_is_paid2 == 2

*IN 2.1.1.3.1 % of project participants who hear or see SBCC messages focussing on FP and HTSP
*drop l1_1_sbcc_htsp_canal_1 l1_1_sbcc_htsp_canal_2 l1_1_sbcc_htsp_canal_9 l1_1_sbcc_htsp_canal_extra l1_1_sbcc_htsp_canal_cinma
//the above syntax correct early-stage CommCare programming errors. The syntax should be reviewed during the 2020 calculation to see if it still needs to be included.

gen in_21131 = l1_sbcc_htsp
gen in_21131_radio = 0 if in_21131 !=.
replace in_21131_radio = 1 if  l1_1_sbcc_htsp_canalradio == 1
gen in_21131_cinema = 0 if in_21131 !=.
replace in_21131_cinema = 1 if   l1_1_sbcc_htsp_canalcinema == 1
gen in_21131_theater = 0 if in_21131 !=.
replace in_21131_theater = 1 if  l1_1_sbcc_htsp_canaltheatre == 1
gen in_21131_other = 0 if in_21131 !=.
replace in_21131_other = 1 if  l1_1_sbcc_htsp_canal99 == 1


*IN 2.2.2.0.2 % of men and women with children under two who have knowledge of MCHN practices (RM)
*replace f2_2_mchnpr_nbr_anc = "1" if f2_2_mchnpr_nbr_anc == "une_fois"
*encode f2_2_mchnpr_nbr_anc, gen(f2_2_mchnpr_nbr_anc1)
*drop f2_2_mchnpr_nbr_anc
*rename f2_2_mchnpr_nbr_anc1 f2_2_mchnpr_nbr_anc, replace // correcting string data error in variable "f2_2_mchnpr_nbr_anc". 
//The above corrective syntax can be removed in next survey syntax in FY2020.

recode f2_2_mchnpr_nbr_anc (4=1)(nonmissing=0), gen(in_22202_nbr_anc)
recode f2_3_mchnpr_preg_eat (1=1)(nonmissing=0), gen(in_22202_preg_eat)
recode f2_4_mchnpr_firstfeed (1/2=1)(nonmissing=0), gen(in_22202_firstfeed)
recode f2_5_mchnpr_intr_compl (2=1)(nonmissing=0), gen(in_22202_intr_compl)
egen in_22202 = rowtotal(in_22202_*), m
recode in_22202 (3/4=1)(nonmissing=0)
foreach var of varlist in_2220* {
replace `var' = . if age_u15 == 1
}
recode f2_1_mchnpr_first_anc (2 = 1)(nonmissing=0), gen(in_22202_first_anc)
egen in_22202_d5 = rowtotal(in_22202_*), m
recode in_22202_d5 (4/5=1)(nonmissing=0)
foreach var of varlist in_2220* {
replace `var' = . if age_u15 == 1
}
la var in_22202 "IN 2.2.2.0.2 % of men and women with children under two who have knowledge of MCHN practices (3+ out of 4 questions correct)"
la var in_22202_first_anc "Knows that the first antenatal care (ANC) visit should be in 4th month of pregnancy"
la var in_22202_nbr_anc "Knows that pregnant women should make at least 4 antenatal care (ANC) visits before birth"
la var in_22202_preg_eat "Knows that pregnant women need to eat more"
la var in_22202_firstfeed "Knows that a mother should breastfeed her infant within the first hour after birth" 
la var in_22202_intr_compl "Knows that an infant should be introduced to complementary soft and semi-soft foods after 6 months"
la var in_22202_d5 "% of men and women with children under two who have knowledge of MCHN practices (4+ out of 5 questions correct)"


*IN 2.3.1.1.1 % of project participants who hear or see SBCC messages focusing on community health
*replace l2_1_sbcc_sante_comm_canal_99 = 1 if l2_1_sbcc_sante_comm_canal_9 == 1  // NA in 2020
*replace l2_1_sbcc_sante_comm_canal_radio = 1 if l2_1_sbcc_sante_comm_canal_1 == 1 // NA in 2020
drop l2_1_sbcc_sante_comm_canal1 l2_1_sbcc_sante_comm_canal2 l2_1_sbcc_sante_comm_canal3 l2_1_sbcc_sante_comm_canal9
//the above syntax correct early-stage CommCare programming errors. The syntax should be reviewed during the 2020 calculation to see if it still needs to be included.

gen in_23111 = l2_sbcc_sante_comm
gen in_23111_radio = 0 if in_23111 !=.
replace in_23111_radio = 1 if  l2_1_sbcc_sante_comm_canalrad == 1
gen in_23111_cinema = 0 if in_23111 !=.
replace in_23111_cinema = 1 if   l2_1_sbcc_sante_comm_canalcin == 1
gen in_23111_theater = 0 if in_23111 !=.
replace in_23111_theater = 1 if  l2_1_sbcc_sante_comm_canalthe == 1
gen in_23111_other = 0 if in_23111 !=.
replace in_23111_other = 1 if  l2_1_sbcc_sante_comm_canal99 == 1


*IN 2.3.2.1.1 % of project participants who hear or see SBCC messages focussing on MCHN
*replace l3_1_sbcc_mchn_canal_radio = 1 if l3_1_sbcc_mchn_canal_1 == 1 // NA in 2020
*replace l3_1_sbcc_mchn_canal_99 = 1 if l3_1_sbcc_mchn_canal_9 == 1 // NA in 2020
drop  l3_1_sbcc_mchn_canal1  l3_1_sbcc_mchn_canal2  l3_1_sbcc_mchn_canal3  l3_1_sbcc_mchn_canal9  l3_1_sbcc_mchn_canalextra
//the above syntax correct early-stage CommCare programming errors. The syntax should be reviewed during the 2020 calculation to see if it still needs to be included.

gen in_23211 = l3_sbcc_mchn
gen in_23211_radio = 0 if in_23211 !=.
replace in_23211_radio = 1 if  l3_1_sbcc_mchn_canalradio == 1
gen in_23211_cinema = 0 if in_23211 !=.
replace in_23211_cinema = 1 if  l3_1_sbcc_mchn_canalcinema == 1
gen in_23211_theater = 0 if in_23211 !=.
replace in_23211_theater = 1 if  l3_1_sbcc_mchn_canaltheatre == 1
gen in_23211_other = 0 if in_23211 !=.
replace in_23211_other = 1 if  l3_1_sbcc_mchn_canal99 == 1

*IN 2.3.1.1.3 % of project participant reached with handwashing/hygiene messaging(washing hands with soap and water at last 20 seconds)
gen in_23113 = 0 if smplfrm_all_participants == 1
replace in_23113 = 1 if l2_3_handwashcormess == 3

*IN 2.3.1.1.3_int_sbcc handwasshing messaging (concerne tous les participants qui ont écouter le message sur le lavage des mains sans préciser la présence du savon ou le 20" de frottement)
gen in_23113_handw = 0 if smplfrm_all_participants == 1
replace in_23113_handw = 1 if  l2_2_sbcc_sante_comm_themesha == 1

*IN 2.3.4.0.7 % of project participant who washing hands with soap and water for at least 20 seconds
gen in_23407 = 0 if i6_1_handwashcor == 1 | i6_1_handwashcor == 2 
replace in_23407 = 1 if i6_1_handwashcor == 2
gen in_23407_denom = 1 if i6_1_handwashcor == 1 | i6_1_handwashcor == 2

*IN r_20 % of households who have and use hygienic toilets
gen r_20 = 0 if i10_0_wcobs == 1
replace r_20 = 1 if i10_hygtoilet == 1

*IN r_20_1 % of households who actually had toilets

gen r_20_1 = 0 if smplfrm_all_participants == 1
replace r_20_1 = 1 if 0 < i07_instalsan <= 8

***************************

* MC_IN 2.3.4.1.3 % of latrines that were properly cited
gen in_23413_gsite2 = 0 if i10_0_wcobs == 1
replace in_23413_gsite2 = 1 if i9_1_emplacement_toil6m == 1 & i9_1_emplacement_toilpente != 1

* MC_IN 2.3.4.1.3 % of latrines that were in good condition
gen in_23413_gcond2 = 0 if i10_0_wcobs == 1
replace in_23413_gcond2 = 1 if i10_7_matfecal==0 & i10_8_postlav == 1 & i10_9_dalle == 1 & i10_4_couvercle == 1


*MC_IN 2.3.4.1.3 % of latrines that were properly cited and in good condition
gen in_23413deux = 0 if i10_0_wcobs == 1
replace in_23413deux = 1 if (in_23413_gsite2 + in_23413_gcond2) == 2

*MC_IN 2.3.4.1.3 total number of latrines observed
gen in_23413_denominator = 0 if smplfrm_all_participants == 1
replace in_23413_denominator = 1 if i10_0_wcobs == 1

********

/* MC_IN 2.3.4.1.3 % of latrines that were properly cited
gen in_23413_gsite = 0 if smplfrm_all_participants == 1
replace in_23413_gsite = 1 if i9_2_bonemplac == 1

* MC_IN 2.3.4.1.3 % of latrines that were in good condition
gen in_23413_gcond = 0 if i10_0_wcobs == 1
replace in_23413_gcond = 1 if i10_1_toiletboncond == 1
*/


*2.3.4.1.7 % of beneficiaries cooking in well ventilated spaces//IN 2_emmp % of beneficiaries cooking in well-ventilated spaces
gen in_23417 = 0 if i_12_cuisine == 1
replace in_23417 = 1 if i121_cuisventile == 1

*IN 2.3.5.0.1 % of people reporting confidence in the quality of services provided by their local HC/HP staff
**forval i=2/4{
*foreach var of varlist e2_`i'_hctr_* {
*replace `var' = "99" if `var' == "ne_sait_pas"
*encode `var', gen (`var'_num)
*drop `var' 
*rename `var'_num `var'
*}
*}//The above syntax was used to replace string "i don't know" data with the value 99. 
  //The error existed due to faulty coding in CommCare that has been corrected. 
  //The above syntax can thus be removed in the FY2020 round of the APBS survey.

recode e2_1_hctr_respneeds (1=2)(2=3)(3=4)(nonmissing=0) // recoding 3-point likert scale into fake 5-point scale to facilitate upcoming transformations.

forval i=1/4{
foreach var of varlist e2_`i'_hctr_* {
replace `var' = . if e2_1_hctr_respneeds ==99 | e2_2_hctr_techcap ==99 | e2_3_hctr_avail ==99 | e2_4_hctr_qualtreat ==99 
recode `var' (4/5=1)(99=.)(nonmissing=0), gen(in_23501_`var')
}
} // recoding 5-point likert scales into binary confidence/no confidence variables
rename in_23501_e2_1_hctr_respneeds in_23501_respneeds
rename in_23501_e2_2_hctr_techcap in_23501_techcap
rename in_23501_e2_3_hctr_avail in_23501_avail
rename in_23501_e2_4_hctr_qualtreat in_23501_qualtreat

egen in_23501 = rowtotal(in_23501_*),m
recode in_23501 (3/4=1)(nonmissing=0)

la var in_23501_respneeds "Confidence in capacity of HCs to respond to needs of mothers&children (1=Y,0=N)"
la var in_23501_techcap "Confidence in technical competence of health center personnel (1=Y,0=N)"
la var in_23501_avail "Confidence in availability of health center personnel (1=Y,0=N)"
la var in_23501_qualtreat "Confidence in quality of treatment provided by health center personnel (1=Y,0=N)"
la var in_23501 "IN 2.3.5.0.1 Confidence un quality of services provided by HC/HP staff (1=Y,0=N)"


*C IN 3.1.1.0.1 % of women, men and youth who report that they feel confident to participate in community decision-making
gen in_31101 = j4_part_commdec
la var j4_part_commdec "IN 3.1.1.0.1 Confident to participate in community decision-making"


*C IN 3.1.2.0.1 % of individuals who agree with the statement, "Women and youth should express their opinions and influence community decision-making"
recode j5_wy_infl_commdec (1/2=1)(3/5=0), gen(in_31201)
la var j5_wy_infl_commdec "IN 3.1.2.0.1 Agree: 'W+Y should express opinions and influence comm decs'"


*TBD-29 IN 3.2.0.0.3 # of participants who reported increased access to targeted public services
gen in_32003 = 0 if smplfrm_all_participants == 1
foreach var of varlist m1_* {
replace in_32003 = 1 if `var' == 3
recode `var' (3=1) (nonmissing=0),gen(in_32003_`var')
}

rename in_32003_m1_1_serv_wash in_32003_wash
rename in_32003_m1_2_serv_agri in_32003_ag
rename in_32003_m1_3_serv_conflit in_32003_conflict
rename in_32003_m1_4_serv_sante in_32003_nuthealth

la var in_32003 "IN 3.2.0.0.3 Increased access to targeted public services"
la var in_32003_wash "Increased access to WASH services"
la var in_32003_ag "Increased access to agriculture services"
la var in_32003_conflict "Increased access to conflict mediation services"
la var in_32003_nuthealth "Increased access to nutrition and health services"

*MC_ IN 3.2.1.1.6 % of beneficiaries aware of proper disposal and reuse of bags and containers
gen in_32116_rbags = 0 if smplfrm_all_participants == 1 & k4_2_utsac0 != 1 & k4_2_utsac4 != 1
gen in_32116_rcont = 0 if smplfrm_all_participants == 1 & k4_3_utbidon0 != 1 & k4_3_utbidon4 != 1
gen in_32116 = 0 if in_32116_rbags == 0 | in_32116_rcont == 0

replace in_32116_rbags = 1 if k4_2_1_bon_util_sac == 1
replace in_32116_rcont = 1 if k4_3_1_bon_util_bidon == 1
replace in_32116 = 1 if in_32116_rbags == 1 | in_32116_rcont == 1


*IN 3.2.2.1.1  % of project participants who hear or see SBCC messages focusing on key resilience-related topics
replace k3_2_1_maladies_plantesradio = 1 if k3_2_1_maladies_plantes1 == 1
replace k3_2_2_degradation_solradio = 1 if k3_2_2_degradation_sol1 == 1
replace k3_2_3_taxes_illegradio = 1 if k3_2_3_taxes_illeg1 == 1
replace k3_2_4_lacc_conflictradio = 1 if k3_2_4_lacc_conflict1 == 1
replace k3_2_5_vol_culturesradio = 1 if k3_2_5_vol_cultures1 == 1
replace k3_2_6_maladies_hydriquesradi = 1 if k3_2_6_maladies_hydriques1 == 1
drop k3_2_1_maladies_plantes1 k3_2_1_maladies_plantes2 k3_2_1_maladies_plantes3 k3_2_1_maladies_plantesextra ///
    k3_2_2_degradation_sol1 k3_2_2_degradation_sol2 k3_2_2_degradation_sol3 k3_2_2_degradation_solextra k3_2_3_taxes_illeg1 ///
	k3_2_3_taxes_illeg2 k3_2_3_taxes_illeg3 k3_2_3_taxes_illegextra k3_2_4_lacc_conflict1 k3_2_4_lacc_conflict2 k3_2_4_lacc_conflict3 ///
	k3_2_4_lacc_conflictextra k3_2_5_vol_cultures1 k3_2_5_vol_cultures2 k3_2_5_vol_cultures3 k3_2_5_vol_culturesextra k3_2_6_maladies_hydriques1 ///
	k3_2_6_maladies_hydriques2 k3_2_6_maladies_hydriques3 
	//The above syntax for this indicator integrates and deletes faulty CommCare coding. It can be reviewed and deleted in FY2020.

egen in_32211 = rowmax(k3_1_*)

gen in_32211_pestdis = k3_1_1_sbcc_maladies_plantes
gen in_32211_soil_degrad = k3_1_2_degradation_sol
gen in_32211_illeg_tax = k3_1_3_taxes_illeg
gen in_32211_lacc_conflict = k3_1_4_lacc_conflict
gen in_32211_croptheft = k3_1_5_vol_cultures
gen in_32211_waterdis = k3_1_6_maladies_hydriques

egen in_32211_radio = rowmax(k3_2_*radio)
egen in_32211_theater = rowmax(k3_2_*theat*)
egen in_32211_cinema = rowmax(k3_2_*cinema)
egen in_32211_other = rowmax(k3_2_*99)
foreach var of varlist in_32211_* {
replace `var' = 0 if `var' ==. & in_32211 !=.
}

la var in_32211 "IN 3.2.2.1.1 heard or saw resilience-related SBCC messages"
la var in_32211_pestdis "Resilience-related SBCC msg topic: Plant pests and diseases"
la var in_32211_soil_degrad "Resilience-related SBCC msg topic: Soil degradation"
la var in_32211_illeg_tax "Resilience-related SBCC msg topic: Illegal taxation"
la var in_32211_lacc_conflict "Resilience-related SBCC msg topic: Land access uncertainty/conflict"
la var in_32211_croptheft "Resilience-related SBCC msg topic: Crop theft"
la var in_32211_waterdis "Resilience-related SBCC msg topic: Waterborne diseases"
la var in_32211_radio "Transmission mode of resilience related SBCC messages: Radio"
la var in_32211_theater "Transmission mode of resilience related SBCC messages: Theater"
la var in_32211_cinema "Transmission mode of resilience related SBCC messages: Cinema"
la var in_32211_other "Transmission mode of resilience related SBCC messages: Other"


*TBD-27 IN 3.3.0.0.2 Index of social capital at HH level
gen in_33002_bonding = (k2_1_1_soccohes_1_1 + k2_1_3_soccohes_1_3 + k2_2_1_soccohes_2_1 + k2_2_3_soccohes_2_3) / 4 * 100
gen in_33002_bridging =(k2_1_2_soccohes_1_2 + k2_1_4_soccohes_1_4 + k2_2_2_soccohes_2_2 + k2_2_4_soccohes_2_4) / 4 * 100
gen in_33002 = (in_33002_bonding + in_33002_bridging) / 2
la var in_33002 "Index of social capital at HH level (proxied through individuals)"
la var in_33002_bridging "Bridging sub-index of social capital at HH level"
la var in_33002_bonding "Bonding sub-index of social capital at HH level"

********************************************************************************
***Sampling frame: All community members
********************************************************************************
//Note: This sampling frame is artificially constructed by conflating "pw_final_allpart" sampling weights by factor (1/0.8) No additional sample is pulled.

*IN 3.2.1.0.2 % of community members participating in collective actions
*replace m2_1_part_collact_type_waterpoin = 1 if m2_1_part_collact_type_6 == 1 // NA in 2020
drop m2_1_part_collact_type1 m2_1_part_collact_type2 m2_1_part_collact_type3 m2_1_part_collact_type4 m2_1_part_collact_type5 m2_1_part_collact_type6 m2_1_part_collact_type7 m2_1_part_collact_typeextra
// correcting older coding mistake from CommCare. Syntax may be reviewed and removed for FY2020.

gen in_32102 = m2_part_collactions
gen in_32102_soil_cons =   m2_1_part_collact_typesoil_co
gen in_32102_flood_dev =  m2_1_part_collact_typeflood_d
gen in_32102_building =  m2_1_part_collact_typebuildin
gen in_32102_reforest =  m2_1_part_collact_typerefores
gen in_32102_route_maintain = m2_1_part_collact_typeroute_m
gen in_32102_waterpoint = m2_1_part_collact_typewaterpo
gen in_32102_other =  m2_1_part_collact_typeother

egen i_in_32102 = rowtotal(in_32102_*)
list formid m2_1_part_collact_type_other if in_32102_other == 1 & i_in_32102 == 1 //listing ppl who engaged in one "other" collective action and no other, predefined collective action.
*replace in_32102 = 0 if formid == "f1e5065f-75d8-4ceb-84a0-7742987ffd2b" | ///
		*formid == "b4cd780b-ab0c-4922-8017-8adcc2a6b996" | ///
		*formid == "391fd824-4e89-49a5-84f6-808f48f76426" | ///
		*formid == "b14d304e-d631-4c27-a2ba-2b60b72bd7c1" | ///
		
		
// replacing indicator value for all people who engaged in one undefined collective action that does not fit into the indicator definition as documented in the PIRS.
replace in_32102_other = 0 if formid == "9ba004f6-b3d7-418f-bc0b-e79785e6911d "
foreach var of varlist in_32102_* {
replace `var' = 0 if `var' ==. & in_32102 !=.
} // correcting survey skip logic to create zero instead of missing values
drop i_in_32102

la var in_32102 "IN 3.2.1.0.2 participated in collective actions in the past 12 months"
la var in_32102_soil_cons "Type of collective Action: Soil conservation"
la var in_32102_flood_dev "Type of collective Action: Flood deviation"
la var in_32102_building "Type of collective Action: Community building Maintenance"
la var in_32102_reforest "Type of collective Action: Reforestation"
la var in_32102_route_maintain "Type of collective Action: Road Maintenance"
la var in_32102_waterpoint "Type of collective Action: Waterpoint maintenance"
la var in_32102_other "Type of collective Action: Other"


*IN 3_emmp % of handwashing stations with proper drainage or absorption systems.

gen in_3_emmp = 0 if i06_installavmains == 2 | i06_installavmains == 4
replace in_3_emmp = 1 if i06_installavmains == 4

********************************************************************************
***Sampling frame: Care Groups/Neigbourhood Groups (var "smplfrm_cg")
********************************************************************************

***EXTERNAL INDICATORS
*IN 2.1.0.0.1 Contraceptive Prevalence Rate (CPR) (RM)
gen in_21001 = f4_1_contracept if f4_1_contracept <=1
egen in_21001_mod = rowmax(f4_2_contracept_method1 f4_2_contracept_method2 f4_2_contracept_method3 f4_2_contracept_method4 f4_2_contracept_method5 f4_2_contracept_method6 f4_2_contracept_method7)
replace in_21001_mod = 0 if in_21001_mod ==. & in_21001 !=.
egen in_21001_trad = rowmax(f4_2_contracept_method8 f4_2_contracept_method9 f4_2_contracept_method10)
replace in_21001_trad = 0 if in_21001_trad ==. & in_21001 !=.
la var in_21001 "IN 2.1.0.0.1 Contraceptive prevalence rate (CPR)"
la var in_21001_mod "Uses modern contraception methods"
la var in_21001_trad "Uses traditional contraception methods"


*IN 2.2.2.1.1 # of pregnant women reached with nutrition-specific interventions through USG-supported programs

gen in_22211 = c2_16_pregnwom


*IN 2.3.2.0.1 % of participants of community-level nutrition interventions who can identify MCHN services, need for services and benefits of services
gen in_23201_ident_serv = 0 if smplfrm_cg == 1
replace in_23201_ident_serv = 1 if (f1_1_ident_serv1 + f1_1_ident_serv2 + f1_1_ident_serv3 + f1_1_ident_serv4) >=2

gen in_23201_need4serv = 0 if smplfrm_cg == 1
replace in_23201_need4serv = 1 if (f1_2_need4serv1 + f1_2_need4serv2 + f1_2_need4serv3 + f1_2_need4serv4) >=2

gen in_23201_benf_anc = 0 if smplfrm_cg == 1
replace in_23201_benf_anc = 1 if (f1_3_servbenf_anc1 + f1_3_servbenf_anc2 + f1_3_servbenf_anc3) >=1

gen in_23201_benf_vacc = 0 if smplfrm_cg == 1
replace in_23201_benf_vacc = 1 if f1_4_servbenf_vacc1 == 1

gen in_23201_benf_treatill = 0 if smplfrm_cg == 1
replace in_23201_benf_treatill = 1 if (f1_5_servbenf_treatill1 + f1_5_servbenf_treatill2) == 2

gen in_23201_benf_treatmalnutr = 0 if smplfrm_cg == 1
replace in_23201_benf_treatmalnutr = 1 if (f1_6_servbenf_treatmalnutr1 + f1_6_servbenf_treatmalnutr2) == 2

egen in_23201_serv_benf = rowtotal(in_23201_benf_*),m
recode in_23201_serv_benf (4=1) (nonmissing=0)

gen in_23201 = 0 if smplfrm_cg == 1
replace in_23201 = 1 if (in_23201_ident_serv + in_23201_need4serv + in_23201_serv_benf) == 3

la var in_23201 "IN 2.3.2.0.1 Can identify MCHN services, need for service and benefits of service"
la var in_23201_ident_serv "Can identify MCHN services"
la var in_23201_need4serv "Can identify need for MCHN services"
la var in_23201_serv_benf "Can identify benefits of MCHN services"
la var in_23201_benf_anc "Can name objectives of antenatal consultations"
la var in_23201_benf_vacc "Can name objective of vaccination"
la var in_23201_benf_treatill "Can identify benefits of seeking care at HC in case of illness"
la var in_23201_benf_treatmalnutr "Can identify benefits of seeking care at HC in case of malnutrition"


*IN 4.0.0.0.6  # of CU5 reached with nutrition-specific interventions through USG-supported programs

gen in_40006 = c2_13_nbr_cu5


*IN 4.0.0.0.7  # of CU2 reached with community-level nutrition interventions through USG-supported programs

gen in_40007 = c2_14_nbr_cu2


***Internal indicators
*C (BL/FE) IN 2.3.0.0.1
gen in_23001_numerator = pw_final_cg * f3_1_pct_chn_diarrhea * c2_13_nbr_cu5 if f3_1_pct_chn_diarrhea != .
gen in_23001_denominator = pw_final_cg * c2_13_nbr_cu5 if f3_1_pct_chn_diarrhea != .
gen in_23001 = in_23001_numerator / in_23001_denominator
mean in_23001
// please note: This calculation may underreport diarrhea values if missing IDK or DNWA values are generated.		
		

*IN 2.3.1.0.3_int % CU5 with diarrhea treated with ORT
gen in_23103_numerator = pw_final_cg * f3_2_pct_chn_ort * c2_13_nbr_cu5
gen in_23103_demonitator = pw_final_cg * c2_13_nbr_cu5
gen in_23103 = in_23103_numerator / in_23103_demonitator
mean in_23001
// please note: This calculation may underreport treatment values if missing IDK or DNWA values are generated.		


*IN 1_emmp % of households who report a reduction in fuelwood and charcoal consumption

gen in_1_emmp = 0 if l13_democul == 1
replace in_1_emmp = 1 if  l131_redconsobois == 1	
gen in_1_emmp_denominator = 1 if l13_democul == 1


********************************************************************************
***Sampling frame: Female farmer and female Care Group members having received permagarden and rabbit distributions
********************************************************************************

*IN 2.2.1.0.4 % female direct beneficiaries of USG nutrition-sensitive agriculture activities consuming a diet of minimum diversity
egen in_22104 = rowtotal(g1_*), m
recode in_22104	(1/4 = 0) (nonmissing = 1)
gen in_22104_numerator = in_22104
gen in_22104_denominator = 1 if in_22104 != .
// further disaggregations for adaptive management //
rename g1_1_cereals in_22104_cereals
rename g1_2_legumes in_22104_legumes
rename g1_3_oilseeds in_22104_oilseeds
rename g1_4_milk in_22104_milk
rename g1_5_animprotein in_22104_animprotein
rename g1_6_eggs in_22104_eggs
rename g1_7_greenleafs in_22104_greenleafs
rename g1_8_orangeveg in_22104_orangeveg
rename g1_9_otherveg in_22104_otherveg
rename g1_10_otherfruits in_22104_otherfruits

la var in_22104 "Consumed a diet of minimum diversity the past day (5+/10 food groups)"
la var in_22104_cereals "Consumed cereals during the past day"
la var in_22104_legumes "Consumed legumes (beans, lentils, peas) during the past day"
la var in_22104_oilseeds "Consumed oily seeds (peanuts, sesame, pumpkin, melonseeds ) during the past day"
la var in_22104_milk "Consumed milk or milk products during the past day"
la var in_22104_animprotein "Consumed animal protein (fish, meat) during the past day"
la var in_22104_eggs "Consumed eggs during the past day"
la var in_22104_greenleafs "Consumed green leafy vegetables (spinach, amaranth, cabbage) during the past day"
la var in_22104_orangeveg "Consumed carrots, citrus, sweet potatos, pumpkin during the past day"
la var in_22104_otherveg "Consumed other vegetables (onion, tomatoes, zucchini etc.) during the past day"
la var in_22104_otherfruits "Consumed other fruits (mango, banana, papaya etc.) during the past day"


********************************************************************************
***Enhanced variable preparation for RMEL
********************************************************************************

********************************************************************************
***Section F
*rename k1_2_1_2_shockimp_fs_2 k1_2_2_2_shockimp_fs_2 // changing varname error // NA in 2020
*rename k1_2_1_3_recover_2 k1_2_2_3_recover_2 // changing varname error  // NA in 2020

*Shock exposure index (1-10 - excluding waterborne diseases as non-ag shock)
egen i_shock = rowtotal(k1_1_1_shock_*)
la var i_shock "Index of number of shocks experienced"

*Perceived shock severity index by shock:
forval i=1/16 {
gen shocksev_`i' = k1_2_`i'_2_shockimp_fs_`i' * k1_2_`i'_1_shockimp_rev_`i'
replace shocksev_`i' = 0 if shocksev_`i' == .
replace shocksev_`i' = . if shocksev_`i' > 8
}
la var shocksev_1 "Subjective shock severity impact - Shock 1: Plant diseases"
la var shocksev_2 "Subjective shock severity impact - Shock 2: Plant pests"
la var shocksev_3 "Subjective shock severity impact - Shock 3: Soil erosion"
la var shocksev_4 "Subjective shock severity impact - Shock 4: Landslides"
la var shocksev_5 "Subjective shock severity impact - Shock 5: Flooding"
la var shocksev_6 "Subjective shock severity impact - Shock 6: Dry spells"
la var shocksev_7 "Subjective shock severity impact - Shock 7: Crop theft (pre- and post-harvest)"
la var shocksev_8 "Subjective shock severity impact - Shock 8: Illegal and multiple taxation"
la var shocksev_9 "Subjective shock severity impact - Shock 9: Insecure and uncertain land access"
la var shocksev_10 "Subjective shock severity impact - Shock 10: Intra-community violence and conflict"
la var shocksev_11 "Subjective shock severity impact - Shock 11: Water-borne diseases"
la var shocksev_12 "Subjective shock severity impact - Shock 12: Non-availability of inputs"
la var shocksev_13 "Subjective shock severity impact - Shock 13: Livestock diseases"
la var shocksev_14 "Subjective shock severity impact - Shock 14: Increases in food prices"
la var shocksev_15 "Subjective shock severity impact - Shock 15: Exchange rate fluctuation"
la var shocksev_16 "Subjective shock severity impact - Shock 16: Straying/divagating livestock"




********************************************************************************
*** Save, prepare codebook and store
********************************************************************************

save "$output\apbs_final", replace
export excel using "$output\apbs_final.xslx", firstrow(variables) replace

keep female male age_* expose* in_* smplfrm_* pw_* uid_cluster i_* health_zone sex edu_level_str mar_status_str hh_comp c1_05_2_age hz_*
save "$output\apbs_final_in", replace
export excel using "$output\apbs_final_in.xslx", firstrow(variables) replace

log close
log using "$output\apbs_final_in_codebook", replace
codebook
log close

clear all

********************************************************************************
***Adding sample weights for APBS (point-in-time estimates) in progress
********************************************************************************

*clear all

*import excel "$sampling\apbs_wgts.xlsx", sheet("pw_final_integrate") firstrow case(lower)
*save "$sampling\apbs_wgts", replace // creating sample weights file in STATA .dta format
*clear all
