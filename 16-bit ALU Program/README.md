# 16-bit ALU in VHDL


**Objective**:  
This program filters emails and determines if they are malicious (spam) or safe (ham) by implementing the Naive Bayes Classifier. The alogirthm has been trained and tested using the Ling - Spam data. A sample of the data can be found in the lingspam_public folder.

**Structure of the code**:  
By calculating the word frequency in ham and spam emails of the train datasets, we are able to determine if a new email coming from a test dataset should be classified as a spam or as a ham based on the words it contains. The user is prompted to choose between two methods of calculation: a) the Naive Bayes Classifier and b) the Naive Bayes Classifier combined with the Inverse Document Frequency - IDF method.
