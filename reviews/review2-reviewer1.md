# Reviewer #1: Second Revision of the manuscript "Crucial but often neglected: The important role of spatial autocorrelation in hyperparameter tuning and predictive performance for spatial data."

Thank you very much for putting the effort in improving the manuscript. It has improved a lot and is very clear and structured now. I only have some minor comments:

# Introduction:
* Remove references from the abstract as this is not necessary
* line 5/6: Remove the "the" before soil science in accodance to the other examples. And I would prefer to leave the "of course" out. Sounds somehow misplaced
* Is landslide modelling necessarily an ecological application? Why not mention a few biotic and abiotic examples like species distribution modelling but also modelling of e.g. plant or soil properties, plant diseases etc…
* line 10/11: include a link here, e.g something like "One typical example for a spatial prediction approach in ecology is the detection of fungi infection on Monterey pines (Iturritxa et al., 2014)….
* Line 72: Rewrite "good performance results" to "robust performance results"
* Main objectives: I think the brackets around the hypotheses are not necessary as the hypotheses are an important part of the introduction.

#  Data and methods:
* line 106: change "used new predictors" to "introduced further predictors"
* Line 107: Make clear what the response variable is. It's not "Diplodia sapinea" but it's "trees infected by Diplodia sapinea or not"
* Line 113: What do you mean by number(11)?
* Line 124 and also from 137 on: don't refer to the internal name of the variable if not necessary. Better: "Iturritxa et al. (2014) showed that the presence or absence of hail damage..."
* Line 137: approx instead of ca.

# Discussion:
* Section 5.2.4. This sounds like the validation is very arbitrary. How is it possible that a algorithm is the best with AUC but worst with Brier. What is the reason for that and why is Brier more reliable?

Last but not least, the title:
* I think the title is misleading because it contradicts with the findings of the study. Yes Spatial CV is necessary for estimating the predictive performance but your results have shown that spatial hyperparameter tuning doesn't have an effect compared to non-hyperparameter tuning. So apparently it's not as crucial as claimed in the title. Maybe a question mark at the end of the title might solve the issue?

Please also check the manuscript again for spelling and grammatical errors.
