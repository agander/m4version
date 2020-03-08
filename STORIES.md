# Whats this for?
Creating, changing or displaying the version number.
Could be done with sed ecc. but using haskell seems like a good exercise.

## 1. Might want solely the version number
-p/--print (Could be the default, in which case, the 'no args' situation.)
Q: Would you want a line feed or not?

## 2. Might want to change the major part
(eg. '0.1' of '0.1.12'):
-M/--MAJ[OR] +1.0: add 1.0 to 0.1 = 1.1 (hmm, that needs some thought)

## 3. Change the minor part
(.12 of 0.1.12):
-m/--min[or] +10: add 10 to .12 = .22

## 4. Create new m4/version.m4
If doesnt exist:
-c/--create 0.1.0
