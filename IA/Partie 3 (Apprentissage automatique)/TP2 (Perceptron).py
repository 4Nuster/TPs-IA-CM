import random
import numpy as np
from matplotlib import pyplot as plt
from sklearn.linear_model import Perceptron
from sklearn.metrics import mean_squared_error, r2_score, accuracy_score

def createDataset(n):
    xx = []
    yy = []
    for i in range(n):
        in_there = False
        while not in_there:
            element = [random.uniform(-1, 1), random.uniform(-1, 1)]
            if (element[0] not in xx) and (element[1] not in yy):
                xx.append(element[0])
                yy.append(element[1])
                in_there = True
    
    return xx, yy

if __name__=='__main__':
    x,y = createDataset(100)
    x_zero = []
    y_zero = []
    x_one = []
    y_one = []

    data = []
    target = []

    for i in range(100):
        data.append([x[i],y[i]])
        if(i % 25 != 0):
            if(x[i] < 0):
                x_zero.append(x[i])
                y_zero.append(y[i])
                target.append(0)
            else:
                x_one.append(x[i])
                y_one.append(y[i])
                target.append(1)
        else:
            if(x[i] > 0):
                x_zero.append(x[i])
                y_zero.append(y[i])
                target.append(0)
            else:
                x_one.append(x[i])
                y_one.append(y[i])
                target.append(1)


    x = np.array(x)
    y = np.array(y)
    x = x.reshape(-1, 1)

    model = Perceptron(eta0=1)
    model.fit(data, target)

    # y_pred = model.predict(data)
    y_pred = model.predict(data)
    print('Mean squared error: %.2f' % mean_squared_error(target, y_pred))
    print('Coefficient of determination: %.2f' % r2_score(target, y_pred))
    print('Accuracy: %.2f\n' % accuracy_score(target, y_pred))

    plt.scatter(x_zero, y_zero, color='red')
    plt.scatter(x_one, y_one, color='blue')
    # plt.plot(data, y_pred, color='black', linewidth=3)
    plt.xlabel('x')
    plt.ylabel('y')
    plt.title('Perceptron')
    plt.show()
