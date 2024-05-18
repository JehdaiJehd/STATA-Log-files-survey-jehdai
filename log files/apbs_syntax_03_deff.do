****************************************************************************
******************************* FSP APBS  **********************************
****************** Annual Participant-based Survey (APBS) ******************
*********************** Design Effect Syntax *******************************
****************************************************************************
****************************************************************************
/*Author: Arno Bratz | MEL Manager, DFAP/DFSA | Mercy Corps | DRC
 *Update: John NTABALA | MEL Manager, DFAP/DFSA | Mercy Corps | DRC
 *MAJ Fanny LUNZE | MEL Manager, DFAP/DFSA | Mercy Corps | DRC 
 *MAJ Jehdai CIRUHULA | Database Assistant, DFAP/DFSA | Mercy Corps | DRC (25/05/2023)

Date: 17/02/2020  (Update : 6/09/2022)
Objective: To generate analytic indicator dataset and tabulation outputs for the FSP SFBS (agriculture indicators only)
Results of the syntax: Design effect calculated for all indicators collected through the APBS

Syntax file name: $syntax\apbs_03_deff
Inputs: $source\apbs_final
Log Outputs: $log\apbs_tab.log
	
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

Sampling frame: Care Groups/Neigbourhood Groups (var "smplfrm_cg")
	EXTERNAL INDICATORS
		IN 2.1.0.0.1 Contraceptive Prevalence Rate (CPR) (RM)
		IN 2.3.2.0.1 % of participants of community-level nutrition interventions who can identify MCHN services, need for services and benefits of services

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

clear
use "$source\apbs_final"
log using "$log\apbs_03_deff", replace

********************************************************************************
*Sampling frame: All participants (var "smplfrm_all_participants")

keep if smplfrm_all_participants == 1
svyset uid_cluster [pweight = pw_final_allpart]
svydescribe

*IN 1.0.0.0.2 % women, youth and men who earned cash in the last 12 months
svy: mean in_10002
estat effects

*IN 2.1.1.3.1 % of project participants who hear or see SBCC messages focussing on FP and HTSP
svy: mean in_21131
estat effects

*IN 2.2.2.0.2 % of men and women with children under two who have knowledge of MCHN practices (RM)
svy: mean in_22202
estat effects

*IN 2.3.1.1.1 % of project participants who hear or see SBCC messages focusing on community health
svy: mean in_23111
estat effects

*IN 2.3.2.1.1 % of project participants who hear or see SBCC messages focussing on MCHN
svy: mean in_23211
estat effects

*IN 2.3.5.0.1 % of people reporting confidence in the quality of services provided by their local HC/HP staff
svy: mean in_23501
estat effects

*IN 3.1.1.0.1  % of women, men and youth who report that they feel confident to participate in community decision-making
svy: mean in_31101
estat effects

*IN 3.1.2.0.1 % of individuals who agree with the statement, "Women and youth should express their opinions and influence community decision-making"
svy: mean in_31201
estat effects

*IN 3.2.0.0.3 # of participants who reported increased access to targeted public services
svy: mean in_32003
estat effects

tabstat in_32003, s(min p95 p99 max)

*IN 3.2.0.0.3 # (detail include standard deviation)

summarize in_32003, detail


*IN 3.2.1.0.2 % of community members participating in collective actions
svy: mean in_32102
estat effects

*IN 3.2.2.1.1  % of project participants who hear or see SBCC messages focusing on key resilience-related topics
svy: mean in_32211
estat effects

*IN 3.3.0.0.2 Index of social capital at HH level
svy: mean in_33002
estat effects

tabstat in_33002, s(min p95 p99 max)

*IN 3.3.0.0.2 # (detail include standard deviation)

summarize in_33002, detail


********************************************************************************
***Sampling frame: Care Groups/Neigbourhood Groups (var "smplfrm_cg")

clear 
use "$source\apbs_final"
keep if smplfrm_cg == 1
svyset uid_cluster [pweight = pw_final_cg]
svydescribe

*IN 2.1.0.0.1 Contraceptive Prevalence Rate (CPR) (RM)
svy: mean in_21001
estat effects

*IN 2.2.2.1.1  # of pregnant women reached with nutrition-specific interventions through USG-supported programs
svy: mean c2_16_pregnwom
estat effects

*IN 2.2.2.1.1  # (detail include standard deviation)
summarize c2_16_pregnwom, detail

*IN 4.0.0.0.6  # of CU5 reached with nutrition-specific interventions through USG-supported programs
svy: mean c2_13_nbr_cu5
estat effects

*IN 4.0.0.0.6  # (detail include standard deviation)
summarize c2_13_nbr_cu5, detail

*IN 4.0.0.0.7  # of CU2 reached with community-level nutrition interventions through USG-supported programs
svy: mean c2_14_nbr_cu2
estat effects

*IN 4.0.0.0.7  # (detail include standard deviation)
summarize c2_14_nbr_cu2, detail

********************************************************************************
***Sampling frame: Female farmer and female Care Group members having received permagarden and rabbit distributions

clear 
use "$source\apbs_final"
keep if smplfrm_fnutrag == 1
svyset uid_cluster [pweight = pw_final_fnutrag]
svydescribe

*IN 2.2.1.0.4 % female direct beneficiaries of USG nutrition-sensitive agriculture activities consuming a diet of minimum diversity
svy: mean in_22104
estat effects

log close










