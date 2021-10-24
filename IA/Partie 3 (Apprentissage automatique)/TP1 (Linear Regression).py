from PIL import Image
import numpy as np
import os
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_absolute_error, mean_squared_error, r2_score
import matplotlib.pyplot as plt

def pretraitement(path):
    img = Image.open(path)
    img = np.array(img)
    #print(np.shape)
    #print("yeeeees")

    result = np.where(img == 255)
    rows = result[0]
    columns = result[1]
    y = np.max(rows)
    x = columns[np.argmax(rows)]

    return x, y

def get_paths(path):
    imgs = []
    for file in os.listdir(path):
        if file.endswith(".png"):
            imgs.append(os.path.join(path, file))
    return imgs

def get_data(path):
    imgs = get_paths(path)
    yy = []
    xx = []

    for img in imgs:
        x, y = pretraitement(img)
        xx.append(x)
        yy.append(y)

    return np.array(xx), np.array(yy)

if __name__ == '__main__':
    x, y = get_data("C:/Users/nfsto/Desktop/skool M1/S1/IA/Partie 3/sequence/")
    x = x.reshape(-1, 1)

    model = LinearRegression()
    model.fit(x[:50], y[:50])
    print('Coefficients: ', model.coef_)

    print("evaluation:")
    y_pred = model.predict(x[:50])
    print('Mean squared error: %.2f' % mean_squared_error(y[:50], y_pred))
    print('Coefficient of determination: %.2f\n' % r2_score(y[:50], y_pred))

    # plt.scatter(x[:80], y[:80], color='black')
    # plt.plot(x[:80], y_pred, color='blue', linewidth=3)
    # plt.xlabel('x')
    # plt.ylabel('y')
    # plt.title('Regression (train)')
    # plt.show()

    print("testing:")
    y_pred = model.predict(x[-47:])
    print('Mean squared error: %.2f' % mean_squared_error(y[-47:], y_pred))
    print('Coefficient of determination: %.2f\n' % r2_score(y[-47:], y_pred))

    #plt.scatter(x[:80], y[:80], color='black')
    plt.scatter(x[-47:], y[-47:], color='black')
    plt.plot(x[-47:], y_pred, color='blue', linewidth=3)
    plt.xlabel('x')
    plt.ylabel('y')
    plt.title('Regression (test)')
    plt.show()
