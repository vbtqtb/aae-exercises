cd "/Users/danielaerler/Desktop/Studium/MSc/Summer 2026/Adv. Applied Econometrics/AdvApplEconometrics/Exercise sheets/Ex. 6/Exercise 6 DD and DDD"

***************************************
************* EXERCISE 6 **************
***************************************


*************
* Problem 1 *
*************


*************
* Problem 2 *
*************

use "sodasales.dta"

summarize

*** (i) ***

// create 2x2 table
table treat post, statistic(mean sales1) nformat(%9.2f)
*/ average sales for control group before introduction of tax 26380L and after 27720L.
*/ average sales for treatment group before introduction fo tax 24520L and after 22430L.

// calculate DD based on means
*/ (treatment group_post=1 - treatment group_post=0) - (control group_post=1 - control group_post=0)
display (22430 - 24520) - (27720 - 26380)
*/ treatment effect ∂ = -3430
*/ economic theory predicts that the introduction of a tax results in a reduction of 3430L soda sales, on average.


*** (ii) ***

// regression model for DiD
*/ sales1_it = beta_0 + beta_1*treat_i + beta_2*post_t*treat_i + e_it

** simple manual calculation **

* from lecture (May 15):
reg sales1 i.post##i.treat, cluster(state)

// generate interaction term
generate interact = treat*post

// regress DiD model
regress sales1 treat post interact


** more sophisticated estimation **

regress sales1 i.treat##i.post, vce(cluster state)
*/ On average, stores sell around 26000L of soda. Introducing tax policy (being treat = 1) leads to reduction of sales of 1858L. In general, sales increase to 1343L on average, independent of treatment group (time effect).


*** (iii) ***
*/ homogeneous group effect at state level/ parallel trends
**/ threats: treatment effect bias; time-invariant and time-variant characteristics of a state.

*/ fixed sample composition
**/ threats: stores might close down and drop out of sample (sample attrition)

*/ stable unit treatment value assumption (SUTVA)/ no spillovers
**/ threats: at a border, costumers might choose to buy soda in the neighbouring state that did not impose a tax


*** (iv) ***

// use robust standard errors without clusters
regress sales1 treat post interact
regress sales1 treat post interact, robust
*/ standard errors of DiD model don't change significantly
*/ when clustering at the treatment level, then standard errors are already robust

/// use other DiD command

// create treatment group post treatment
didregress (sales1) (interact), group(state) time(post)
*/ ATET = -3.4261, which is close to the results obtained before.

