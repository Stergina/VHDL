# 16-bit ALU in VHDL


**Objective**:  
The aim of this project is to design a hierarchical circuit that will implement a 16-bit Numerical and Logic Unit - ALU in VHDL.

**Structure of the code**:  
In the first part, we design and implement a 1-bit ALU, while in the second part we implement a 16-bit ALU using the 1-bit ALU of the first part as a component. More specifically:  
* Part 1: 1-bit ALU:  
Η ALU είναι ένα κύκλωμα υπεύθυνο για την εκτέλεση όλων των αριθμητικών και λογικών πράξεων. Σε αυτό το μέρος, σχεδιάζουμε μια 1-bit ALU ιεραρχικά με χρήση υποκυκλωμάτων ικανή να εκτελέσει τις πράξεις AND (σύζευξη), OR (διάζευξη), ADD (πρόσθεση), SUB (αφαίρεση), XOR (αποκλειστική διάζευξη), NOR (αντίθετο διάζευξης) και NAND (αντίθετο σύζευξης). Η τελική μορφή της 1-bit ALU που υλοποιεί όλες τις παραπάνω πράξεις φαίνεται στο παρακάτω διάγραμμα
Καλούμαστε να γράψουμε κώδικα σε γλώσσα VHDL που να προσομοιώνει την λειτουργία του παραπάνω κυκλώματος. Έτσι, θα πρέπει να υλοποιηθεί ένα κύκλωμα που λαμβάνει ως εισόδους τους 1-bit αριθμούς a, b, τα Ainvert, Binvert, CarryIn και Operation και επιστρέφει το αποτέλεσμα της πράξης (Result) και το κρατούμενο εξόδου (CarryOut).

