Solution to the document classification problem

Training data is used to calculate the accuracy.

-> I am using first 4400 rows for the modelling and the remaining as the testdata.

-> matrix was created with cleaning the data from punctuations,numbers, stop words (like an, are, we, etc.) and blank spaces. 

-> I used Support Vector Machine Model to train the matrix. 

 # The model showed 94% accuracy rate with 1020 documents correctly sorted out of 1085 testsize.

-> This was my first attempt on text classification and learned a lot from it. Apart from tm and RTextTools, I also got the opportunity to dive into tidytext package, LDA topic modelling.
