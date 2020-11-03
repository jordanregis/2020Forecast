# Overview 

This repository contains code for forecasting the 2020 US preisential election. It was created by Timothey Regis, Ankhee Paul, Chen Shupeng, and Kashaun Eghdam. The purpose of this is to create a report that summarises the results of a statistial model that we built. The data that we used for our anaylisis is unable to be shared publicly. We detail how to obtain this data below. The sections of this repo are: inputs, outputs, scripts.

Inputs contain data that are unchanged from their original. We use two datasets: 
The dataset we used in our report fall under copyright laws and thus we cannot include the direct data files.

Survey data: 
To obtain this datatset, first go to https://www.voterstudygroup.org/publication/nationscape-data-set and request to download the data file. Second then open email from Voter study group and select the link given. Next download dta file. Next open the folder, select "phase 2" and then select the last folder "ns20200625". In that folder will be one the data file which we will use to conduct our analysis.

ACS data:
To obtain the ACS dataset, first go to https://usa.ipums.org/usa/index.shtml and create an account. After 
your account has been made, select "get data" and then select 2018 ACS as the sample. Next select variables;
REGION, SEX, AGE, RACE and LANGUAGE and then select view cart. Next select "Create data extract" and change data format to "Stata (.dta)" and submit extract. Then shorty after you will be able to select the dataset after it 
is finished proccessing which we use for our analysis. 

Outputs contain data that are modified from the input data, the report and supporting material.

paper.rmd

paper.pdf

Scripts contain R scripts that take inputs and outputs and produce outputs. These are:

data_cleaning_survey.R
code to clean the survey dataset

data_preparation_poststrat.R
code to clean the post stratified dataset
