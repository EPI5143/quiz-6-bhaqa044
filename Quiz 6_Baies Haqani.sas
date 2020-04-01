*Baies Haqani;
*EPI 5143 -- Quiz 6;

libname raw '/folders/myfolders/class_data';
libname Quiz6 '/folders/myfolders/Epi5143 work folder/programs';

*Encstartdtm, identify encounters in 2003: 3327 Observations;
data Quiz6.nencounter;
set raw.nencounter;
Keep EncPatWID EncVisitTypeCd EncStartDtm EncWID; 
if year(datepart(EncStartDtm))=2003;
run;

*Sort by patient encounter;
proc sort data=Quiz6.nencounter;
by EncPatWID;
run;

*Coding encounters for inpatients, emerg, or both (Q1-3);
data Quiz6.flag;
set quiz6.nencounter;
by EncPatWID;
	if first.EncPatWID=1 then do;
		inpatient=0; *if encounter inpatient = 1, otherwise =0;
		emerg=0; *if encounter inpatient = 1, otherwise =0;
		Inpt_emerg=0; *if inpatient OR emerg than = 1, otherwise =0;
		count=0; *if encounter inpatient = 1, otherwise =0;
		end;
	if EncVisitTypeCd='INPT' then do; *inpatient encounter;
		inpatient=1; 
		end;
	if EncVisitTypeCd='EMERG' then do; *ER encounter;
		emerg=1;
		end;
	if EncVisitTypeCd in: ('INPT' 'EMERG') then do; *either inpatient OR ER encounter*;
		Inpt_emerg=1;
		count=count+1;
		end;
	if last.EncPatWID then output;
	retain inpatient emerg Inpt_emerg count; 
run;

*frequency tables for questions a-d;
proc freq data=Quiz6.flag;
tables inpatient emerg Inpt_emerg count;
options formchar="|----|+|---+=|-/\<>*"; 
run;

*------------------QUIZ ANSWERS-------------------------;

*a) 1074 patients had at least 1 inpatient encounter that started in 2003
The FREQ Procedure

inpatient	Frequency	Percent		Cumulative	Cumulative
						Frequency	Percent	
0		1817		62.85		1817		62.85
1		1074		37.15		2891		100.00
;

*b) 1978 patients had least 1 emergency room encounter that started in 2003 

Emerg	Frequency	Percent		Cumulative	Cumulative
					Frequency	Percent	
0	913		31.58		913		31.58
1	1978		68.42		2891		100.00
;

* 2891 patients had at least 1 visit of either type (inpatient or emergency room encounter) that started in 2003

Inpt_emerg	Frequency	Percent		Cumulative	Cumulative
						Frequency	Percent	
1		2891		100.00		2891		100.00
;


*d) This table counts for # of encounters for each patient: 

count	Frequency	Percent		Cumulative	Cumulative
					Frequency	Percent	
								
1	2556		88.41		2556		88.41
2	270		9.34		2826		97.75
3	45		1.56		2871		99.31
4	14		0.48		2885		99.79
5	3		0.10		2888		99.90
6	1		0.03		2889		99.93
7	1		0.03		2890		99.97
12	1		0.03		2891		100.00
;


 
