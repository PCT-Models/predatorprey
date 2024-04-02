# -*- coding: utf-8 -*-
"""
Created on Sat Mar  2 13:14:49 2024

@author: gtaus
"""
import numpy as np
import scipy.io
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split

from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_absolute_error
from sklearn.ensemble import GradientBoostingRegressor
from sklearn.tree import DecisionTreeRegressor
from sklearn.svm import LinearSVR
from sklearn.neighbors import KNeighborsRegressor, NearestNeighbors, KNeighborsClassifier
from sklearn.neural_network import MLPRegressor
from sklearn.multioutput import MultiOutputRegressor
from sklearn.model_selection import learning_curve

import scipy.spatial.distance as distance


def knn(xx, XX, k, **kwargs):
    """
    find indices of k-nearest neighbors of x in X
    """
    d = distance.cdist(xx.reshape(1,-1), XX, **kwargs).flatten()
    return np.argpartition(d, k)[:k]


#%%
part = 33

mat = scipy.io.loadmat('D:/Matlab/Warren/Calib_files_new/'+str(part)+'_u.mat')
mat1 = scipy.io.loadmat('D:/Matlab/Warren/Calib_images/'+str(part)+'_u.mat')

p_1_pred = scipy.io.loadmat('D:/Matlab/Warren/Traj_files/Mat_files/'+str(part)+'_u_pred.mat')
p_1_prey = scipy.io.loadmat('D:/Matlab/Warren/Traj_files/Mat_files/'+str(part)+'_u_prey.mat')

x = mat['x']
y = mat['y']

pred = p_1_pred['T6']
prey = p_1_prey['T7']

img = mat1['Iu']

plt.plot(x,y,'.c')
prey_x, prey_y, pred_x, pred_y = [],[],[],[]

for i in range(0,len(pred)):
    prey_x.append(prey[i][1])
    prey_y.append(prey[i][2])
    pred_x.append(pred[i][1])
    pred_y.append(pred[i][2])
    
plt.plot(prey_x,prey_y,'-or')
plt.plot(pred_x,pred_y,'-ok')
plt.imshow(img)
plt.show()
#%% Fit KNN to Data


nanx = []
nany = []
prey_x1 = []
prey_y1 = []
pred_x1 = []
pred_y1 = []

for i in range(0,len(x)):
    if np.isnan(x[i]) == True or np.isnan(y[i])==True:
        pass
    else:
        nanx.append(x[i])
        nany.append(y[i])
        
cc = np.hstack((nanx,nany))

for ii in range(0,len(prey_x)):
    x1 = np.array([prey_x[ii],prey_y[ii]])
    x11 = np.array([pred_x[ii],pred_y[ii]])
    
    inds1 = knn(x1,cc, 1)
    inds2 = knn(x11,cc, 1)
    
    prey_x1.append(nanx[inds1[0]])
    prey_y1.append(nany[inds1[0]])
    
    pred_x1.append(nanx[inds2[0]])
    pred_y1.append(nany[inds2[0]])

# plt.scatter(nanx, nany, c='b')
plt.plot(x,y,'.c')
plt.plot(prey_x1, prey_y1, "-ok")
plt.plot(pred_x1, pred_y1, "-or")
# plt.plot(prey_x, prey_y, "og")


plt.imshow(img)
plt.show()

#%% Machine Learning ANN
X = np.hstack((pred_x1,pred_y1))
# X = np.transpose(X)
y = np.hstack((prey_x1,prey_y1))
# y = np.transpose(y)
# X = [pred_x,pred_y]
# y = [prey_x,prey_y]

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.01, random_state=10, shuffle=False)

# define lin model
model_lin = LinearRegression()
model_grad = DecisionTreeRegressor()
model_svr = LinearSVR()
wrapper_svr = MultiOutputRegressor(model_svr)
model_knr = KNeighborsRegressor()
model_reg = MLPRegressor(random_state=1, max_iter=500)

model_lin.fit(X_train, y_train)
model_grad.fit(X_train, y_train)
wrapper_svr.fit(X_train, y_train)
model_knr.fit(X_train, y_train)
model_reg.fit(X_train, y_train)

# make a prediction
y_pred_lin = model_lin.predict(X_test)
y_pred_grad = model_grad.predict(X_test)



# summarize prediction
train_lin = model_lin.score(X_train, y_train)
test_lin = model_lin.score(X_test, y_test)

train_grad = model_grad.score(X_train, y_train)
test_grad = model_grad.score(X_test, y_test)

train_svr = wrapper_svr.score(X_train, y_train)
test_svr = wrapper_svr.score(X_test, y_test)

train_knr = model_knr.score(X_train, y_train)
test_knr = model_knr.score(X_test, y_test)

train_reg = model_reg.score(X_train, y_train)
test_reg = model_reg.score(X_test, y_test)

# mae_lin = mean_absolute_error(y_test, y_pred)

#%% Result

fig, ax = plt.subplots()

fruits = ['Linear', 'Descion Tree', 'SVR', 'KNN', 'MLP(NN)']
counts = [test_lin,test_grad,test_svr,test_knr,test_reg]
bar_colors = ['tab:red', 'tab:blue', 'tab:green', 'tab:purple','tab:grey']

ax.bar(fruits, counts, color=bar_colors)

ax.set_ylabel('Testing Score')
ax.set_title('Machine Learning on Pred/Prey Data U-Condition')


plt.show()

#%% Finding three forward Hexagons

# inds1 = knn(x1,cc, 1)

plt.plot(prey_x,prey_y,'.r')
plt.plot(pred_x,prey_y,'.b')








