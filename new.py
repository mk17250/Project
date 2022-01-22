def question_1():
	""" Function providing the total transaction value for each day"""

	# (perhaps use Counter here might be more efficient!!!)
	for line in transactions:
		for key in daily_totals:
			if line[2] == key:
				daily_totals[key] += line[4]

	# for key, values in daily_totals.items():
	# 	print('Day', key, 'Total', round(values,2))	

def question_2():
	"""Function to calculate avergae transaction value for each category for each account"""

	# populate keys in dict and set values to 0 
	for i in accounts:
		for j in cats:
			new_dict1[i+'_'+j] = 0
			counts[i+'_'+j] = 0 

	# update relevant values of account+category: total, and counts of total number of transcations for account+category
	for i in transactions:
		if i[1] in accounts and i[3] in cats: #IS THIS REQUIRED?
			new_dict1[i[1]+'_'+i[3]] += i[4]
			counts[i[1]+'_'+i[3]] += 1

	# calculate averages using totals for each account and categories 
	for key in new_dict1:
		if counts[key] == 0:
			counts[key] = 1
			avg_dict[key] = new_dict1[key]/counts[key]
		else:
			avg_dict[key] = round(new_dict1[key]/counts[key], 2)

	# create nested dict with available values stating account: [cat: average transaction value]		
	nested_dict = {}
	for i,j in avg_dict.items():
		if i.split('_')[0] not in nested_dict:
			nested_dict[i.split('_')[0]] = ['AA:', avg_dict[i.split('_')[0]+'_AA'], 'BB:', avg_dict[i.split('_')[0]+'_BB'], 'CC:', avg_dict[i.split('_')[0]+'_CC'], 'DD:', avg_dict[i.split('_')[0]+'_DD'], 'EE:', avg_dict[i.split('_')[0]+'_EE'], 'FF:', avg_dict[i.split('_')[0]+'_FF'], 'GG:', avg_dict[i.split('_')[0]+'_GG']]
	
	
	# for key, value in nested_dict.items():
	# 	print(key, value)

def question_3():
	pass 



if __name__ == "__main__":
	# import file from path
	file = open(r'/Users/matthewking/Documents/transactions.txt', 'r')
	# read lines skipping header 
	file_lines = file.readlines()[1:]
	# create empty list 'tranactions'
	transactions = []
	# for each line in txt file strip and split, convert relevant elements to int/float
	for line in file_lines:
		element = line.strip().split(',')
		element[2] = int(element[2])
		element[4] = float(element[4])
		transactions.append(element)

	# flatten list to one lone list (IF NEEDED!!!)
	flat_list = [item for sublist in transactions for item in sublist]

	# create empty place holders via list and dicts for total days, accounts, categories, and dicts for relevant values 
	days = []
	accounts = []
	cats = []
	cat_tots = {}
	new_dict1 = {}
	new_dict2 = {}
	counts = {}
	counts2 = {}
	avg_dict = {}
	max_val = {}
	max_val_rol = {}
	cats_q3 = ['AA', 'CC', 'FF']
	rolling_days = [x for x in range(6, 30)]

	# create lists for sets of days, accounts, categories 
	for i in transactions:
		if i[2] not in days:
			days.append(i[2])
		if i[1] not in accounts:
			accounts.append(i[1])
		if i[3] not in cats:
			cats.append(i[3])

	# sort these lists  		
	accounts = sorted(accounts, key=lambda x: (x[0], int(x[1:])))
	cats = sorted(cats)
	daily_totals = {key:0 for key in days}

	question_1()

	question_2()


# Q3 

#create placeholders (dicts) for totals for each account on each day, number of transactions for each account each day, max val for each account each day 
for i in accounts:
		for j in days:
			new_dict2[i+'_'+str(j)] = 0
			counts2[i+'_'+str(j)] = 0
			max_val[i+'_'+str(j)] = 0

for i in accounts:
	for day in rolling_days:
		max_val_rol[i+'_'+str(day)] = 0

# populate values for totals for each account on each day, number of transactions for each account on each day, max val for each account each day, 
# transaction amount for account on each days if 'AA'|'CC'|'FF'
for line in transactions:
	new_dict2[line[1]+'_'+str(line[2])] += line[4]
	counts2[line[1]+'_'+str(line[2])] += 1
	if line[4] > max_val[line[1]+'_'+str(line[2])]:
		max_val[line[1]+'_'+str(line[2])] = line[4]
	if line[3] in cats_q3:
		cat_tots[line[1]+'_'+str(line[2])+'_'+line[3]] = line[4]



#### MAX NUMBER FOR PAST 5 DAYS ########

# place holder for results 
place_max = {}
# set min value for roling window 
min_val=0
# set top value for rolling window 
top_num=6
# loop through max_val for max values of each max value for each account on each day, used nested loop to create rolling wibdow appending
# relevant max values into tots list, upadte key in place_max dict with the max value from the list.
for day in rolling_days:
	for key, values in max_val.items():
		tots=[]
		for i in range(min_val+1, top_num):
			tots.append(max_val[key.split('_')[0]+'_'+str(i)])
			place_max[str(day)+'_'+key.split('_')[0]] = max(tots)	
	min_val+=1
	top_num+=1		

print(max_val)


		
