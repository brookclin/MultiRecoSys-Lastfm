# !/bin/bash

python ../split_data_6-2-2_sample_item.py

../sim-cosine -u 1892 -i 17632 -r ratings_train_80.dat -t ratings_train_input.dat > ./similarity_ub_cos
python ../complete_degrees.py ub ./similarity_ub_cos
../socialfiltering -u 1892 -i 17632 -r ratings_train_80.dat -t train_target_users.dat -l ratings_train_input.dat -g similarity_ub_cos_complete -k 10 -a recweighted_ub_cos > ./recavg_ub_cos

../sim-cosine -i 1892 -u 17632 -r ratings_train_80_iuv.dat -t ratings_train_80_iuv.dat > ./similarity_ib_cos
python ../complete_degrees.py ib ./similarity_ib_cos
../socialfiltering -u 1892 -i 17632 -r ratings_train_80.dat -t train_target_users.dat -l ratings_train_input.dat -g similarity_ib_cos_complete -k 10 -b 1 -a recweighted_ib_cos > ./recavg_ib_cos

../sim-cosine -u 1892 -i 17632 -r ratings_train.dat -t ratings_test_input.dat > ./similarity_ub_cos_test
python ../complete_degrees.py ub ./similarity_ub_cos_test
../socialfiltering -u 1892 -i 17632 -r ratings_train.dat -t target_users.dat -l ratings_test_input.dat -g similarity_ub_cos_test_complete -k 10 -a recweighted_ub_cos_test > ./recavg_ub_cos_test

../sim-cosine -i 1892 -u 17632 -r ratings_train_iuv.dat -t ratings_train_iuv.dat > ./similarity_ib_cos_test
python ../complete_degrees.py ib ./similarity_ib_cos_test
../socialfiltering -u 1892 -i 17632 -r ratings_train.dat -t target_users.dat -l ratings_test_input.dat -g similarity_ib_cos_test_complete -k 10 -b 1 -a recweighted_ib_cos_test > ./recavg_ib_cos_test

python ../calc_result_single.py `ls | grep rec | tr "\n" " "`
