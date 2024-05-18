****************************************************************************
*************************** FSP APBS  **************************************
****************** Annual Participant-based Survey (APBS) ******************
******************* Data Preparation Syntax ********************************
****************************************************************************
****************************************************************************
/*
Author: Arno Bratz | MEL Manager, DFAP/DFSA | Mercy Corps | DRC
		MAJ John NTABALA | MEL Manager, DFAP/DFSA | Mercy Corps | DRC (19/10/2020)
		MAJ Fanny LUNZE | MEL Manager, DFAP/DFSA | Mercy Corps | DRC (16/09/2022)
		MAJ Jehdai CIRUHULA | Database Assistant, DFAP/DFSA | Mercy Corps | DRC (20/05/2023)

Date: 17/10/2019
Objective: To generate analytic indicator dataset and tabulation outputs for the FSP SFBS (agriculture indicators only)
Results of the syntax:
			1. Demographic data are tabulated for all sampling frames
			2. Indicator variables are analysed and disaggregated in accordance with IPTT and PIRS
			3. Analyses are copied into the results sheet and stored in folders 5.14.2.7.2 (SFBS) and 5.15.1.7.2 (APBS)
 
Syntax file name: $syntax\fsp_apbs_02_tab
Inputs: $source\apbs_final
Log Outputs: $log\apbs_tab.log
*/

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
		MC_IN 2.3.4.1.4 % of latrines that were properly cited and in good condition
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

global source "G:\Drive partagés\DRC - MEL FSP\05 Data System Reports\5.15 AM - Enquête annuelle\5.15.5 2023-08 APBS\05_data\05.3_final" // source data
global syntax "G:\Drive partagés\DRC - MEL FSP\05 Data System Reports\5.15 AM - Enquête annuelle\5.15.5 2023-08 APBS\06_analysis\06.2_syntax" // syntax
global log "G:\Drive partagés\DRC - MEL FSP\05 Data System Reports\5.15 AM - Enquête annuelle\5.15.5 2023-08 APBS\06_analysis\06.3_log_files" // log file
global results "G:\Drive partagés\DRC - MEL FSP\05 Data System Reports\5.15 AM - Enquête annuelle\5.15.5 2023-08 APBS\06_analysis\06.4_analytic_outputs" // analytic outputs

clear
log using "$log\apbs_tab", text replace


********************************************************************************
********************************************************************************
***DEMOGRAPHICS
********************************************************************************
********************************************************************************

clear
use "$source\apbs_final"


/*Note: Demographics are calculated in a "loop": 
	1. Female participants in nutritious agriculture activities
	2. Females in care groups
	3. All participants*/

foreach var of varlist pw_final_* {
keep if `var' != .
svyset uid_cluster [pweight = `var' ]
svydescribe

*Total number of individuals surveyed
total `var'
total `var' if health_zone == "kalehe"
total `var' if health_zone == "katana"
total `var' if health_zone == "miti_murhesa"

clear 
use "$source\apbs_final"
}


foreach var of varlist pw_final_* {
keep if `var' != .
svyset uid_cluster [pweight = `var' ]
svydescribe

*Sex
svy: tab sex 
svy: tab sex if health_zone == "kalehe"
svy: tab sex if health_zone == "katana"
svy: tab sex if health_zone == "miti_murhesa"

svy: tab sex hz_kalehe
svy: tab sex hz_katana
svy: tab sex hz_miti_murhesa

clear 
use "$source\apbs_final"
}

foreach var of varlist pw_final_* {
keep if `var' != .
svyset uid_cluster [pweight = `var' ]
svydescribe

***Age
svy: tab age_cat_mc
svy: tab age_cat_mc if health_zone == "kalehe"
svy: tab age_cat_mc if health_zone == "katana"
svy: tab age_cat_mc if health_zone == "miti_murhesa"

svy: tab age_cat_mc hz_kalehe, col
svy: tab age_cat_mc hz_katana, col
svy: tab age_cat_mc hz_miti_murhesa, col

clear 
use "$source\apbs_final"
}

foreach var of varlist pw_final_* {
keep if `var' != .
svyset uid_cluster [pweight = `var' ]
svydescribe

*Educational status
svy: tab edu_level_str
svy: tab edu_level_str if health_zone == "kalehe"
svy: tab edu_level_str if health_zone == "katana"
svy: tab edu_level_str if health_zone == "miti_murhesa"

svy: tab edu_level_str hz_kalehe, col
svy: tab edu_level_str hz_katana, col
svy: tab edu_level_str hz_miti_murhesa, col

clear 
use "$source\apbs_final"
}



foreach var of varlist pw_final_* {
keep if `var' != .
svyset uid_cluster [pweight = `var' ]
svydescribe

*Marital status
svy: tab mar_status_str
svy: tab mar_status_str if health_zone == "kalehe"
svy: tab mar_status_str if health_zone == "katana"
svy: tab mar_status_str if health_zone == "miti_murhesa"

svy: tab mar_status_str hz_kalehe, col
svy: tab mar_status_str hz_katana, col
svy: tab mar_status_str hz_miti_murhesa, col

clear 
use "$source\apbs_final"
}

foreach var of varlist pw_final_* {
keep if `var' != .
svyset uid_cluster [pweight = `var' ]
svydescribe

*Household composition
svy: tab hh_comp 
svy: tab hh_comp if health_zone == "kalehe"
svy: tab hh_comp if health_zone == "katana"
svy: tab hh_comp if health_zone == "miti_murhesa" 

clear 
}


********************************************************************************
********************************************************************************
***Indicator values
********************************************************************************
********************************************************************************


********************************************************************************
***SAMPLING FRAME: All participants
********************************************************************************
clear
use "$source\apbs_final"

keep if smplfrm_all_participants == 1
svyset uid_cluster [pweight = pw_final_allpart]
svydescribe

***EXTERNAL INDICATORS
*IN C 1.0.0.0.2 % women, youth and men who earned cash in the last 12 months
svy: mean in_10002
svy: mean in_10002 if female == 1
svy: mean in_10002 if male == 1

*IN C 1.0.0.0.2 % women, youth and men who earned cash in the last 12 months v2
svy: mean in_10002v2
svy: mean in_10002v2 if female == 1
svy: mean in_10002v2 if male == 1

*IN 2.1.1.3.1 % of project participants who hear or see SBCC messages focussing on FP and HTSP
svy: mean in_21131
svy: mean in_21131 if female == 1
svy: mean in_21131 if male == 1
svy: mean in_21131_*

*IN 2.2.2.0.2 % of men and women with children under two who have knowledge of MCHN practices (RM)
svy: mean in_22202
svy: mean in_22202 if female == 1
svy: mean in_22202 if male == 1
svy: mean in_22202_*

*IN 2.3.1.1.1 % of project participants who hear or see SBCC messages focusing on community health
svy: mean in_23111
svy: mean in_23111 if female == 1
svy: mean in_23111 if male == 1
svy: mean in_23111_*

*IN 2.3.2.1.1 % of project participants who hear or see SBCC messages focussing on MCHN
svy: mean in_23211
svy: mean in_23211 if female == 1
svy: mean in_23211 if male == 1
svy: mean in_23211_*

*IN 2.3.5.0.1 % of people reporting confidence in the quality of services provided by their local HC/HP staff
svy: mean in_23501
svy: mean in_23501 if female == 1
svy: mean in_23501 if male == 1
svy: mean in_23501_*

*IN 2.3.4.0.7 % of project participant who washing hands with soap and water for at least 20 seconds : must be add to the computation

svy: mean in_23407
svy: mean in_23407 if female == 1
svy: mean in_23407 if male == 1

*IN 2.3.4.0.7 Denominator
svy: total in_23407_denom

*IN 2.3.4.0.7 Numerator
svy: total in_23407


*IN 2.3.1.1.3 % of project participant reached with handwashing/hygiene messaging(washing hands with soap and water at last 20 seconds)

svy: mean in_23113
svy: mean in_23113 if female == 1
svy: mean in_23113 if male == 1

**IN 2.3.1.1.3_int_sbcc handwasshing messaging (concerne tous les participants qui ont Ã©couter le message sur le lavage des mains sans prÃ©ciser la prÃ©sence du savon ou le 20" de frottement)
svy: mean in_23113_handw
svy: mean in_23113_handw if female == 1
svy: mean in_23113_handw if male == 1

*C IN 3.1.1.0.1 % of women, men and youth who report that they feel confident to participate in community decision-making
svy: mean in_31101
svy: mean in_31101 if female == 1
svy: mean in_31101 if male == 1

*C IN 3.1.2.0.1 % of individuals who agree with the statement, "Women and youth should express their opinions and influence community decision-making"
svy: mean in_31201
svy: mean in_31201 if female == 1
svy: mean in_31201 if male == 1
svy: mean in_31201 if age_1529 == 1
svy: mean in_31201 if age_30plus == 1

*TBD-29 IN 3.2.0.0.3 # of participants who reported increased access to targeted public services
svy: total in_32003
svy: total in_32003 if female == 1
svy: total in_32003 if male == 1

svy: total in_32003_ag
svy: total in_32003_ag if female == 1
svy: total in_32003_ag if male == 1

svy: total in_32003_nuthealth
svy: total in_32003_nuthealth if female == 1
svy: total in_32003_nuthealth if male == 1

svy: total in_32003_conflict
svy: total in_32003_conflict if female == 1
svy: total in_32003_conflict if male == 1

svy: total in_32003_wash
svy: total in_32003_wash if female == 1
svy: total in_32003_wash if male == 1

*MC_ IN 3.2.1.1.6 % of beneficiaries aware of proper disposal and reuse of bags and containers
svy: mean in_32116
svy: mean in_32116 if female == 1
svy: mean in_32116 if male == 1

* % of beneficiaries aware of proper disposal and reuse of bags
svy: mean in_32116_rbags
svy: mean in_32116_rbags if female == 1
svy: mean in_32116_rbags if male == 1

*% of beneficiaries aware of proper disposal and reuse of containers
svy: mean in_32116_rcont
svy: mean in_32116_rcont if female == 1
svy: mean in_32116_rcont if male == 1

*IN 3.2.2.1.1  % of project participants who hear or see SBCC messages focusing on key resilience-related topics
svy: mean in_32211
svy: mean in_32211 if female == 1
svy: mean in_32211 if male == 1

//Additional disaggregations:
svy: mean in_32211_pestdis in_32211_soil_degrad in_32211_illeg_tax in_32211_lacc_conflict in_32211_croptheft in_32211_waterdis 
svy: mean in_32211_radio in_32211_theater in_32211_cinema in_32211_other

*TBD-27 IN 3.3.0.0.2 Index of social capital at HH level
svy: mean in_33002
svy: mean in_33002_bonding
svy: mean in_33002_bridging // Overall index and sub-indices

svy: mean in_33002 if hh_comp == "amaf" // Disaggregation: Adult male, adult female
svy: mean in_33002_bonding if hh_comp == "amaf" // Disaggregation: Adult male, adult female
svy: mean in_33002_bridging if hh_comp == "amaf" // Disaggregation: Adult male, adult female

svy: mean in_33002 if hh_comp == "afnam" // Disaggregation: Adult female, no adult male
svy: mean in_33002_bonding if hh_comp == "afnam" // Disaggregation: Adult female, no adult male
svy: mean in_33002_bridging if hh_comp == "afnam" // Disaggregation: Adult female, no adult male

svy: mean in_33002 if hh_comp == "amnaf" // Disaggregation: Adult male, no adult female
svy: mean in_33002_bonding if hh_comp == "amnaf" // Disaggregation: Adult male, no adult female
svy: mean in_33002_bridging if hh_comp == "amnaf" // Disaggregation: Adult male, no adult female

svy: mean in_33002 if hh_comp == "namnaf" // Disaggregation: No adult male, no adult female. No data available
svy: mean in_33002_bonding if hh_comp == "namnaf" // Disaggregation: No adult male, no adult female. No data available
svy: mean in_33002_bridging if hh_comp == "namnaf" // Disaggregation: No adult male, no adult female. No data available


*IN r_20_P2 % of households who have and use hygienic toilets

svy: mean r_20

*IN r_20_1 % of households who actually had toilets

svy: mean r_20_1

svy: total r_20_1

*MC_IN 2.3.4.1.3 % of latrines that were properly cited and in good condition

svy: mean in_23413deux

*MC_IN 2.3.4.1.3 Total number of latrines that were properly cited and in good condition

svy: total in_23413deux

* MC_IN 2.3.4.1.3 % of latrines that were properly cited

svy: mean in_23413_gsite2

* MC_IN 2.3.4.1.3 % of latrines that were in good condition

svy: mean in_23413_gcond2

* MC_IN 2.3.4.1.3 total number of latrines observed

svy: total in_23413_denominator

*2.3.4.1.7 % of beneficiaries cooking in well ventilated spaces //IN 2_emmp % of beneficiaries cooking in well-ventilated spaces
gen in_23417 = 0 if i_12_cuisine == 1

svy: mean in_23417


********************************************************************************
***Sampling frame: All community members
********************************************************************************
//Note: This sampling frame is constructed artificially by inflating sample weights by factor (1/0.8)
// We then define non-participation through the 20th percentile of project exposure (measured by the estimated numbers of contact with the project)

*IN 3.2.1.0.2 % of community members participating in collective actions 
svyset uid_cluster [pweight = pw_final_allcomm]
svydescribe

svy: mean in_32102 
svy: total in_32102
total pw_final_allcomm // All community members

svy: mean in_32102 if expose_d20 == 1 
svy: total in_32102 if expose_d20 == 1
total pw_final_allcomm if expose_d20 == 1 //FSP participants

svy: mean in_32102 if expose_d20 == 0
svy: total in_32102 if expose_d20 == 0
total pw_final_allcomm if expose_d20 == 0 //Non-FSP-participants, proxied through 20th-percentile project exposure

//Further disaggregations by type of collective action:
svy: mean in_32102_*

*IN 3_emmp % of handwashing stations with proper drainage or absorption systems.
svy: mean in_3_emmp

********************************************************************************
***Sampling frame: Care Groups/Neigbourhood Groups (var "smplfrm_cg")
********************************************************************************
clear 
use "$source\apbs_final"
keep if smplfrm_cg == 1
svyset uid_cluster [pweight = pw_final_cg]
svydescribe

***EXTERNAL INDICATORS
*IN 2.1.0.0.1 Contraceptive Prevalence Rate (CPR) (RM)
svy: mean in_21001
svy: mean in_21001_mod
svy: mean in_21001_trad

*IN 2.2.2.1.1  # of pregnant women reached with nutrition-specific interventions through USG-supported programs

svy: total in_22211 

*in_22211_moins_19ans

svy: total in_22211 if c1_05_2_age < 19

*in_22211_plus_19ans
svy: total in_22211 if c1_05_2_age >= 19


*IN 2.3.2.0.1 % of participants of community-level nutrition interventions who can identify MCHN services, need for services and benefits of services
svy: mean in_23201
svy: mean in_23201 if female == 1
//svy: mean in_23201 if male == 1 // --> Command excluded as no male data available. Indicator is collected through female sampling frame.

svy: mean in_23201_ident_serv in_23201_need4serv in_23201_serv_benf // disaggregations for identify services, identify needs, identify benefits
svy: mean in_23201_benf_* // further disaggregations for the ability to identify specific service benefits

***Internal indicators
*C (BL/FE) IN 2.3.0.0.1
svy: mean in_23001 
svy: total in_23001_numerator
svy: total in_23001_denominator
// please note: This calculation may underreport treatment values if missing IDK or DNWA values are generated in the data.		

*IN 2.3.1.0.3_int % CU5 with diarrhea treated with ORT
svy: mean in_23001 
svy: total in_23103_numerator
svy: total in_23103_demonitator
// please note: This calculation may underreport treatment values if missing IDK or DNWA values are generated in the data.		
		
*IN 4.0.0.0.6  # of CU5 reached with nutrition-specific interventions through USG-supported programs

svy: total in_40006


*IN 4.0.0.0.7  # of CU2 reached with community-level nutrition interventions through USG-supported programs

svy: total in_40007

*IN 1_emmp % of households who report a reduction in fuelwood and charcoal consumption
svy: mean in_1_emmp 

*IN 1_emmp numerator
svy: total in_1_emmp

*IN 1_emmp denominator
svy: total in_1_emmp_denominator

********************************************************************************
***Sampling frame: Female farmer and female Care Group members having received permagarden and rabbit distributions
********************************************************************************
clear 
use "$source\apbs_final"
keep if smplfrm_fnutrag == 1
svyset uid_cluster [pweight = pw_final_fnutrag]
svydescribe

*IN 2.2.1.0.4 % female direct beneficiaries of USG nutrition-sensitive agriculture activities consuming a diet of minimum diversity
svy: mean in_22104
svy: total in_22104_numerator
svy: total in_22104_denominator

svy: mean in_22104 if c1_05_2_age < 19
svy: total in_22104_numerator if c1_05_2_age < 19
svy: total in_22104_denominator if c1_05_2_age < 19

svy: mean in_22104 if c1_05_2_age >= 19
svy: total in_22104_numerator if c1_05_2_age >= 19
svy: total in_22104_denominator if c1_05_2_age >= 19

gen part_agprod = 0
replace part_agprod = 1 if d1_1_part_ffs == 1 |  d1_3_part_jffs == 1 | d1_6_part_ybg == 1 |  d1_5_part_po == 1 | d1_9_part_perma == 1 | d1_10_part_slst == 1 

gen part_cgag = 0
replace part_cgag = 1 if d1_9_part_perma == 1 | d1_10_part_slst == 1 

//Further disaggregations:
svy: total  in_22104_cereals
svy: total  in_22104_legumes
svy: total  in_22104_oilseeds
svy: total  in_22104_milk
svy: total  in_22104_animprotein
svy: total  in_22104_eggs
svy: total  in_22104_greenleafs
svy: total  in_22104_orangeveg
svy: total  in_22104_otherveg
svy: total  in_22104_otherfruits

log close
clear
