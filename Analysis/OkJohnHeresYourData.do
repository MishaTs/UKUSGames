 log using li6.log, replace
 import delimited "/Users/mishat/Desktop/Data/Li16/findat.csv"
 drop lat v24 major home timestamp id2
 
 ssc install outreg2
 
 desc
 summarize
 outreg2 using sum1.doc, replace sum(log)
 
 gen dpdcc = pdcc1 - pdcc2
 hist dpdcc
 ttest dpdcc = 0
 ttest dpdcc, by(tg)
 ttest dpdcc, by(nat)

 gen dugcc = ugcc1 - ugcc2
 hist dugcc
 hist dugcc if (role == 0)
 ttest dugcc, by(tg)
 ttest dugcc, by(nat)
 ttest dugcc if (role == 0), by(tg)
 ttest dugcc if (role == 0), by(nat)
 
 gen tgNat = tg*nat
 gen dpdcomp = pdcomp1 - pdcomp2
  gen dugcomp = ugcomp1 - ugcomp2
 
 reg dpdcc tg, r
 reg dpdcc tg nat tgNat, r
 
 reg dpdcc tg nat tgNat age gender edu tuk tus fampart famgt dpdcomp, r
 reg pdcc1 tg nat tgNat pdcc2 age gender edu tuk tus fampart famgt dpdcomp, r
 
 /* people projecting future earnings and thoughts about it */
 
 //probably do more with distributions but for now its fine
 
//tgNat = Americans with a Brit
//Nat = Americans with Americans
//tg = Brits with an American
//All relative to brit-brit pairs
 
 // relative to Brit vs Brit
 
//taking out tgNat and nat gives different results
//people are actually more cooperative 
//confounding factor with everyone who's American being on the program mostly

//Americans more cooperative than brits --> no statistical significance

//difference in earnings is related to difference in cooperative behaviour -->
// financial incentive is important
 
 reg pdcc1 tg pdcc2, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols1_1.doc, replace
 reg pdcc1 tg nat tgNat pdcc2, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols1_1.doc, append
 reg pdcc1 tg nat tgNat pdcc2 age gender edu tuk tus fampart famgt dpdcomp isecon isling ishum, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols1_1.doc, append
 reg pdcc1 tg nat tgNat pdcc2 age gender edu tuk tus fampart famgt isecon isling isstem isss ishum, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols1_1.doc, append
 reg pdcc1 tg nat tgNat pdcc2 age gender edu tuk tus fampart famgt dpdcomp isecon isling isstem isss ishum, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols1_1.doc, append
 
 reg dpdcc tg, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols1_2.doc, replace
 reg dpdcc tg nat tgNat, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols1_2.doc, append
 reg dpdcc tg nat tgNat dpdcomp, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols1_2.doc, append
 reg dpdcc tg nat tgNat age gender edu fampart famgt dpdcomp isling isss ishum, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols1_2.doc, append
 reg dpdcc tg nat tgNat age gender edu tuk tus fampart famgt isecon isling isstem isss ishum, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols1_2.doc, append
 reg dpdcc tg nat tgNat age gender edu tuk tus fampart famgt dpdcomp isecon isling isstem isss ishum, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols1_2.doc, append
 
 reg dugcc tg, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols1_3.doc, replace
 reg dugcc tg nat tgNat role, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols1_3.doc, append
 reg dugcc tg nat tgNat role dugcomp, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols1_3.doc, append
 reg dugcc tg nat tgNat role age gender edu tus dugcomp isecon isstem isss ishum, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols1_3.doc, append
 reg dugcc tg nat tgNat role age gender edu tuk tus fampart famgt isecon isling isstem isss ishum, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols1_3.doc, append
 reg dugcc tg nat tgNat role age gender edu tuk tus fampart famgt dugcomp isecon isling isstem isss ishum, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols1_3.doc, append

 reg ugcc1 tg ugcc2, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols1_4.doc, replace
 reg ugcc1 tg nat tgNat role ugcc2, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols1_4.doc, append
 reg ugcc1 tg nat tgNat role ugcc2 dugcomp, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols1_4.doc, append
 reg ugcc1 tg nat tgNat role ugcc2 age gender edu tuk tus dugcomp isecon isstem isss ishum, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols1_4.doc, append
 reg ugcc1 tg nat tgNat role ugcc2 age gender edu tuk tus fampart famgt isecon isling isstem isss ishum, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols1_4.doc, append
 reg ugcc1 tg nat tgNat role ugcc2 age gender edu tuk tus fampart famgt dugcomp isecon isling isstem isss ishum, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols1_4.doc, append

 clear
 import delimited "/Users/mishat/Desktop/Data/Li16/rddat.csv"
 desc
 sum
 outreg2 using sum2.doc, replace sum(log)
 drop v1 role2 ugmv1 ugmv2
 
 gen dpdmove = pdmv1 - pdmv2
 gen dugcc = ugcc1 - ugcc2
 gen dpay = payoff1 - payoff2
 
 ttest dpdmove == 0
 ttest dugcc == 0
 ttest dpdmove, by(tg)
 ttest dugcc, by(tg)
 ttest dpdmove, by(nat)
 ttest dugcc, by(nat)
 ttest dugcc if (role == 0), by(tg)
 ttest dugcc if (role == 0), by(nat)
 
 ttest pdmv1 == 0
 ttest ugcc1 == 0
 ttest pdmv1, by(tg)
 ttest ugcc1, by(tg)
 ttest pdmv1, by(nat)
 ttest ugcc1, by(nat)
 ttest ugcc1 if (role == 0), by(tg)
 ttest ugcc1 if (role == 0), by(nat)
 
 gen tgNat = tg*nat
 gen dpdt = pdt1 - pdt2
 gen dugt = ugt1 - ugt2
 tabulate period, generate(prd)
 
 reg pdmv1 tg pdmv2, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_1.doc, replace
 reg pdmv1 tg pdmv2 prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_1.doc, append
 reg pdmv1 tg nat tgNat pdmv2 prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_1.doc, append
 reg pdmv1 tg nat tgNat pdmv2 age gender edu tuk tus fampart famgt prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_1.doc, append
 reg dpdmove tg, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_2.doc, replace
 reg dpdmove tg prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_2.doc, append
 reg dpdmove tg nat tgNat prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_2.doc, append
 reg dpdmove tg nat tgNat age gender edu tuk tus fampart famgt prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_2.doc, append
 reg pdt1 dpdmove, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_3.doc, replace
 reg pdt1 dpdmove tg pdt2, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_3.doc, append
 reg pdt1 dpdmove tg pdt2 prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_3.doc, append
 reg pdt1 dpdmove tg nat tgNat pdt2 prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_3.doc, append
 reg pdt1 dpdmove tg nat tgNat pdt2 age edu tuk tus famgt prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_3.doc, append
 reg pdt1 dpdmove tg nat tgNat pdt2 age gender edu tuk tus fampart famgt prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_3.doc, append
 reg dpdt dpdmove, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_4.doc, replace
 reg dpdt dpdmove tg, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_4.doc, append
 reg dpdt dpdmove tg prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_4.doc, append
 reg dpdt dpdmove tg nat tgNat prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_4.doc, append
 reg dpdt dpdmove tg nat tgNat age edu tuk fampart famgt prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_4.doc, append
 reg dpdt dpdmove tg nat tgNat age gender edu tuk tus fampart famgt prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_4.doc, append
  
 reg ugcc1 tg ugcc2 role1, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_5.doc, replace
 reg ugcc1 tg ugcc2 role1 prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_5.doc, append
 reg ugcc1 tg nat tgNat ugcc2 role1 prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_5.doc, append
 reg ugcc1 tg nat tgNat ugcc2 role1 age gender edu tuk tus famgt prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_5.doc, append
 reg ugcc1 tg nat tgNat ugcc2 role1 age gender edu tuk tus fampart famgt dpay prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_5.doc, append
 reg dugcc tg role1, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_6.doc, replace
 reg dugcc tg role1 prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_6.doc, append
 reg dugcc tg nat tgNat role1 prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_6.doc, append
 reg dugcc tg nat tgNat role1 age edu tuk tus fampart famgt prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_6.doc, append
 reg dugcc tg nat tgNat role1 age gender edu tuk tus fampart famgt dpay prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_6.doc, append
 reg ugt1 dugcc role1, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_7.doc, replace
 reg ugt1 dugcc tg ugt2 role1, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_7.doc, append
 reg ugt1 dugcc tg ugt2 role1 prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_7.doc, append
 reg ugt1 dugcc tg nat tgNat ugt2 role1 prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_7.doc, append
 reg ugt1 dugcc tg nat tgNat ugt2 role1 age gender edu fampart famgt dpay prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_7.doc, append
 reg ugt1 dugcc tg nat tgNat ugt2 role1 age gender edu tuk tus fampart famgt dpay prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_7.doc, append
 reg dugt dugcc role1, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_8.doc, replace
 reg dugt dugcc tg role1, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_8.doc, append
 reg dugt dugcc tg role1 prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_8.doc, append
 reg dugt dugcc tg nat tgNat role1 prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_8.doc, append
 reg dugt dugcc tg nat tgNat role1 age gender edu fampart famgt dpay prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_8.doc, append
 reg dugt dugcc tg nat tgNat role1 age gender edu tuk tus fampart famgt dpay prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols2_8.doc, append
 
 
 //replade prd2 prd3 prd4 prd5 w/ prd1 prd2 prd3 prd4 (best to omit period 1??)
 //the only new data i have here is by-round data and reaction times 
 //looking at differences makes less sense here tho
 
 //why don't we see significance a lot; because significance can also be 
 //explained as the chance that the coefficients aren't 0; when the magnitude of\
 //the effect is small and n is too, that makes conclusions difficult
 
 clear
 import delimited "/Users/mishat/Desktop/Data/Li16/rddatred.csv"
 desc
 sum
 outreg2 using sum3.doc, replace sum(log)
 drop v1 role2 role1 pd*
 
 gen dugcc = ugcc1 - ugcc2
 gen dpay = payoff1 - payoff2
 gen dugmv = ugmv1 - ugmv2
 
 ttest dugmv == 0
 ttest dugcc == 0
 ttest dugmv, by(tg)
 ttest dugcc, by(tg)
 ttest dugmv, by(nat)
 ttest dugcc, by(nat)
 
 ttest ugmv1 == 0
 ttest ugcc1 == 0
 ttest ugmv1, by(tg)
 ttest ugcc1, by(tg)
 ttest ugmv1, by(nat)
 ttest ugcc1, by(nat)
 
 gen tgNat = tg*nat
 gen dugt = ugt1 - ugt2
 tabulate period, generate(prd)
 
 reg ugmv1 tg ugmv2, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols3_1.doc, replace
 reg ugmv1 tg ugmv2 prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols3_1.doc, append
 reg ugmv1 tg nat tgNat ugmv2 prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols3_1.doc, append
 reg ugmv1 tg nat tgNat ugmv2 age gender fampart famgt prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols3_1.doc, append
 reg ugmv1 tg nat tgNat ugmv2 age gender edu tuk tus fampart famgt prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols3_1.doc, append
 
 reg dugmv tg, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols3_2.doc, replace
 reg dugmv tg prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols3_2.doc, append
 reg dugmv tg nat tgNat prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols3_2.doc, append
 reg dugmv tg nat tgNat age gender tuk tus fampart famgt prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols3_2.doc, append
 reg dugmv tg nat tgNat age gender edu tuk tus fampart famgt prd2 prd3 prd4 prd5, r
 dis "Adjusted Required = " _result(8)
 outreg2 using ols3_2.doc, append
 
 //SE were not clustered because of a reduction of power (38 clusters but 40 ppl)


 log close
