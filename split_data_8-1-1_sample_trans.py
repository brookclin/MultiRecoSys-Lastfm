#!/bin/python
import pandas as pd
import numpy as np
from time import gmtime, strftime


def now():
    return strftime("%Y-%m-%d %H:%M:%S", gmtime())


print now(), 'start clean'
ratings = pd.read_csv('../cleaned_rating.dat', header=None, sep=' ', names=['u', 'i', 'r'])
ratings = ratings.reindex(np.random.permutation(ratings.index))
k = int(ratings.shape[0] * 0.9)
train = ratings.iloc[:k,:].copy()
test = ratings.iloc[k:,:].copy()

print now(), 'spliting train-test'
train.to_csv('./ratings_train.dat', header=False, sep=' ', index=False)
train_iuv = train[['i', 'u', 'r']]
train_iuv.to_csv('./ratings_train_iuv.dat', header=False, sep=' ', index=False)

k = int((8 / 9.0) * train.shape[0])
train_80 = train.iloc[:k,:].copy()
test_10 = train.iloc[k:,:].copy()
train_80.to_csv('./ratings_train_80.dat', header=False, sep=' ', index=False)
train_80_iuv = train_80[['i', 'u', 'r']]
train_80_iuv.to_csv('./ratings_train_80_iuv.dat', header=False, sep=' ', index=False)

print now(), 'spliting test data'
k = int(test.shape[0] * 0.5)
test_input = test.iloc[:k,:].copy()
test_eval = test.iloc[k:,:].copy()
k = int(test_10.shape[0] * 0.5)
test_input_10 = test_10.iloc[:k,:].copy()
test_eval_10 = test_10.iloc[k:,:].copy()

test_input.to_csv('./ratings_test_input.dat', header=False, sep=' ', index=False)
test_eval.to_csv('./ratings_test_eval.dat', header=False, sep=' ', index=False)

test_input_10.to_csv('./ratings_train_input.dat', header=False, sep=' ', index=False)
test_eval_10.to_csv('./ratings_train_eval.dat', header=False, sep=' ', index=False)

pd.DataFrame(test_eval['u'].unique()).to_csv('./target_users.dat', header=False, sep=' ', index=False)
pd.DataFrame(test_eval_10['u'].unique()).to_csv('./train_target_users.dat', header=False, sep=' ', index=False)
print now(), 'done'
