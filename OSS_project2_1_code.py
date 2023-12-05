import pandas as pd

baseball_csv = pd.read_csv("2019_kbo_for_kaggle_v2.csv")

#2-1-1

base_top = baseball_csv.copy()[baseball_csv['year'] <= 2018]
base_top = base_top.copy()[base_top['year'] >= 2015]

print("2015년 안타 상위 10명")
print(base_top[base_top['year'] == 2015].nlargest(10, 'H'))
print("2015년 타율 상위 10명")
print(base_top[base_top['year'] == 2015].nlargest(10, 'avg'))
print("2015년 홈런 상위 10명")
print(base_top[base_top['year'] == 2015].nlargest(10, 'HR'))
print("2015년 출루율 상위 10명")
print(base_top[base_top['year'] == 2015].nlargest(10, 'OBP'))

print("2016년 안타 상위 10명")
print(base_top[base_top['year'] == 2016].nlargest(10, 'H'))
print("2016년 타율 상위 10명")
print(base_top[base_top['year'] == 2016].nlargest(10, 'avg'))
print("2016년 홈런 상위 10명")
print(base_top[base_top['year'] == 2016].nlargest(10, 'HR'))
print("2016년 출루율 상위 10명")
print(base_top[base_top['year'] == 2016].nlargest(10, 'OBP'))

print("2017년 안타 상위 10명")
print(base_top[base_top['year'] == 2017].nlargest(10, 'H'))
print("2017년 타율 상위 10명")
print(base_top[base_top['year'] == 2017].nlargest(10, 'avg'))
print("2017년 홈런 상위 10명")
print(base_top[base_top['year'] == 2017].nlargest(10, 'HR'))
print("2017년 출루율 상위 10명")
print(base_top[base_top['year'] == 2017].nlargest(10, 'OBP'))

print("2018년 안타 상위 10명")
print(base_top[base_top['year'] == 2018].nlargest(10, 'H'))
print("2018년 타율 상위 10명")
print(base_top[base_top['year'] == 2018].nlargest(10, 'avg'))
print("2018년 홈런 상위 10명")
print(base_top[base_top['year'] == 2018].nlargest(10, 'HR'))
print("2018년 출루율 상위 10명")
print(base_top[base_top['year'] == 2018].nlargest(10, 'OBP'))


#2-1-2

base_2018 = baseball_csv.copy()[baseball_csv['year'] == 2018]
base_2018['rank_per_cp'] = base_2018.groupby('cp')['war'].rank(method='min', ascending=False)
base_2018 = base_2018[base_2018['rank_per_cp'] == 1]
base_2018 = base_2018[base_2018['cp'] != '지명타자']
print(base_2018['batter_name']+"("+base_2018['cp']+")")


#2-1-3

original_base = baseball_csv.copy()
original_base= original_base.loc[:,['R', 'H', 'HR', 'RBI', 'SB', 'war', 'avg', 'OBP', 'SLG', 'salary']]
print(original_base.corrwith(original_base.salary))
print("highest correlation with salary is RBI")
