from sklearn.datasets import load_digits
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn import neighbors
from sklearn.metrics import recall_score, precision_score
import time
import matplotlib.pyplot as plt

digits = load_digits()
# print(digits.data)
# print(digits.target)

# qst2
#print(digits.DESCR)

# qst3
#print(digits.data.shape)

# qst4: nombre de classes: par défaut c'est 10 (n_class)
# qst5: nombre d'attributs: 64

x_train, x_test, y_train, y_test = train_test_split(digits.data, digits.target, test_size=0.30)

start_time = time.time()
k=1
something = neighbors.KNeighborsClassifier(k, weights='distance')
something.fit(x_train, y_train)
y_pred1 = something.predict(x_test)
time1 = time.time() - start_time

start_time = time.time()
k=3
something = neighbors.KNeighborsClassifier(k, weights='distance')
something.fit(x_train, y_train)
y_pred3 = something.predict(x_test)
time3 = time.time() - start_time

start_time = time.time()
k=5
something = neighbors.KNeighborsClassifier(k, weights='distance')
something.fit(x_train, y_train)
y_pred5 = something.predict(x_test)
time5 = time.time() - start_time

start_time = time.time()
k=7
something = neighbors.KNeighborsClassifier(k, weights='distance')
something.fit(x_train, y_train)
y_pred7 = something.predict(x_test)
time7 = time.time() - start_time

start_time = time.time()
k=9
something = neighbors.KNeighborsClassifier(k, weights='distance')
something.fit(x_train, y_train)
y_pred9 = something.predict(x_test)
time9 = time.time() - start_time

# print("recall score: ",recall_score(y_test, y_pred, average=None))
# print("precision score: ",precision_score(y_test, y_pred, average=None))
# print("--- %s seconds ---" % (time.time() - start_time))


plt.plot([0,1,2,3,4,5,6,7,8,9], precision_score(y_test, y_pred9, average=None), label='k=9', color='black', linewidth=3)
plt.plot([0,1,2,3,4,5,6,7,8,9], precision_score(y_test, y_pred7, average=None), label='k=7', color='purple', linewidth=3)
plt.plot([0,1,2,3,4,5,6,7,8,9], precision_score(y_test, y_pred5, average=None), label='k=5', color='red', linewidth=3)
plt.plot([0,1,2,3,4,5,6,7,8,9], precision_score(y_test, y_pred3, average=None), label='k=3', color='orange', linewidth=3)
plt.plot([0,1,2,3,4,5,6,7,8,9], precision_score(y_test, y_pred1, average=None), label='k=1', color='yellow', linewidth=3)
plt.legend(frameon=False)
plt.xticks(np.arange(0, 10, 1.0))
plt.xlabel('Class')
plt.ylabel('Score (%)')
plt.title('Precision score')
plt.show()

plt.plot([0,1,2,3,4,5,6,7,8,9], recall_score(y_test, y_pred9, average=None), label='k=9', color='black', linewidth=3)
plt.plot([0,1,2,3,4,5,6,7,8,9], recall_score(y_test, y_pred7, average=None), label='k=7', color='purple', linewidth=3)
plt.plot([0,1,2,3,4,5,6,7,8,9], recall_score(y_test, y_pred5, average=None), label='k=5', color='red', linewidth=3)
plt.plot([0,1,2,3,4,5,6,7,8,9], recall_score(y_test, y_pred3, average=None), label='k=3', color='orange', linewidth=3)
plt.plot([0,1,2,3,4,5,6,7,8,9], recall_score(y_test, y_pred1, average=None), label='k=1', color='yellow', linewidth=3)
plt.legend(frameon=False)
plt.xticks(np.arange(0, 10, 1.0))
plt.xlabel('Class')
plt.ylabel('Score (%)')
plt.title('Recall score')
plt.show()

plt.plot([1,3,5,7,9], [time1, time3, time5, time7, time9], color='green', linewidth=3)
plt.xlabel('k')
plt.xticks(np.arange(1, 10, 2.0))
plt.ylabel('Duration (seconds)')
plt.title('Duration')
plt.show()
